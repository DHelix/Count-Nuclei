clear all

fileNumber=1;
NNList(fileNumber)=0;

for i=1:fileNumber
I=imread(sprintf('N/N%d.tif',i));
Izo1=imread(sprintf('Z/Z%d.tif',i));
outputFileName=sprintf('O/O%d.tif',i);

NNList(i)=CN(I,Izo1,outputFileName); %store nuclei number in a list

clear outputFileName I Izo1

end

xlswrite('output.xlsx',NNList);