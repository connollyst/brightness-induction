function [strct]=get_default_parameters_NCZLd()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% wavelets' parameters %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% decomposition choice
wave.multires='a_trous';

% number of scales (if 0: code calculates it automatically)
wave.n_scales=0; 
% wave.n_scales=5;
% wave.n_scales=4; 

% size of the last wavelet plane to process
% (see below zli.fin_scale_offset parameter in order to include or not residual plane)
wave.mida_min=32;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Z.Li's model parameters %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% differential equation. The total number of iterations is niter/prec
zli.n_membr=10;		% precision of membrane time
zli.n_iter=10;		% number of iterations; in the case of a dynamical stimulus, it is the number of frames

% zli.total_iter=zli.n_iter/zli.prec;
zli.dist_type='eucl';
% zli.dist_type='manh';
% zli.scale2size_type=0;
zli.scale2size_type=1;
zli.reduccio_JW=1;
% zli.normal_type='scale';
zli.normal_type='all';
% zli.normal_type='absolute'; zli.normal_min_absolute=0; zli.normal_max_absolute=255;

zli.alphax=1.0; % 1.6 !!!
zli.alphay=1.0; % 1.6 !!!
zli.kappax=1.0; % 1.6 !!!
zli.kappay=1.0; % 1.6 !!!

% normalization
zli.normal_input=4;			% rescaled maximum value of input data for Z.Li method
zli.normal_output=2.0;		% rescaled maximum value of output data for Z.Li method
zli.Delta=15;				% maximum radius of the area of influence
zli.ON_OFF=0;	% 0: separate, 1: abs, 2:square
zli.boundary='mirror';  % or 'wrap'
zli.normalization_power=2; % power of the denominator in the normalization step
zli.kappax=1.0; % 1.6 !!!
zli.kappay=2.0; % 1.6 !!!
multires=wave.multires;
zli.shift=1;		% minimum value of input data for Z.Li method
zli.ini_scale=1;	% initial scale to process: scale=1 is the highest frequency plane
zli.fin_scale_offset=1;		% last plane to process will be n_scales - fin_scale (and its size will be wave.mida_min),
							% i.e. if =0 then residual will be processed (and its size will be wave.mida_min)
zli.scale_interaction=1;
zli.orient_interaction=1;
														  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% computational setting %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use MATLAB workers (0:no, 1:yes)
% compute.parallel=0;						% concurrent for every image
% compute.parallel_channel=0;			% concurrent for every channel (i.e. intensity and 2 chromatic)
% compute.parallel_scale=0;				% concurrent for every wavelet plane 
% compute.parallel_ON_OFF=0;				% concurrent for every wavelet plane 
% compute.parallel_orient=0;				% concurrent for every wavelet orientation 
compute.dynamic=0;						% 0 stable/1 dynamic stimulus
% compute.multiparameters=0;				% 0 for the first parameter of the list/ 1 for all the parameters
compute.use_fft=1;
compute.avoid_circshift_fft=1;
% compute.output_type='image';
compute.XOP_DEBUG=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  stimulus (image, name...) %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
image.n_frames_promig=zli.n_membr-1;		% number iterations (from the last one) considered for the ouput (mean)
% image.updown=[1];							% up/downsample ([1,2])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% display plot/store    %%%%%%%%%%%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display_plot.plot_io=1;					% plot input/output
display_plot.reduce=0;					% 0 all (9)/ 1 reduced ; useless if single_or_multiple=1
display_plot.plot_wavelet_planes=0;	% plot wavelet planes
display_plot.store=1;					% 0 don't store/ 1 store
display_plot.y_video=0.5;
display_plot.x_video=68/128;
strct=struct('zli',zli,'wave',wave,'image',image,'display',display_plot,'compute',compute);


end