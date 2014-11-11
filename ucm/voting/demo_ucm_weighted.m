% Zornitsa Kostadinova
% Oct 2014
% 8.3.0.532 (R2014a)
model_name='modelBSDS500_patches';
load_model_and_trees;
fmt='doubleSize';

%% 16x16 vertical line
l=zeros(16,16); l(:,8)=1;
L=repmat(l,1,1,3); clear l;
L_ucm=ucm_weighted(L,model,'vpr',fmt,T);
merge_L_ucm=ucm_weighted(L,model,'greedy_merge',fmt,T);

%% bw diagonal
bw=repmat(eye(260),1,1,3);

merge_bw_ucm=ucm_weighted(bw,model,'greedy_merge',fmt,T);

bpr_bw_ucm=ucm_weighted_bpr(bw,model,T);
bw_gt=watershed(bw(:,:,1),4); bw_gt(bw_gt==0)=1;
bpr_bw_ucm_oracle=ucm_weighted_bpr(bw,model,T,{bw_gt});

rsri_bw_ucm=ucm_weighted(bw,model,'RSRI',fmt,T);

vpr_s_bw_ucm=ucm_weighted(bw,model,'vpr_s',fmt,T);

%% real image
imFile='/BS/kostadinova/work/BSR/BSDS500/data/images/val/101085.jpg';
gtFile='/BS/kostadinova/work/BSR/BSDS500/data/groundTruth/val/101085.mat';
I=imread(imFile);
ucm=ucm_weighted(I,model,'RI',fmt,T);
ucm_oracle=ucm_weighted(I,model,'greedy_merge',fmt,T,load_segmentations(gtFile));
