//Caption: Speech Noise Cancellation using LMS Adaptive Filter This program is used to perform speech noise cancellation using LMS adaptive filter in scilab

clc;
//Reading a speech signal
[x,Fs,bits]=wavread("C:\Users\kimaya\Desktop\x.wav");
order = 40;  // Adaptive filter order
x = x';
N = length(x);
t = 1:N;
//Plot the speech signal
figure(1)
subplot(2,1,1)
plot(t,x)
title('Noise free Speech Signal')
//Generation of noise signal
noise = 0.1*rand(1,length(x));
//Adding noise with speech signal
for i = 1:length(noise)
    primary(i)= x(i)+noise(i);
end
//Plot the noisy speech signal
subplot(2,1,2)
plot(t,primary)
title('primary = speech+noise (input 1)')
//Reference noise generation
for i = 1:length(noise)
    ref(i)= noise(i)+0.025*rand(10);
end
//Plot the reference noise
figure(2)
subplot(2,1,1)
plot(t,ref)
title('reference noise (input 2)')
//Adaptive filter coefficients initialized to zeros
w = zeros(order,1);
Average_Power = pow_1(x,N)
mu = 1/(10*order*Average_Power); //Adaptive filter step size
//Speech noise cancellation
for k = 1:110
    for i =1:N-order-1
        buffer = ref(i:i+order-1); //current order points of reference
        desired(i) = primary(i)-buffer'*w; // dot product the reference & filter
        w = w+(buffer.*mu*desired(i)); //update filter coefficients
    end
end
//Plot the Adaptive Filter output
subplot(2,1,3)
plot([1:length(desired)],desired)
title('Denoised Speech Signal at Adaptive Filter Output')

//Calculation of Mean Squarred Error between the original speech signal and
//Adaptive filter output
for i =1:N-order-1
    err(i) = x(i)-desired(i);
    square_error(i)= err(i)*err(i);
end
MSE = (sum(square_error))/(N-order-1);
MSE_dB = 20*log10(MSE);
//Playing the original speech signal
sound(x,Fs,16)
//Delay between playing sound signals
for i = 1:1000
    j = 1;
end

//Playing Noisy Speech Signal
sound(primary,Fs,16)
//Delay between playing sound signals
for i = 1:1000
    j = 1;
end

//Playing denoised speech signal (Adaptive Filter Output)
sound(desired,Fs,16)
