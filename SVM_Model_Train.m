% TRAIN SVM
    clc; 
    load dbFiturKombinasi.mat % memanggil dbFiturKombinasi.mat untuk di load (fitur kombinasi terbaik)
    fiturLatihValue = fiturlatihKombinasi; % memanggil nilai fiturlatihKombinasi di dbFiturKombinasi.mat
    TrainingSet= fiturLatihValue; 
    GroupTrain=group; % menentukan kelas data latih terdapat 60 data latih
    u=unique(GroupTrain); % mengambil karakter unik untuk menentukan kelas-kelasnya
    numClasses=length(u); % berapa banyak kelas
    
    % ATUR PARAMETER MULTI-SVM DISINI
    % atur penggunaan kernel (gaussian, linear & polynomial)
    % atur penggunaan coding design (onevsall & onevsone)
    t = templateSVM('Standardize',true,'KernelFunction','gaussian');
    SVMModel = fitcecoc(TrainingSet,GroupTrain,'Learners',t,'Coding','onevsall');
        
    save('SVM_Model/SVMModel.mat'); %menyimpan file hasil latih SVM sebelum di klasifikasikan
