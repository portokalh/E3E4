%demean connectivity mats
addpath('/Users/alex/Documents/MATLAB/alex/BCT/2017_01_15_BCT/')
addpath('/Users/alex/Documents/MATLAB/alex/ojwoodford-export_fig-5735e6d/')
runnos={'N54717' 'N54718' 'N54719' 'N54720' 'N54722'  'N54759' 'N54760' 'N54761' 'N54762' 'N54763'  'N54764' 'N54765' 'N54766' 'N54770' 'N54771' 'N54772' 'N54798' 'N54801' 'N54802' 'N54803' 'N54804' 'N54805' 'N54806' 'N54807' 'N54818' 'N54824' 'N54825' 'N54826' 'N54837' 'N54838' 'N54843' 'N54844' 'N54856' 'N54857' 'N54858' 'N54859' 'N54860' 'N54861' 'N54873' 'N54874' 'N54875' 'N54876' 'N54877' 'N54879' 'N54880' 'N54891' 'N54892' 'N54893' 'N54897' 'N54898' 'N54899' 'N54900' 'N54915' 'N54916' 'N54917'};
runnosa=[' N54717' ' N54718' ' N54719' ' N54720' ' N54722'  ' N54759' ' N54760' ' N54761' ' N54762' ' N54763'  ' N54764' ' N54765' ' N54766' ' N54770' ' N54771' ' N54772' ' N54798' ' N54801' ' N54802' ' N54803' ' N54804' ' N54805' ' N54806' ' N54807' ' N54818' ' N54824' ' N54825' ' N54826' ' N54837' ' N54838' ' N54843' ' N54844' ' N54856' ' N54857' ' N54858' ' N54859' ' N54860' ' N54861' ' N54873' ' N54874' ' N54875' ' N54876' ' N54877' ' N54879' ' N54880' ' N54891' ' N54892' ' N54893' ' N54897' ' N54898' ' N54899' ' N54900' ' N54915' ' N54916' ' N54917'];

groups=[4 4 4 4 4 2 2 4 4 4 4 2 4 4 3  3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 4 4 4]
mypath='/Users/alex/brain_data/E3E4/connectunthresh/' ; %N54766.mat
pathfigs=[mypath '/demeaned/figs/'];

mypathin='/Users/alex/brain_data/E3E4/connectunthresh/';
[mylegends,myabbrev]=xlsread([mypathin 'CHASSSYMMETRIC2Legends09072017.xlsx'], 'thetruth', 'B2:B333');
[mylegends2,mynames]=xlsread([mypathin 'CHASSSYMMETRIC2Legends09072017.xlsx'], 'thetruth', 'A2:A333');

[groups_sorted,ind_group]=sort(groups)
groups=groups(ind_group)
runnos=runnos(ind_group)

%%%make file 1
mydegfile=[mypath '/demeaned/' 'avgdegree_BCT1.csv'];
sfid=fopen(mydegfile,'a');
%delete(mydegfile)

%fprintf( sfid, ['%s: ' repmat('%s ' ,1,55),' \n'], 'runno' ,[runnosa(1:end)]);
fprintf(sfid,'runno:\t'); fprintf(sfid,strjoin(runnos,'\t'));fprintf(sfid,'\n');
%fprintf(sfid, ['%s: ' repmat('%d ' ,1,55),' \n'], 'genotype' ,[groups(1:end)]);
fprintf(sfid,'genotype:\t'); fprintf(sfid,'%d\t',groups);fprintf(sfid,'\n');

%%make file 2
myindegfile=[mypath '/demeaned/' 'indegree_BCT1.csv'];
sinfid=fopen(myindegfile,'a');
%delete(mydegfile)

%fprintf( sfid, ['%s: ' repmat('%s ' ,1,55),' \n'], 'runno' ,[runnosa(1:end)]);
fprintf(sinfid,'runno:\t'); fprintf(sinfid,strjoin(runnos,'\t'));fprintf(sinfid,'\n');
%fprintf(sfid, ['%s: ' repmat('%d ' ,1,55),' \n'], 'genotype' ,[groups(1:end)]);
fprintf(sinfid,'genotype:\t'); fprintf(sinfid,'%d\t',groups);fprintf(sinfid,'\n');



%make file 3
myoutdegfile=[mypath '/demeaned/' 'outdegree_BCT1.csv'];
soutfid=fopen(myoutdegfile,'a');
%delete(mydegfile)

%fprintf( sfid, ['%s: ' repmat('%s ' ,1,55),' \n'], 'runno' ,[runnosa(1:end)]);
fprintf(soutfid,'runno:\t'); fprintf(soutfid,strjoin(runnos,'\t'));fprintf(soutfid,'\n');
%fprintf(sfid, ['%s: ' repmat('%d ' ,1,55),' \n'], 'genotype' ,[groups(1:end)]);
fprintf(soutfid,'genotype:\t'); fprintf(soutfid,'%d\t',groups);fprintf(soutfid,'\n');


%now build the files content
mydeg=double(ones(332,55));
myindeg=double(ones(332,55));
myoutdeg=double(ones(332,55));


for n=1:numel(runnos)
    
        n
    runno=runnos{n} ;
       
    fprintf('%s : %d\n' ,runno, groups(n))
    
   
     mydconn=[mypath '/demeaned/' 'd_' runno '.mat'];
     dres=load(mydconn);
     con_demeaned=dres.dres.connectivity;
     [id,od,deg] = degrees_dir(con_demeaned);
     mydeg(:,n)=deg;
     myindeg(:,n)=id;
     myoutdeg(:,n)=od;


