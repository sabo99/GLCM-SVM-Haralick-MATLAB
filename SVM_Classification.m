clc;
akurasiDB=[]; % membuat array untuk menyimpan nilai akurasi
load('SVM_Model/SVMModel.mat'); % memanggil data latih pada SVMModel
fituruji=[]; % Membuat matriks kosong untuk menampung fitur uji
folder_address = ['D:\Project-Matlab\dataset\test']; % menentukan folder yang berisi file data uji
dir_folder = dir((folder_address)); 
for i_folder = 1:length(dir_folder); %perulangan untuk memanggil setiap file di dalam folder
    folder = dir_folder(i_folder).name;
    dir_file = dir([folder_address,'\',folder,'\*.jpg']); %semua file berformat jpg di panggil
    hm=length(dir_file);
    for i_file = 1:hm %perulangan untuk memanggil semua file berformat jpg
        data(i_file).file_name = dir_file(i_file).name;
        data(i_file).file_address = [folder_address,'\',folder,'\',data(i_file).file_name];
        source = imread(data(i_file).file_address);
        
        % ATUR PARAMETER GLCM DATA UJI DISINI
        % pastikan parameter sama dengan GLCM data latih
        layerWarna1 = source(:,:,2); % atur layer warna RGB (bisa kalian rubah ke ruang warna yang lain)
        layerWarna = edge(layerWarna1,'canny'); % edge detection (gunakan canny, sobel dan prewitt untuk pendeteksi tepi)
        source2= imresize(layerWarna,[120 120]); % merubah dimensi file gambar menjadi 120x120 piksel
        glcm = graycomatrix(source2,'Offset',[0 1]); % atur jarak dan sudut GLCM (0 [0 D] | 45 [-D D] | 90 [-D 0] | 135 [-D -D]), D = jarak

        
        [haralick] = haralickTextureFeatures(glcm); % ekstraksi fitur GLCM Haralick (14 fitur)
        data(i_file).ciri=haralick; % menyimpan ekstraksi ciri GLCM Haralick ke-i
        fituruji=[fituruji; data(i_file).ciri]; % hasil ekstraksi ciri tiap file akan di simpan
    end
end
%MENGAMBIL CIRI GLCM HARALICK 14 FITUR DATA UJI
fiturUjiX1 = fituruji(:,1);
fiturUjiX2 = fituruji(:,2);
fiturUjiX3 = fituruji(:,3);
fiturUjiX4 = fituruji(:,4);
fiturUjiX5 = fituruji(:,5);
fiturUjiX6 = fituruji(:,6);
fiturUjiX7 = fituruji(:,7);
fiturUjiX8 = fituruji(:,8);
fiturUjiX9 = fituruji(:,9);
fiturUjiX10 = fituruji(:,10);
fiturUjiX11 = fituruji(:,11);
fiturUjiX12 = fituruji(:,12);
fiturUjiX13 = fituruji(:,13);
fiturUjiX14 = fituruji(:,14);

% PELUANG KOMBINASI 5 FITUR GLCM HARALICK TERBAIK
% pastikan parameter kombinasi fitur uji sama dengan kombinasi fitur latih (kombinasiFitur.m)
fiturUjiKombinasi  = [fiturUjiX2 fiturUjiX8 fiturUjiX9 fiturUjiX11 fiturUjiX12];

GroupResult = predict(SVMModel,fiturUjiKombinasi); % simpan hasil tebakan komputer
% HITUNG PERSENTASE AKURASI
  groupTruth=cell(9,1); % banyak file data uji
  groupTruth(1:3)={'Daun Pepaya'}; % range file 1 s/d 3 adalah kelas Daun Pepaya
  groupTruth(4:6)={'Daun Jambu'};
  groupTruth(7:9)={'Daun Tabebuya'};
cp = classperf(groupTruth,GroupResult); % membandingkan hasil tebakan komputer yang salah & benar
hasilError = cp.ErrorRate; % menghitung nilai error / salah
Akurasi = (1-hasilError)*100; % rumus akurasi
akurasiDB = [Akurasi];
save akurasi.mat akurasiDB; % menyimpan hasil akurasi ke akurasi.mat