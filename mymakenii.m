%make nii for E3 and E4

RARE_runno={'B05215','B05220','B05225','B05230','B05235','B05240','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05320','B05325','B05330','B05335','B05340','B05346','B05350','B05355','B05360','B05365','B05370','B05375','B05380','B05385','B05390','B05395','B05400','B05405','B05410','B05415','B05420','B05425','B05430','B05435','B05440','B05445','B05450','B05455','B05460','B05465','B05470','B05475','B05480'}
GRE_runno={'B05216','B05221','B05226','B05231','B05236','B05241','B05251','B05256','B05266','B05271','B05276','B05281','B05286','B05291','B05296','B05301','B05306','B05311','B05316','B05321','B05326','B05331','B05336','B05341','B05347','B05351','B05356','B05361','B05366','B05371','B05376','B05381','B05386','B05391','B05396','B05401','B05406','B05411','B05416','B05421','B05426','B05431','B05436','B05441','B05446','B05451','B05456','B05461','B05466','B05471','B05476','B05481', 'B05342'}
GRE_runno2={'B05342'}
    
sfid=fopen('/Volumes/CivmUsers/omega/Documents/MATLAB/michele/michelemovesfile.sh' 

shebang='#!/bin/bash' 
fprintf(sfid,'%s\n' ,shebang)
for i=1 %1:numel(GRE_runno)
     mypathin=['/Volumes/cretespace/' char(GRE_runno{i}) '.work']
     mypathout=['/Volumes/omega/alex/E3E4_GRE_work']
     mycmd=['scp ' mypathin ' ' mypathout]
     fprintf(sfid, '%s;\n',mycmd);
end

for i=1:numel(RARE_runno)
mypath=['/Volumes/cretespace/' RARE_runno{i} '/' RARE_runno{i} 'images/']
out_nii=['/Volumes/cretespace/alex/E3E4/invivo_rare/' RARE_runno{i} '.nii.gz'];
vsize=0.1
dimx=200;
dimy=180;
dimz=100;
file_name=[RARE_runno{i} 'bt7imx.0']
file_ext='raw'
flipx=0
flipz=0
startzcrop=1
endzcrop=100
roll_string='0:0'

%civm_to_nii(img_dir, file_name, file_ext, out_nii, dimx, dimy, dimz, format, vsize, vsize,vsize, flipx, flipz, startzcrop, endzcrop, roll_string)
civm_to_nii(mypath, file_name, file_ext, out_nii, dimx, dimy, dimz, 512, vsize, vsize,vsize, flipx, flipz, startzcrop, endzcrop, roll_string)


end