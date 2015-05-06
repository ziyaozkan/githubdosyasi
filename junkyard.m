clear;
Vo=400;  %output voltage of the converter
lg=0.0005;   %airgap length
h1=0.05;
sf=0.85; %stacking factor
hs=0.0025;
la=0.0001;
nu0=4*pi*1e-7;
nuc=400*nu0;    %permeability of the core
nus=200*nu0; %permeability of the sheet
Freq=2769; %required force in N
for k=1:15
    re=k*0.02;  %inner radius, or effective radius
Areq=1;    %such an assignment is done to enter the while loop
A=0;
while (Areq>A)   %while the required area for the coils is greater than 
                 %the current area, increase the current area
h2=re/2;
la=la+0.002;
ra=re+la;
ro=sqrt(re^2+ra^2);
le=2*h1+h2+0.5*(ra+re);
les=0.5*(re+ra);  %effective length of sheet
Rc=le/(nuc*pi*re^2);   %reluctance of the core
Rg=2*lg/(nu0*pi*re^2);   %reluctance of the airgap
Rs=les/(nus*2*pi*les*hs);   %reluctance of the sheet
Rt=Rc+Rg+Rs; % total reluctance
B=sqrt(2*Freq*nu0/(pi*re^2));
flux=B*pi*re^2;
MMF=flux*Rt;
lm=pi*(re+ra);  %mean turn lenth
d=sqrt(22e-9*MMF*lm/Vo);   %diameter of the conductor in m
A=la*h1;   %area of the core
Areq=MMF*pi/sf/8/1e6;   % required area of the coils
N=Areq/(0.25*pi*d^2);  %total turn number
I=MMF/N; %coil current
end
V(k)=pi*ro^2*(h1+h2);
L(k)=I^2*22e-9*N*lm/d^2;
b(k)=B;
i(k)=I;
end
plot(V,0.001*L,V,b,V,i);

la
A
B
MMF
N
I
