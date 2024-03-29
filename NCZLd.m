function [img_out] = NCZLd(img,struct)

% time
t_ini=tic;
%-------------------------------------------------------
% get the structure/parameters
wave=struct.wave;
zli=struct.zli;
compute=struct.compute;
image=struct.image;
n_membr=zli.n_membr;
% struct.wave
multires=wave.multires;
n_scales=wave.n_scales;
mida_min=wave.mida_min;
% struct.image
% updown=image.updown;
% struct.compute
% dynamic/constant
dynamic=compute.dynamic;
%-------------------------------------------------------
% size
disp([int2str(size(img(:,:,1))) ]);
% calculate number of scales (n_scales) automatically
if(n_scales==0)
	if(zli.fin_scale_offset==0)
		extra=2;  % parameter to adjust the correct number of the last wavelet plane (obsolete)
	else
		extra=3;
    end
	n_scales=floor(log(max(size(img(:,:,1))-1)/mida_min)/log(2)) + extra;
end
% store
wave.n_scales=n_scales;
% actualize struct
struct.wave=wave;
%-------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% NCZLd for every channel %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	im=double(img);
	img_out_tmp=NCZLd_channel_v1_0(im,struct);

% store/ don't store img and img_out (warning: img_out is 4D in the dynamical case!)
if struct.display_plot.store_img_img_out==1
	save([image.name, '_img.mat'],'img')
	save([image.name, '_img_out.mat'],'img_out')
 end

% static case
if dynamic==0
    % take the mean (see Li, 1999)
	n_frames_promig=struct.image.n_frames_promig;
	ff_ini=n_membr-n_frames_promig+1;
	ff_fin=n_membr;
	kk=mean(img_out_tmp(:,:,ff_ini:ff_fin),3);
	img_out=kk;
end

% time
toc(t_ini)
end
