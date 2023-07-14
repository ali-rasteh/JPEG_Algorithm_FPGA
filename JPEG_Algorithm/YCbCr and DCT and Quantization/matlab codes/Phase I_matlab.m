% phase 1 matlab code og ASIC & FPGA project
%%%%%%%%%%%%%%%Main code%%%%%%%%%%%%%%%%%%%%%%
clc,clear all,close all

% reading image from file
imag=zeros(1,2,3);
imag(end,end-1,1)=8;

% making multiply of 8

a=ceil(size(imag,1)/8);
b=ceil(size(imag,1)/8);
a=max(a,b);
new_img=zeros(8*a,8*a,3);
new_img(1:size(imag,1),1:size(imag,2),:)=imag;

%making 8*8 blocks
Y_Q_end=zeros(8*a,8*a,3);
cb_Q_end=zeros(8*a,8*a,3);
cr_Q_end=zeros(8*a,8*a,3);


for i=1
    for j=1
 
%making a 8*8 block named img          
img=zeros(8,8,3);     
img=new_img((i-1)*8+1:8*i,(j-1)*8+1:8*j,: );


img_Ycbcr = rgb2ycbcr(img);
Y=img_Ycbcr(:,:,1);
cb=img_Ycbcr(:,:,2);
cr=img_Ycbcr(:,:,3);

%downsampling
% for i=1:2:size(cb,1)
%     for j=1:2:size(cb,2)
%         cb(i,j)=0;
%         cr(i,j)=0;        
%     end
% end

% dct2:
Y_dct=dct2(Y);
cb_dct=dct2(cb);
cr_dct=dct2(cr);

%packing in one matrix
img_dct=zeros(8,8,3);
img_dct(:,:,1)=Y_dct;
img_dct(:,:,2)=cb_dct;
img_dct(:,:,3)=cr_dct;

% tables for quantization
lum_table=[16 , 11 , 10 , 16 , 24 ,  40 ,  51 ,  61;   
12 , 12 , 14 , 19 , 26   58 ,60  , 55 ;  
14  ,13,  16 , 24 , 40 ,  57 , 69 ,  56  ; 
14,  17,  22 , 29 , 51 ,  87 ,80  , 62   ;
18 , 22,  37 , 56 , 68 ,  109, 103 , 77  ; 
24  ,35,  55 , 64 , 81,   104 , 113 , 92   ;
49 , 64 , 78  ,87 , 103 , 121 ,120 , 101 ; 
72 , 92  ,95 , 98 , 112  ,100 , 103 , 99  ];

chrom_table=[17,18,24,47,99,99,99,99;
18 	21 	26 	66 	99 	99 	99 	99;
24 	26 	56 	99 	99 	99 	99 	99;
47 	66 	99 	99 	99 	99 	99 	99;
99 	99 	99 	99 	99 	99 	99 	99;
99 	99 	99 	99 	99 	99 	99 	99;
99 	99 	99 	99 	99 	99 	99 	99;
99 	99 	99 	99 	99 	99 	99 	99];

%giving the answer of process
Y_Quant=round(Y_dct./lum_table);
cb_Quant=round(cb_dct ./chrom_table);
cr_Quant=round(cr_dct ./chrom_table);

y_Q_end((i-1)*8+1:8*i,(j-1)*8+1:8*j)=Y_Quant;
cb_Q_end((i-1)*8+1:8*i,(j-1)*8+1:8*j)=cb_Quant;
cr_Q_end((i-1)*8+1:8*i,(j-1)*8+1:8*j)=cr_Quant;

    end
end


