function filtro=pasa_bandas(M,ventana,wc1,wc2)

%M=40;

n=0:M/2-1;
n2=M/2+1:M;

%ideal filter causal

%wc1=0.25*pi;
%wc2=0.5*pi;
filtro(1:M/2)=sin(wc2*(n-M/2))./(pi*(n-M/2))-sin(wc1*(n-M/2))./(pi*(n-M/2));
filtro(M/2+2:M+1)=sin(wc2*(n2-M/2))./(pi*(n2-M/2))-sin(wc1*(n2-M/2))./(pi*(n2-M/2));

filtro(M/2+1)=wc2/pi-wc1/pi;

%window=hanning(M+1);
if (strcmp(ventana,'hanning'))
    window=hanning(M+1);
else
    if (strcmp(ventana,'hamming'))
        window=hamming(M+1);
    else
        if (strcmp(ventana,'rect'))
           window=rectwin(M+1);
        else
            if (strcmp(ventana,'blackman'))
               window=blackman(M+1);
            else
                if (strcmp(ventana,'bartlett'))
                    window=bartlett(M+1);
                end
            end
        end
    end
end
filtro=filtro.*window';

stem(0:M,filtro);
figure
stem(0:M,window);
fft_filtro=fftshift(fft(filtro,1024));
figure
plot(-pi:(2*pi)/1024:pi-(2*pi)/1024,20*log10(abs(fft_filtro)));
xlim([-pi,pi-(2*pi)/256]);
ylim([min(20*log10(abs(fft_filtro))),max(20*log10(abs(fft_filtro)))]);

%xline(wc1);
%xline(wc2);