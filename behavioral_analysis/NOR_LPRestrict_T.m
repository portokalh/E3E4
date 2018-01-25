%% read in the concatenated dataset as a table
NOR = readtable('Hand-measured NOR times.xlsx','ReadVariableNames', true);

%% calculate location preference (LP) & recognition index (RI)
func = @(x,y) x/(x+y);

LPresult = rowfun(func,NOR,'OutputVariableNames', 'LP', 'InputVariables', {'Trial1_obj1_time','Trial1_obj2_time'});
NOR = [NOR LPresult];

T2RIresult = rowfun(func,NOR,'OutputVariableNames', 'RI_T2', 'InputVariables', {'Trial2_novel_time','Trial2_familiar_time'});
NOR = [NOR T2RIresult];

T3RIresult = rowfun(func,NOR,'OutputVariableNames', 'RI_T3', 'InputVariables', {'Trial3_novel_time','Trial3_familiar_time'});
NOR = [NOR T3RIresult];

%% prepping data for analysis (normal mice)

data = NOR(:,{'Genotype', 'LP', 'RI_T2','RI_T3'});

vars = {'Genotype', 'Sex', 'LP', 'RI_T2', 'RI_T3'};

E4rows = (strcmp(NOR.Genotype, 'APOE4')&(NOR.LP>0.4 & NOR.LP<0.6));
normalE4 = NOR(E4rows,vars);

E3rows = strcmp(NOR.Genotype, 'APOE3')&(NOR.LP>0.4 & NOR.LP<0.6);
normalE3 = NOR(E3rows,vars);

C57youngrows = (strcmp(NOR.Genotype, 'C57') & (strcmp(NOR.AgeGroup, 'Younger')) &(NOR.LP>0.4 & NOR.LP<0.6));
normalC57_young = NOR(C57youngrows,vars);

C57oldrows = (strcmp(NOR.Genotype, 'C57') & (strcmp(NOR.AgeGroup, 'Older'))&(NOR.LP>0.4 & NOR.LP<0.6));
normalC57_old = NOR(C57oldrows,vars);

%% mean and stdev for each group
nanmean(normalC57_old.LP)
nanstd(normalC57_old.LP)
nanmean(normalC57_young.LP)
nanstd(normalC57_young.LP)
nanmean(normalE3.LP)
nanstd(normalE3.LP)
nanmean(normalE4.LP)
nanstd(normalE4.LP)

nanmean(normalC57_old.RI_T2)
nanstd(normalC57_old.RI_T2)
nanmean(normalC57_young.RI_T2)
nanstd(normalC57_young.RI_T2)
nanmean(normalE3.RI_T2)
nanstd(normalE3.RI_T2)
nanmean(normalE4.RI_T2)
nanstd(normalE4.RI_T2)

nanmean(normalC57_old.RI_T3)
nanstd(normalC57_old.RI_T3)
nanmean(normalC57_young.RI_T3)
nanstd(normalC57_young.RI_T3)
nanmean(normalE3.RI_T3)
nanstd(normalE3.RI_T3)
nanmean(normalE4.RI_T3)
nanstd(normalE4.RI_T3)

%% between genotype comparisons

[h,p,ci,stats] = ttest2(normalC57_old.LP, normalC57_young.LP)
[h,p,ci,stats] = ttest2(normalC57_old.LP, normalE3.LP)
[h,p,ci,stats] = ttest2(normalC57_old.LP, normalE4.LP)
[h,p,ci,stats] = ttest2(normalC57_young.LP, normalE3.LP)
[h,p,ci,stats] = ttest2(normalC57_young.LP, normalE4.LP)
[h,p,ci,stats] = ttest2(normalE3.LP, normalE4.LP)

[h,p,ci,stats] = ttest2(normalC57_old.RI_T2, normalC57_young.RI_T2)
[h,p,ci,stats] = ttest2(normalC57_old.RI_T2, normalE3.RI_T2)
[h,p,ci,stats] = ttest2(normalC57_old.RI_T2, normalE4.RI_T2)
[h,p,ci,stats] = ttest2(normalC57_young.RI_T2, normalE3.RI_T2)
[h,p,ci,stats] = ttest2(normalC57_young.RI_T2, normalE4.RI_T2)
[h,p,ci,stats] = ttest2(normalE3.RI_T2, normalE4.RI_T2)