end

numroi=size(mydeg); numroi=numroi(1)
for row_number=1:numroi
fprintf(sfid,'degree:\t');  fprintf(sfid,'%d\t',mydeg(row_number,:));fprintf(sfid,'\n');
fprintf(sinfid,'degree:\t');  fprintf(sinfid,'%d\t',myindeg(row_number,:));fprintf(sinfid,'\n');
fprintf(soutfid,'degree:\t');  fprintf(soutfid,'%d\t',myoutdeg(row_number,:));fprintf(soutfid,'\n');
end

fclose(sfid);
fclose(sinfid);
fclose(soutfid);


ind1=find(groups==1);
ind2=find(groups==2);
ind3=find(groups==3);
ind4=find(groups==4);
ind4=ind4([1:9, 11:end])

myvertices=[43 44  51  54  56  65 166  60 55 52 59  62 63 ];
nv=numel(myvertices)


%start take this bit and make it a function to plot ROIs
%28 rank for 3 vs 4 groups is hippocampus roi 51
for i=1:nv
    indroi=myvertices(i)
myHc1_degreew=mydeg(indroi, ind1)'
myHc2_degreew=mydeg(indroi, ind2)'
myHc3_degreew=mydeg(indroi, ind3)'
myHc4_degreew=mydeg(indroi, ind4)'

h = {myHc1_degreew; myHc2_degreew;myHc3_degreew;myHc4_degreew}
hf = figure('Name',char(mynames(indroi)))

cmap=[0 1 0; 0 0 1 ; 1 1 1; 1 0 0]
aboxplot(h, 'labels', mynames(indroi), 'colormap', cmap,'WidthE', .4, 'WidthL', .8, 'WidthS', 1, 'outliermarkersize', 5); % Add a legend); % Advanced box plot

legend('C57y', 'C57o', 'E3','E4')
%legend('$\sigma=2$','$\sigma=4$')


ylabel('Degree_w(#)', 'FontSize', 16, 'FontWeight', 'bold');

set(gca,'FontSize',16,'FontName','FixedWidth', 'FontWeight', 'bold');
%xticklabel_rotate([],90);
fname=char([pathfigs 'Deg' char(mynames(indroi)) '.png'])

saveas(hf, fname,'png');
export_fig(fname, '-png', '-r200');
end
%end take this bit and make it a function to plot ROIs

%start take this bit and make it a function to plot ROIs
%28 rank for 3 vs 4 groups is hippocampus roi 51
for i=1:nv
    indroi=myvertices(i)
myHc1_degreew=myindeg(indroi, ind1)'
myHc2_degreew=myindeg(indroi, ind2)'
myHc3_degreew=myindeg(indroi, ind3)'
myHc4_degreew=myindeg(indroi, ind4)'

h = {myHc1_degreew; myHc2_degreew;myHc3_degreew;myHc4_degreew}
hf = figure('Name',char(mynames(indroi)))

cmap=[0 1 0; 0 0 1 ; 1 1 1; 1 0 0]
aboxplot(h, 'labels', mynames(indroi), 'colormap', cmap,'WidthE', .4, 'WidthL', .8, 'WidthS', 1, 'outliermarkersize', 5); % Add a legend); % Advanced box plot

legend('C57y', 'C57o', 'E3','E4')
%legend('$\sigma=2$','$\sigma=4$')


ylabel('InDegree_w(#)', 'FontSize', 16, 'FontWeight', 'bold');

set(gca,'FontSize',16,'FontName','FixedWidth', 'FontWeight', 'bold');
%xticklabel_rotate([],90);
fname=char([pathfigs 'InDeg' char(mynames(indroi)) '.png'])

saveas(hf, fname,'png');
export_fig(fname, '-png', '-r200');
end
%end take this bit and make it a function to plot ROIs


%start take this bit and make it a function to plot ROIs
%28 rank for 3 vs 4 groups is hippocampus roi 51
for i=1:nv
    indroi=myvertices(i)
myHc1_degreew=myoutdeg(indroi, ind1)'
myHc2_degreew=myoutdeg(indroi, ind2)'
myHc3_degreew=myoutdeg(indroi, ind3)'
myHc4_degreew=myoutdeg(indroi, ind4)'

h = {myHc1_degreew; myHc2_degreew;myHc3_degreew;myHc4_degreew}
hf = figure('Name',char(mynames(indroi)))

cmap=[0 1 0; 0 0 1 ; 1 1 1; 1 0 0]
aboxplot(h, 'labels', mynames(indroi), 'colormap', cmap,'WidthE', .4, 'WidthL', .8, 'WidthS', 1, 'outliermarkersize', 5); % Add a legend); % Advanced box plot

legend('C57y', 'C57o', 'E3','E4')
%legend('$\sigma=2$','$\sigma=4$')


ylabel('OutDegree_w(#)', 'FontSize', 16, 'FontWeight', 'bold');

set(gca,'FontSize',16,'FontName','FixedWidth', 'FontWeight', 'bold');
%xticklabel_rotate([],90);
fname=char([pathfigs 'OutDeg' char(mynames(indroi)) '.png'])

saveas(hf, fname,'png');
export_fig(fname, '-png', '-r200');
end
%end take this bit and make it a function to plot ROIs


