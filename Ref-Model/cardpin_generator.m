%% For Ram (Generating Credit available & setting up_limit for withdrawal )
clc;
clear;
rng(5);
depth_RAM=64;
credit_available=[];
up_limit=30000*ones(depth_RAM,1);
for i=(1:depth_RAM)
credit_available(i)=randi([10000000 33554432],1,1);
end
credit_available=credit_available';
ram=[up_limit,credit_available];

%% Preparing ROM
depth_ROM=64;
num_of_invalid_users=8;
ref_password=[];
valid_bit=ones(depth_ROM,1);
for i=(1:depth_ROM)
ref_password(i)=randi([1000,9999],1,1);
end
for i=1:num_of_invalid_users
k=randi(64,1,1);
valid_bit(k)=0;
end
ref_password=ref_password';
ref_password_rtl = num2str(ref_password) - '0'
rom=[ref_password,valid_bit];


%% 
ref_password_rtl1=dec2bin(ref_password_rtl(:,1));
ref_password_rtl2=dec2bin(ref_password_rtl(:,2));
ref_password_rtl3=dec2bin(ref_password_rtl(:,3));
ref_password_rtl4=dec2bin(ref_password_rtl(:,4));
ref_password_rtl=[ref_password_rtl1,ref_password_rtl2,ref_password_rtl3,ref_password_rtl4];
rom_rtl=[ref_password_rtl,num2str(valid_bit)];
up_limit_rtl=dec2bin(up_limit);
available_credit_rtl=dec2bin(credit_available);
ram_rtl=[up_limit_rtl,available_credit_rtl];

%% Writting Files for RTL
fileID1 = fopen(['ram.txt'], 'w');
fileID2 = fopen(['rom.txt'], 'w');
for i = 1 : depth_RAM
    if i == depth_RAM
      fprintf(fileID1, '%s', ram_rtl(i, :));
      fprintf(fileID2, '%s', rom_rtl(i,:));
    else
         fprintf(fileID1,'%s\n', ram_rtl(i, :));
      fprintf(fileID2, '%s\n', rom_rtl(i, :));
      
    end
end
fclose(fileID1);
fclose(fileID2);
%% Writting Files for cpp
fileID3 = fopen(['check_card.txt'], 'w');
fileID4 = fopen(['credit_file.txt'], 'w');
for i = 1 : depth_RAM
    if i == depth_RAM
      fprintf(fileID3, '%d %d', ram(i, 1),ram(i, 2));
      fprintf(fileID4, '%d %d', rom(i, 1),rom(i,2));

     
    else
         fprintf(fileID3, '%d %d\n', ram(i, 1),ram(i, 2));
      fprintf(fileID4, '%d %d\n', rom(i, 1),rom(i,2));
   
      
    end
end
fclose(fileID3);
fclose(fileID4);
%% Calling Python Script
system('python rom_gen.py');