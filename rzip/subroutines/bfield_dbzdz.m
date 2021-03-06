%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to define the vertical gradient of the vertical magnetic field
% due to a circular filament
% a is radius of filament, b is radius of position, 
% c is separation and cur is filament current.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 function dbzdz = bfield_dbzdz(a,b,c,cur)

% set up constants
 mu0=4e-07*pi;

% ensure matrices are the same orientation
 if(size(a,1)  <size(a,2))  ; a=a'; end;
 if(size(b,1)  <size(b,2))  ; b=b'; end;
 if(size(c,1)  <size(c,2))  ; c=c'; end;
 if(size(cur,1)<size(cur,2)); cur=cur'; end;

% set up a dummy mapping array
 com=ones(size(a)); if(length(cur)==1) ; cur=cur*com; end;


% construct the elliptic integrals
 k2 =  4*a.*b./((a+b).^2 + c.^2);
 k = sqrt(k2);
[K,E] = ellipke(k2); if(min(size(E))>=2);E=E(:,2);K=K(:,2); end;


 r=b;
 z=c;
 ak=k;

 g1=a.*a-r.*r-z.*z;
 g1z=-2.*z;

 g2=(a-r).*(a-r)+z.*z;
 g2z=2.*z;

 g3=(a+r).*(a+r)+z.*z;
 g3z=2.*z;

 akz=(-a.*r.*g3z./(g3.*g3))./sqrt(a.*r./g3);

 Er=E./ak-K./ak;
 Kr=E./(ak.*(com*1.-ak.*ak))-K./ak;

 p1=-1.0e-7*(K+E.*g1./g2).*g3z./g3.^(3./2.);
 p2= 2.0e-7*(E.*g1z./g2-E.*g1.*g2z./(g2.*g2)+(g1.*Er.*akz)./(g2)+(Kr.*akz))./sqrt(g3);

 dbzdz=(p1+p2).*cur;

 clear ak k K E a b c r z g1 g2 g3 g1r g2r g3r akr Er Kr p1 p2

 return;
