function [t,expN,expB,NLog,infor]=Experimental_data(pick_experiments,det_lim)
df = 2; % dilution factor

j=1;
%1st: 40ppm, 8 log
data_N{1}=[9.06e07 4.51e06 2.02e06 4.72e04 4.00e04]/df;
data_B{1}=[45.51 13.37 9.89 10.22 11.73];
t_s{1}=[0 1 2 5 10];
infor{1}='1st: 40ppm, 8log';

j=2;
%2nd:40ppm, 10log
data_N{j}=[6.25e08 4.74e08 5.28e08 4.85e08 6.00e8]/df;
data_B{j}=[45.5 11.5 8.4 8.1 8.7];
t_s{j}=[0 1 2 5 10];
infor{j}='2nd:40ppm, 10log';

j=3;
%3th:50ppm, 8log
data_N{j}=[6.54e7 2.40e02 5.30e02 0 0]/df;
data_B{j}=[51.23 29.32 29.00 26.78 27.86];
t_s{j}=[0 1 2 5 10];
infor{j}='3th:50ppm,8log';

j=4;
%4th:50ppm, 9log
data_N{j}=[6.72e08 2.78e03 1.70e02 0.00e00 0.00e00]/df;
data_B{j}=[54.27 9.35 14.17 14.49 7.93];
t_s{j}=[0 1 2 5 10];
infor{j}='4th:50ppm,9log';

j=5;
%5th:60ppm,6log
data_N{j}=([9.00e6 0 0 0 0])/df;
data_B{j}=[52.78 40.28 40.36 40.15 40.1];
t_s{j}=[0 1 2 5 10];
infor{j}='5th:60ppm,6log';


%Loop through all experiments to return a matrix
cont=0;
for ii=pick_experiments
    cont=cont+1;
    t{cont}=[t_s{ii}];
    expN{cont}= data_N{ii}';
    expB{cont}=data_B{ii};
    NLog{cont}=log10(data_N{ii}(:)');
    NLog{cont}(NLog{cont}<det_lim)=det_lim;
end
end
