clc;
load dbfitur.mat; % memanggil dbfitur.mat untuk di load

%MENGAMBIL CIRI GLCM HARALICK 14 FITUR DATA LATIH
fiturTrainX1 = fiturTrain(:,1);
fiturTrainX2 = fiturTrain(:,2);
fiturTrainX3 = fiturTrain(:,3);
fiturTrainX4 = fiturTrain(:,4);
fiturTrainX5 = fiturTrain(:,5);
fiturTrainX6 = fiturTrain(:,6);
fiturTrainX7 = fiturTrain(:,7);
fiturTrainX8 = fiturTrain(:,8);
fiturTrainX9 = fiturTrain(:,9);
fiturTrainX10 = fiturTrain(:,10);
fiturTrainX11 = fiturTrain(:,11);
fiturTrainX12 = fiturTrain(:,12);
fiturTrainX13 = fiturTrain(:,13);
fiturTrainX14 = fiturTrain(:,14);

% PELUANG KOMBINASI 5 FITUR GLCM HARALICK TERBAIK
% lihat gambar grafik untuk menentukan fitur mana yang memiliki hasil rata-rata fitur yang berbeda antar kelasnya
fiturlatihKombinasi  = [fiturTrainX2 fiturTrainX7 fiturTrainX8 fiturTrainX9 fiturTrainX10 fiturTrainX11];

save dbFiturKombinasi.mat % kombinasi fitur terbaik simpan sebagai matriks 
