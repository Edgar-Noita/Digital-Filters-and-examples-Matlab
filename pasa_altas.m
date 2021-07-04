function filtro=pasa_altas(M,ventana,wc)


%M=40;

n=0:M/2-1;
n2=M/2+1:M;

%ideal filter causal
%wc=0.5*pi;
filtro(1:M/2)=-sin(wc*(n-M/2))./(pi*(n-M/2));
filtro(M/2+2:M+1)=-sin(wc*(n2-M/2))./(pi*(n2-M/2));

filtro(M/2+1)=1-wc/pi;

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
figure
stem(0:M,filtro);
figure
stem(0:M,window);
fft_filtro=fftshift(fft(filtro));
figure
plot(-pi:(2*pi)/length(fft_filtro):pi-(2*pi)/length(fft_filtro),20*log10(abs(fft_filtro)));
xlim([-pi,pi-(2*pi)/256]);
ylim([min(20*log10(abs(fft_filtro))),max(20*log10(abs(fft_filtro)))]);
%title(strcat('Filtro Pasa Altas, F_c',num2str(wc)));
xline(wc);