[h,p,ci,stats] = ttest2(normalC57_old.RI_T3, normalC57_young.RI_T3)
[h,p,ci,stats] = ttest2(normalC57_old.RI_T3, normalE3.RI_T3)
[h,p,ci,stats] = ttest2(normalC57_old.RI_T3, normalE4.RI_T3)
[h,p,ci,stats] = ttest2(normalC57_young.RI_T3, normalE3.RI_T3)
[h,p,ci,stats] = ttest2(normalC57_young.RI_T3, normalE4.RI_T3)
[h,p,ci,stats] = ttest2(normalE3.RI_T3, normalE4.RI_T3)


%% within genotype comparisons
%normalC57_old
[h,p,ci,stats] = ttest2(normalC57_old.LP, normalC57_old.RI_T2)
[h,p,ci,stats] = ttest2(normalC57_old.LP, normalC57_old.RI_T3)
[h,p,ci,stats] = ttest2(normalC57_old.RI_T2, normalC57_old.RI_T3)

%normalC57_young
[h,p,ci,stats] = ttest2(normalC57_young.LP, normalC57_young.RI_T2)
[h,p,ci,stats] = ttest2(normalC57_young.LP, normalC57_young.RI_T3)
[h,p,ci,stats] = ttest2(normalC57_young.RI_T2, normalC57_young.RI_T3)

%normalE3
[h,p,ci,stats] = ttest2(normalE3.LP, normalE3.RI_T2)
[h,p,ci,stats] = ttest2(normalE3.LP, normalE3.RI_T3)
[h,p,ci,stats] = ttest2(normalE3.RI_T2, normalE3.RI_T3)

%normalE4
[h,p,ci,stats] = ttest2(normalE4.LP, normalE4.RI_T2)
[h,p,ci,stats] = ttest2(normalE4.LP, normalE4.RI_T3)
[h,p,ci,stats] = ttest2(normalE4.RI_T2, normalE4.RI_T3)
%% boxplots
     
matrixE4 = table2array(normalE4);
matrixE3 = table2array(normalE3);
matrixC57_old = table2array(normalC57_old);
matrixC57_young = table2array(normalC57_young);
GenAgeGroup = strcat(NOR.Genotype, NOR.AgeGroup);

% between genotype comparisons
b1=figure('Name','LP')
boxplot(NOR.LP, GenAgeGroup)
    xlabel('Group')
    ylabel('Location Preference')
    title('Location Preference for Each Genotype')
    b1.CurrentAxes.YLim=[0 1]
saveas(b1,'LP_restrict','png')
    
b2=boxplot(NOR.RI_T2, GenAgeGroup)
boxplot(NOR.RI_T2, GenAgeGroup)
    xlabel('Group')
    ylabel('Recognition Index')
    title('Short-term Recognition Index for each Genotype')
    b1.CurrentAxes.YLim=[0 1]
saveas(b1,'RI_T2_restrict','png')


b3=boxplot(NOR.RI_T3, GenAgeGroup)
boxplot(NOR.RI_T3, GenAgeGroup)
    xlabel('Group')
    ylabel('Recognition Index')
    title('Long-term Recognition Index for each Genotype')
    b1.CurrentAxes.YLim=[0 1]
saveas(b1,'RI_T3_restrict','png')

% within genotype comparisons
h1=figure('Name','C57_old')
boxplot(matrixC57_old, 'Labels', {'LP','RI_T2','RI_T3'})
    xlabel('Measure')
    ylabel('Object Preference')
    title('Measures for old C57 Mice')
    h1.CurrentAxes.YLim=[0 1]
saveas(h1,'C57_old_restrict','png')
    
h2=figure('Name','C57_young')
boxplot(matrixC57_young, 'Labels', {'LP','RI_T2','RI_T3'})
    xlabel('Measure')
    ylabel('Object Preference')
    title('Measures for young C57 Mice')
    h2.CurrentAxes.YLim=[0 1]
saveas(h2,'C57_young_restrict','png')

h3=figure('Name','APOE3')
boxplot(matrixE3, 'Labels', {'LP','RI_T2','RI_T3'})
    xlabel('Measure')
    ylabel('Object Preference')
    title('Measures for APOE3 Mice')
    h3.CurrentAxes.YLim=[0 1]
saveas(h3,'E3_restrict','png')
    
h4=figure('Name','APOE4')
boxplot(matrixE4, 'Labels', {'LP','RI_T2','RI_T3'})
    xlabel('Measure')
    ylabel('Object Preference')
    title('Measures for APOE4 Mice')
    h4.CurrentAxes.YLim=[0 1]
saveas(h4,'E4_restrict','png')
    
