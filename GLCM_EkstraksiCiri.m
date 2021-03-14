clear all;
close all;
clc;

fiturTrain = []; % array menyimpan nilai fitur Train sementara
folderTrain = ['D:\Project-Matlab\dataset\train'] folder data latih

dirFolder = dir((folderTrain));

for i = 1:length(dirFolder) 
   F_name = dirFolder(i).name; 
   dirFile = dir([folderTrain, '\',F_name,'\*.png']);
   hm = length(dirFile);
   for j = 1:hm % looping get file inside folder
       data(j).file_name = dirFile(j).name;
       data(j).file_location = [folderTrain, '\',F_name,'\',data(j).file_name];
       source = imread(data(j).file_location); % Read All Image PNG
       
       % Parameter GLCM Data Train
       layer = source(:,:,1) % layer warna RGB (1 = RED, 2 = GREEN, 3 = BLUE)
       layerWarna = edge(layer, 'canny'); % edge detection ('canny', 'sobel', 'prewitt')
       source2 = imresize(layer, [100 100]) % resize (128 to 100)
       glcm = graycomatrix(source2, 'Offset', [0 1]); 
       % Jarak Sudut GLCM (D = Jarak tiap Pixel yang dicari)
       % 0'     [0 D] 
       % 45'    [-D D] 
       % 90'    [-D 0]
       % 135'   [-D -D]
       
       
       [haralick] = haralickTextureFeatures(glcm) % ekstraksi fitur GLCM Haralick (14 fitur)
       group = cell(1000, 1); % TOTAL 1000 data
       % label gestur angka pada tangan ==> group(Xawal, Xakhir) = {'X'};
       group(1:250) = {'A'};  % Label Citra A
       group(251:500) = {'B'}; % Label Citra B
       group(501:750) = {'C'}; % Label Citra C
       group(751:1000) = {'D'}; % Label Citra D
       
       % Klasifikasi Data Train (Proses pengenalan ke komputer)
       if(j>= 1 && j <= 250)
           data(j).class = 'A'; % Label Citra A
       elseif(j>=251 && j <= 500)
           data(j).class = 'B'; % Label Citra B
       elseif(j>=501 && j <= 750)
           data(j).class = 'C'; % Label Citra C
       elseif(j>=751 && j <= 1000)
           data(j).class = 'D'; % Label Citra D
       end
       data(j).class = group;
       data(j).ciri = haralick; % Save Ekstraksi ciri GLCM Haralick 
       fiturTrain = [fiturTrain; data(j).ciri]; % Save Hasil Ekstraksi Ciri tiap File Gambar
   end
end

x = struct2table(data); % export data menjadi Tabel
writetable(x, 'EkstraksiCiri.xlsx'); % Export ke Excel
save dbFitur.mat group fiturTrain; % Save Nilai Fitur Train ke dalam dbFitur.mat

disp('Ekstraksi Berhasil')