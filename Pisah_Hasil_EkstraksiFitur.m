clc;
load dbfitur.mat; % memanggil dbfitur.mat untuk di load

%MENGAMBIL CIRI GLCM HARALICK PER DATA LATIH KELAS
for i = 1:14 % pengulangan karena terdapat 14 fitur GLCM
    latih1_fitur1 = fiturTrain(1:250,i); % mengambil fitur ke-i data latih kelas 1 ada pada range 1 s/d 250
    latih2_fitur1 = fiturTrain(251:500,i);
    latih3_fitur1 = fiturTrain(501:750,i);
    latih4_fitur1 = fiturTrain(751:1000,i);
    latih1_fitur1RataRata = mean(latih1_fitur1); % nilai rata-rata (Average) fitur kelas 1
    latih2_fitur1RataRata = mean(latih2_fitur1);
    latih3_fitur1RataRata = mean(latih3_fitur1);
    latih4_fitur1RataRata = mean(latih4_fitur1);
    x = 1:4; % ada 4 kelas

    % menampilkan chart / grafik, perbedaan nilai fitur tiap kelas
    chart = bar(x, [latih1_fitur1RataRata, latih2_fitur1RataRata, latih3_fitur1RataRata, latih4_fitur1RataRata]); 
    saveas(chart,sprintf('ChartEkstraksi_Fitur/fitur%d.jpg',i)); % menyimpan chart/grafik untuk proses perbandingan fitur terbaik sebagai data latih acuan klasifikasi
end