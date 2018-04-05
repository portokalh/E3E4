function mynet=getvprops(mypath,myrunno,myroino)
%reads 332 labels
% % myroino=332
% % myrunno='N54900'
% % mypath='/Users/alex/brain_data/E4E3/connectivitymats/'
%fname='/Users/alex/brain_data/E4E3/connectivitymats/N54900/N54900netprops.txt'


fname=char(strcat(mypath, '/', myrunno, '/', myrunno, 'netprops.txt'))
mynet=0;
fileID = fopen(fname,'r');
%[myone, count]=fscanf(fileID,'%s %4.4f');
for i=1:20
tline1 = fgetl(fileID);
ftell(fileID)
end

counter=1
for i=21:34
    
    tline2 = fgetl(fileID);
    res=strsplit(tline2);
  for k=2:333
    mynet(counter,k-1)=str2num(char(res{k}));
  end
    counter=counter+1;
    ftell(fileID)
end
  
    
fclose(fileID);
