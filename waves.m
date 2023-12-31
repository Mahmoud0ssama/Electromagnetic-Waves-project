clc ;
clear ;
close all ;
Lamda = 3.6*10^(-6) ;
k=2*pi/Lamda ;
Wo = 30*10^(-6) ;
dx = (sqrt(2)*pi)/k ;
Axis_limit = 200*dx ;
x_axis = -Axis_limit+dx:dx:Axis_limit ;
y_axis = x_axis ;
[X,Y] = meshgrid(x_axis,y_axis) ;
U_r=exp(-(X.^2+Y.^2)/Wo^2) ;

%% System in spatial frequency domain using spatial Fourier transform
U_kxky = fftshift(fft2(U_r)) ;
dkx = pi/Axis_limit ;
Kx = 2*pi/dx ;
Kx_axis = -Kx/2+dkx:dkx:Kx/2 ;
Ky_axis = Kx_axis ;
[KXX,KYY] = meshgrid(Kx_axis,Ky_axis) ;
Kz = k-((KXX.^2+KYY.^2)/(2*k)) ;

%% propagation a certain z (0,Zo,2Zo)
Zo=pi*(Wo.^2)/Lamda;

for n=0:1:2
Uz_kxky = U_kxky.* exp(-1.*1i.*Kz.*Zo.*n) ;
Uz_r = ifft2(ifftshift(Uz_kxky)) ;
if n==2 
    Uz_2Zo = Uz_r ;
end
I = abs(Uz_r(200,:)) ;
Io = 1/754 ;

figure ()
imagesc(abs(Uz_r)) ;
colorbar ;
xlabel('X(m)') ;
ylabel('Y(m)') ;
title(['Intensity at ' num2str(n) '*Zo']) ;

%2d
figure ;
plot(x_axis,I) ;
xlabel('X(m)') ;
ylabel('intensity(w/m^2)');
title(['Plane of Gaussian Beam at ' num2str(n) '*Zo']);

%3d
figure ;
surf(X,Y,abs(Uz_r), 'EdgeColor', 'none');
xlabel('X(m)') ;
ylabel('intensity(w/m^2)');
title(['Plane of Gaussian Beam at ' num2str(n) '*Zo']);
end

f = 0.5 * Zo ;
T_r = exp(1i*(k/(2*f))*(X.^2 + Y.^2));
%% After Lens
f = 0.5 * Zo;
Uout_r = Uz_2Zo.*T_r;
Uout_kxky = fftshift(fft2(Uout_r));

%% Transmitting through lens at different distances (0.5f, f, 2f)
for n = [0.5, 1, 2]
    UoutZ_kxky = Uout_kxky .* exp(-1i * Kz * n * f);
    UoutZ_r = ifft2(ifftshift(UoutZ_kxky));
    LENS = abs(UoutZ_r);
    
    % Plotting intensity profile after lens
    %2d
    figure;
    plot(x_axis, LENS(200, :));
    xlabel('X(m)');
    ylabel('Intensity(w/m^2)');
    title(['Plane of Gaussian Beam transmitted from Lens at ' num2str(n) ' f']);
    
    %3d
    figure ;
    surf(X,Y,LENS, 'EdgeColor', 'none');
    xlabel('X(m)') ;
    ylabel('intensity(w/m^2)');
    title(['Plane of Gaussian Beam transmitted from Lens at ' num2str(n) ' f']);
    figure ()
    imagesc(abs(UoutZ_r)) ;
    colorbar ;
    xlabel('X(m)') ;
    ylabel('Y(m)') ;
    title(['Intensity at ' num2str(n) 'f']) 

end