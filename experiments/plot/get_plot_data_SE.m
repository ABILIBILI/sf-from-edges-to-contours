% Zornitsa Kostadinova
% Feb 2015
% 8.3.0.532 (R2014a)

data_SE_ucm_degraded_baseline=[... % new baseline - evaluate SF on a pixel (or smaller patch); rescaled ucm2s
  struct('out','Output_ucm_bdry_sz_1_mid_1x1_rescaled','legend','1x1 mid','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_1x1_rescaled','legend','1x1 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_2x2_rescaled','legend','2x2 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_4x4_rescaled','legend','4x4 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_8x8_rescaled','legend','8x8 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_16x16_orig_rescaled','legend','16x16=orig','style',{{'Marker','x'}}),...
];
% TODO add a proper baseline

% edge detection results, i.e., just BPR plot, no VPR, or any region-based metrics
data_SE_nms_single_scale=struct('out','Output_SE_nms_single_scale','legend','SE thinned SS','style',{{}});
data_SE_no_nms_single_scale=struct('out','Output_SE_no_nms_single_scale','legend','SE not-thinned SS','style',{{}});

data_SE_nms_multiscale=struct('out','Output_SE_nms_multiscale','legend','SE thinned MS','style',{{}});
data_SE_no_nms_multiscale=struct('out','Output_SE_no_nms_multiscale','legend','SE not-thinned MS','style',{{}});


% just a dot on the PR curve - single segmentation - oversegmentation
data_SE_watershed=struct('out','Output_sf_segs','legend','SE watershed','style',{{}});


% segmentations
% TODO how was this generated?
data_SE_ucm_irreproducible_baseline=struct('out','Output_sf_ucm','legend','SE ucm','style',{{'LineStyle','--'}}); % multiscale, model.opts.nms=1 % UPDATE: these options are impossible - multiscale would give better performance, and nms "breaks" the watershed
data_SE_ucm_no_nms_single_scale=struct('out','Output_SE_ucm_repeat','legend','(SE SS)-UCM','style',{{}}); % this should have been the real baseline
data_SE_ucm_no_nms_multiscale=struct('out','Output_SE_ucm_non-nms_multiscale_repeat','legend','(SE MS)-UCM','style',{{}});
% data_SE_ucm_irreproducible_baseline is our baseline
data_SE_ucm_baseline=data_SE_ucm_irreproducible_baseline;

data_SE_ucm_uneffected_by_averaging=[ % as could be expected, the following are identical
  data_SE_ucm_no_nms_single_scale,... % nms=false SS
  struct('out','Output_region_bdry_SE_ucm','legend','region bdry SE ucm','style',{{}}),... % nms=false SS
  ];

data_rescaled_comparison=[ % this shows that rescaling doesn't change the shape of the curve, just extends it to cover as much of the recall range as possible
  data_SE_ucm_no_nms_single_scale,...
  struct('out','Output_SE_ucm_non_nms_SS_repeat_rescale','legend','SE ucm RESCALED repeat','style',{{'LineStyle','-.'}}),... % nms=false
];


% SE+sPb
data_SE_sPb_nms=struct('out','Output_sf_sPb_nms','legend','(SE nms+sPb)-UCM','style',{{}}); % non-max-suppressed E as input to sPb % 'SE + sPb'
data_SE_sPb_nnms=struct('out','Output_sf_sPb_nnms','legend','(SE nonnms+sPb)-UCM','style',{{}}); % not-nms
data_SE_sPb=data_SE_sPb_nnms; % not-nms performs slightly worse, but it is fair to compare with us, since we cannot apply watershed on top of thinned edges

% summary
data_SE=[data_SE_nms_single_scale data_SE_no_nms_single_scale data_SE_nms_multiscale data_SE_no_nms_multiscale]; % edge detector output; not a segmentation
data_SE_UCM=[data_SE_ucm_irreproducible_baseline data_SE_ucm_no_nms_single_scale data_SE_ucm_no_nms_multiscale]; % our baseline SE-UCM - directly copying the values from Dollar's edge detector to build finest partition (weighted watershed) and run UCM on top
