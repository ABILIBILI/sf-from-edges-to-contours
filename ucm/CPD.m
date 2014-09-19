% Zornitsa Kostadinova
% Sep 2014
% 8.3.0.532 (R2014a)
function d = CPD(patch1,patch2)
% CPD - a crude patch distance metric
% After Dollar's patch comparison while training a structured decision tree.
% Since it uses random sampling, exact numbers are not reproducible.
persistent cache; w=size(patch1,1); assert(size(patch1,2)==w); % w=16
% is1, is2 - indices for simultaneous lookup in the segm patch
if (~isempty(cache) && cache{1}==w), [~,is1,is2,nSamples]=deal(cache{:}); else
  nSamples=256;
  % compute all possible lookup inds for w x w patches
  is=1:w^4; is1=floor((is-1)/w/w); is2=is-is1*w*w; is1=is1+1;
  mask=is2>is1; is1=is1(mask); is2=is2(mask); cache={w,is1,is2,nSamples};
end
% compute nSegs binary codes zs of length nSamples
nSamples=min(nSamples,length(is1));
% sample 256 of the 32640 unique pixel pairs in a 16 x 16 seg mask
kp=randperm(length(is1),nSamples); is1=is1(kp); is2=is2(kp);
ps={patch1,patch2};
nPs=length(ps);
ms=false(nPs,nSamples);
for k=1:nPs, ms(k,:)=ps{k}(is1)==ps{k}(is2); end;
% assert(nPs==2);
d=sum(~xor(ms(1,:),ms(2,:)))/nSamples;
end