%see connectivity
%14 apoe4
%10 apoe3
%10 y c57
%10 o C57


runnos={'N54717' 'N54718' 'N54719' 'N54720' 'N54722'  'N54759' 'N54760' 'N54761' 'N54762' 'N54763'  'N54764' 'N54765' 'N54766' 'N54770' 'N54771' 'N54772' 'N54798' 'N54801' 'N54802' 'N54803' 'N54804' 'N54805' 'N54806' 'N54807' 'N54818' 'N54824' 'N54825' 'N54826' 'N54837' 'N54838' 'N54843' 'N54844' 'N54856' 'N54857' 'N54858' 'N54859' 'N54860' 'N54861' 'N54873' 'N54874' 'N54875' 'N54876' 'N54877' 'N54879' 'N54880' 'N54891' 'N54892' 'N54893' 'N54897' 'N54898' 'N54899' 'N54900' 'N54915' 'N54916' 'N54917'};
groups=[4 4 4 4 4 2 2 4 4 4 4 2 4 4 3  3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 4 4 4]
mypath='/Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/connectivitymats/pics/'

ind1=find(groups==1);
ind2=find(groups==2);
ind3=find(groups==3);
ind4=find(groups==4);

%for n =1:55
figure(1)
for n=1:40
    if i<11
        
    runno=runnos{n} ;
    groups(n);
    
    fprintf('%s : %d\n' ,runno, groups(n))
    
    subplot(
     myconn=['/Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/connectivitymats/' runno '/' runno 'con.mat'];
     res=load(myconn);
     mymat=res.connectivity;
%     find(mymat);
subplot(5,10,[1,i]);imagesc(log10(mymat)))
%     imagesc(log10(mymat))
%     caxis([0 5])
%     %max(max(log10(mymat)))
%     title(runno)
%     colormap(jet)
%     filename = strcat(mypath, runno, '_conmat.png');
%     print(filename,'-dpng','-r300');
%     
end  


