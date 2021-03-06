%Hybrid Scanline Filter Calculator

Brights = [110 115 120 125 130];
Levels = [90 85 80 75 70 65 60 50 40 30 20 10];

%%This is the filter kernel.  It's a modified Gaussian
fkernel = inline ("exp(Sigma*abs(x)^p)","x","Sigma","p");

%These are  the Horizontal Filter Coefficients
%They are Gaussian Sharp 05 but could be anything

%The first version of V4 soft filter
%CHorz=[
%      -5, 138,  -5,   0
%      -7, 136,  -1,   0
%      -9, 132,   5,   0
%     -10, 126,  12,  -0
%     -10, 117,  22,  -1
%     -10, 107,  33,  -2
%      -9,  95,  45,  -3
%      -8,  84,  57,  -5
%      -6,  70,  70,  -6
%      -5,  58,  83,  -8
%      -3,  45,  95,  -9
%      -2,  33, 107, -10
%      -1,  22, 117, -10
%      -0,  12, 126, -10
%       0,   5, 132,  -9
%       0,  -1, 136,  -7 ];

CHorz=[
   -7, 142,  -7,   0
   -9, 141,  -4,   0
  -10, 137,   1,   0
  -11, 131,   8,   0
  -10, 121,  17,  -0
   -9, 110,  28,  -1
   -8,  97,  41,  -2
   -6,  82,  55,  -3
   -5,  69,  69,  -5
   -3,  54,  83,  -6
   -2,  41,  97,  -8
   -1,  28, 110,  -9
   -0,  17, 121, -10
    0,   8, 131, -11
    0,   1, 137, -10
    0,  -4, 141,  -9];


Bicubic=[  0, 128,   0,  0
 -4, 127,   5,  0
 -6, 123,  12, -1
 -8, 118,  20, -2
 -9, 111,  29, -3
 -9, 102,  39, -4
 -9,  93,  50, -6
 -9,  83,  61, -7
 -8,  72,  72, -8
 -7,  61,  83, -9
 -6,  50,  93, -9
 -4,  39, 102, -9
 -3,  29, 111, -9
 -2,  20, 118, -8
 -1,  12, 123, -6
  0,   5, 127, -4];

GS4=[   0, 128,   0,   0
   0, 127,   1,   0
   0, 126,   2,   0
   0, 124,   4,   0
   0, 121,   7,   0
   0, 114,  14,   0
   0, 102,  26,   0
   0,  85,  43,   0
   0,  64,  64,   0
   0,  43,  85,   0
   0,  26, 102,   0
   0,  14, 114,   0
   0,   7, 121,   0
   0,   4, 124,   0
   0,   2, 126,   0
   0,   1, 127,   0];
   
GS5=[   0, 128,   0,   0
   0, 128,   0,   0
   0, 128,   0,   0
   0, 127,   1,   0
   0, 126,   2,   0
   0, 122,   6,   0
   0, 113,  15,   0
   0,  94,  34,   0
   0,  64,  64,   0
   0,  34,  94,   0
   0,  15, 113,   0
   0,   6, 122,   0
   0,   2, 126,   0
   0,   1, 127,   0
   0,   0, 128,   0
   0,   0, 128,   0];
GS2=[  5, 118,   5,   0
  3, 117,   8,   0
  2, 115,  11,   0
  2, 110,  16,   0
  1, 105,  22,   0
  1,  97,  30,   0
  0,  88,  40,   0
  0,  76,  52,   0
  0,  64,  64,   0
  0,  52,  76,   0
  0,  40,  88,   0
  0,  30,  97,   1
  0,  22, 105,   1
  0,  16, 110,   2
  0,  11, 115,   2
  0,   8, 117,   3
];   
GS1=[
   9, 110,   9,   0
   7, 108,  13,   0
   5, 106,  17,   0
   3, 103,  22,   0
   2,  98,  28,   0
   2,  90,  36,   0
   1,  83,  44,   0
   1,  73,  54,   0
   0,  64,  64,   0
   0,  54,  73,   1
   0,  44,  83,   1
   0,  36,  90,   2
   0,  28,  98,   2
   0,  22, 103,   3
   0,  17, 106,   5
   0,  13, 108,   7];

GS3=[  2, 124,   2,   0
  1, 124,   3,   0
  1, 121,   6,   0
  0, 119,   9,   0
  0, 113,  15,   0
  0, 105,  23,   0
  0,  94,  34,   0
  0,  80,  48,   0
  0,  64,  64,   0
  0,  48,  80,   0
  0,  34,  94,   0
  0,  23, 105,   0
  0,  15, 113,   0
  0,   9, 119,   0
  0,   6, 121,   1
  0,   3, 124,   1];
##   
##CHorz = [ -9, 143,  -9,   3
## -11, 142,  -6,   3
## -11, 136,   0,   3
## -12, 132,   6,   2
## -11, 122,  15,   2
##  -9, 111,  25,   1
##  -8,  99,  38,  -1
##  -6,  85,  52,  -3
##  -4,  68,  68,  -4
##  -3,  52,  85,  -6
##  -1,  38,  99,  -8
##   1,  25, 111,  -9
##   2,  15, 122, -11
##   2,   6, 132, -12
##   3,   0, 136, -11
##   3,  -6, 142, -11];
     
##CHorz =[
##    -5   136    -5     2
##    -6   135    -3     2
##    -6   131     1     2
##    -6   128     5     1
##    -6   122    11     1
##    -5   113    20     1
##    -4   101    32    -1
##    -3    85    48    -2
##    -2    66    66    -2
##    -2    48    85    -3
##    -1    32   101    -4
##     1    20   113    -5
##     1    11   122    -6
##     1     5   128    -6
##     2     1   131    -6
##     2    -3   135    -6];
     
%for i = 1:length(Sigmas)
%  S = Sigmas(i);
%  L = Levels(i);
%  
%  
%  for p_index = 1:16
%    for t_index = 1:4
%      p = (p_index - 1)/16;
%      t = (t_index - 1);
%      x = t - 1 - p;
%      coeff(p_index, t_index) = fkernel(x,S,epow);
%    end
%  end
%  coeff = coeff/max(sum(coeff'));
%  
%  for B = Brights
%    CVert = round(B*1.28*coeff);
%   M = max(sum(CVert'));
%    m = min(sum(CVert'));
%    fn=["Hybrid_" sprintf("%03d",B) "_" sprintf("%03d",L) ".txt"]
%    write_filter_coeffs(fn,CHorz,CVert);
%  endfor
%end

for B = Brights
  for L = Levels
    P = 310./(B+45); %Was used before
    S = SigmaCalculator(L/100,P);
    for p_index = 1:16
      for t_index = 1:4
        p = (p_index - 1)/16;
        t = (t_index - 1);
        x = t - 1 - p;
        coeff(p_index, t_index) = fkernel(x,S,P);
      end
    end
   
    %% Throw out the coefficients and apply scanlines to GS4 instead...
    
    for i=1:16
      x=(i-1)/16;
      d=1-L/100;
      b=B/100;
      P=0.2*(B+L-110)/100+1;
      %P=1.3; %Can't do better? I tried...
      SL=(b-d*b)+b*d*(     0.5+0.5*(cos(2*pi*x))           )^P
     coeff(i,:) = (GS3(i,:))*SL;
    end
    
    coeff = coeff/max(sum(coeff'));
    CVert = round(B*1.28*coeff);
      fn=["SL_Br_" sprintf("%03d",B) "_" sprintf("%03d",L) "_Soft.txt"]
    write_filter_coeffs(fn,CHorz,CVert);
  end
end

