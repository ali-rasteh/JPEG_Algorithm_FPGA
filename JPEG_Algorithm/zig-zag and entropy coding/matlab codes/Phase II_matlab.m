% phase 1 matlab code of ASIC & FPGA project
%%%%%%%%%%%%%%%Main code%%%%%%%%%%%%%%%%%%%%%%
clc,clear all,close all

% reading image from file
image=zeros(1,2,3);
image(end,end-1,1)=8;


% making multiply of 8

rows=ceil(size(image,1)/8);
cols=ceil(size(image,1)/8);
rows=max(rows,cols);
new_img=zeros(8*rows,8*rows,3);     %zero padding the image
new_img(1:size(image,1),1:size(image,2),:)=image;


Y_DPCM = zeros(rows *rows ,1);
cr_DPCM = zeros(rows *rows ,1);
cb_DPCM = zeros(rows *rows ,1);
pre_Y_DC=0;
pre_cr_DC=0;
pre_cb_DC=0;

Y_RLE = zeros(64*rows*rows , 1);
cr_RLE = zeros(64*rows*rows , 1);
cb_RLE = zeros(64*rows*rows , 1);

Y_RLE_index=1;
cr_RLE_index=1;
cb_RLE_index=1;

%making 8*8 blocks
Y_Q_end=zeros(8*rows,8*rows,3);
cb_Q_end=zeros(8*rows,8*rows,3);
cr_Q_end=zeros(8*rows,8*rows,3);


for i=1:1:rows
    for j=1:1:rows
 
%making a 8*8 block named img          
image_block = zeros(8,8,3);     
image_block = new_img((i-1)*8+1:8*i,(j-1)*8+1:8*j,: );


img_Ycbcr = rgb2ycbcr(image_block);
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

img_Quant=zeros(8,8,3);
img_Quant(:,:,1)=Y_Quant;
img_Quant(:,:,2)=cb_Quant;
img_Quant(:,:,3)=cr_Quant;



y_Q_end((i-1)*8+1:8*i,(j-1)*8+1:8*j)=Y_Quant;
cb_Q_end((i-1)*8+1:8*i,(j-1)*8+1:8*j)=cb_Quant;
cr_Q_end((i-1)*8+1:8*i,(j-1)*8+1:8*j)=cr_Quant;


Y_zigzag = zigzag(Y_Quant);
cr_zigzag = zigzag(cr_Quant);
cb_zigzag = zigzag(cb_Quant);

% DPCM processes similar to verilog codes
Y_DPCM(i,j) = Y_zigzag(1,1) - pre_Y_DC;
pre_Y_DC = Y_zigzag(1,1);
cr_DPCM(i,j) = cr_zigzag(1,1) - pre_cr_DC;
pre_cr_DC = cr_zigzag(1,1);
cb_DPCM(i,j) = cb_zigzag(1,1) - pre_cb_DC;
pre_cb_DC = cb_zigzag(1,1);


Y_zero_num=0;
cr_zero_num=0;
cb_zero_num=0;
counter=0;

Y_zero_flag=0;
cr_zero_flag=0;
cb_zero_flag=0;

% RLE processing similar to verilog codes
for k=2:1:65
    if(counter==63)
        Y_RLE(Y_RLE_index)=0;
        Y_RLE_index=Y_RLE_index+1;
        counter=0;
    elseif( Y_zigzag(k) == 0)
        Y_zero_num = Y_zero_num+1;
        counter=counter+1;
    elseif(Y_zero_num > 15)
        Y_RLE(Y_RLE_index) = 15360 ;
        Y_RLE_index = Y_RLE_index + 1;
        Y_zero_num = Y_zero_num - 15;
        Y_RLE(Y_RLE_index) = Y_zero_num*1024 + Y_zigzag(k);
        Y_RLE_index = Y_RLE_index + 1;
        Y_zero_flag=1;
        counter=counter+1;
    else
        Y_RLE(Y_RLE_index) = Y_zero_num*1024 + Y_zigzag(k);
        Y_RLE_index=Y_RLE_index+1;
        Y_zero_num = 0;
        Y_zero_flag=0;
        counter=counter+1;
    end
end


for k=2:1:65
    if(counter==63)
        cr_RLE(cr_RLE_index)=0;
        cr_RLE_index=cr_RLE_index+1;
        counter=0;
    elseif( cr_zigzag(k) == 0)
        cr_zero_num = cr_zero_num+1;
        counter=counter+1;
    elseif(cr_zero_num > 15)
        cr_RLE(cr_RLE_index) = 15360 ;
        cr_RLE_index = cr_RLE_index + 1;
        cr_zero_num = cr_zero_num - 15;
        cr_RLE(cr_RLE_index) = cr_zero_num*1024 + cr_zigzag(k);
        cr_RLE_index = cr_RLE_index + 1;
        cr_zero_flag=1;
        counter=counter+1;
    else
        cr_RLE(cr_RLE_index) = cr_zero_num*1024 + cr_zigzag(k);
        cr_RLE_index=cr_RLE_index+1;
        cr_zero_num = 0;
        cr_zero_flag=0;
        counter=counter+1;
    end
end


for k=2:1:65
    if(counter==63)
        cb_RLE(cb_RLE_index)=0;
        cb_RLE_index=cb_RLE_index+1;
        counter=0;
    elseif( cb_zigzag(k) == 0)
        cb_zero_num = cb_zero_num+1;
        counter=counter+1;
    elseif(cb_zero_num > 15)
        cb_RLE(cb_RLE_index) = 15360 ;
        cb_RLE_index = cb_RLE_index + 1;
        cb_zero_num = cb_zero_num - 15;
        cb_RLE(cb_RLE_index) = cb_zero_num*1024 + cb_zigzag(k);
        cb_RLE_index = cb_RLE_index + 1;
        cb_zero_flag=1;
        counter=counter+1;
    else
        cb_RLE(cb_RLE_index) = cb_zero_num*1024 + cb_zigzag(k);
        cb_RLE_index=cb_RLE_index+1;
        cb_zero_num = 0;
        cb_zero_flag=0;
        counter=counter+1;
    end
end


end
end