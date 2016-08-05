function [omegaPhiVec, omegaDeltaVec] = updatePartitionEnergy(Lmat, I)
% Function Initializes energy \omega_\phi and \omega_\delta for differen levels in hierarchy - input Lmat is labelled level 
% Author B Ravi Kiran, ESIEE, Sept 2014

%Internal Parameters
k_const = 3*sqrt(3)/2;
% maxVal = 1;
Ir = double(I(:,:,1)); Ir = Ir(:); 
Ig = double(I(:,:,2)); Ig = Ig(:);
Ib = double(I(:,:,3)); Ib = Ib(:);
% I0 = rgb2gray(I); I0vec = I0(:);
omegaPhiVec = zeros(1,max(Lmat(:)));
omegaDeltaVec = zeros(1,max(Lmat(:)));
p = regionprops(Lmat, 'perimeter');
for label = 1:max(Lmat(:))
        vec = find(Lmat == label);
%         meangray = sum(I0vec(vec))/length(vec);
%         omegaPhiVec(label) = sum((meangray-I0vec(vec)).^2);
        r2gb = (2*Ir(vec)-Ig(vec)-Ib(vec))/k_const; meanr2gb = sum(r2gb)/length(r2gb);
        b2rg = (2*Ib(vec)-Ir(vec)-Ig(vec))/k_const; meanb2rg = sum(b2rg)/length(b2rg);
        g2rb = (2*Ig(vec)-Ir(vec)-Ib(vec))/k_const; meang2rb = sum(g2rb)/length(g2rb);       
        omegaPhiVec(label) = (sum((r2gb - meanr2gb).^2)+sum((b2rg - meanb2rg)).^2+sum((g2rb - meang2rb).^2));
        omegaDeltaVec(label) = p(label).Perimeter;        
end