%demean connectivity mats

runnos={'N54717' 'N54718' 'N54719' 'N54720' 'N54722'  'N54759' 'N54760' 'N54761' 'N54762' 'N54763'  'N54764' 'N54765' 'N54766' 'N54770' 'N54771' 'N54772' 'N54798' 'N54801' 'N54802' 'N54803' 'N54804' 'N54805' 'N54806' 'N54807' 'N54818' 'N54824' 'N54825' 'N54826' 'N54837' 'N54838' 'N54843' 'N54844' 'N54856' 'N54857' 'N54858' 'N54859' 'N54860' 'N54861' 'N54873' 'N54874' 'N54875' 'N54876' 'N54877' 'N54879' 'N54880' 'N54891' 'N54892' 'N54893' 'N54897' 'N54898' 'N54899' 'N54900' 'N54915' 'N54916' 'N54917'};
groups=[4 4 4 4 4 2 2 4 4 4 4 2 4 4 3  3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 4 4 4]
mypath='/Users/alex/brain_data/E3E4/connectunthresh/' ; %N54766.mat

for n=1:numel(runnos)
    
        
    runno=runnos{n} ;
       
    fprintf('%s : %d\n' ,runno, groups(n))
    
   
     myconn=[mypath runno '.mat'];
     mydconn=[mypath '/demeaned/' 'd_' runno '.mat'];
     res=load(myconn);
     dres=res;
     con_demeaned=res.connectivity./repmat(sum(res.connectivity),332,1);
     dres.connectivity=con_demeaned;
     save(mydconn,'dres')
     
     figure(1)
     subplot(1,2,1)
     imagesc(log10(res.connectivity))
     subplot(1,2,2)
     imagesc(log10(dres.connectivity))
     colormap(jet)
    
     filename = strcat(mypath, runno ,'_conn_dcon_mat.png'); 
     print(filename,'-dpng','-r300');
     

end

% % subplot(1,2,1)
% % imagesc(log10(res.connectivity))
% % subplot(1,2,2)
% % imagesc(log10(dres.connectivity))
% % colormap(jet)