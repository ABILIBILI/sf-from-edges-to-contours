% Zornitsa Kostadinova
% Nov 2014
% 8.3.0.532 (R2014a)
function data = get_plot_data(experiments_to_plot)
% directories, labels and line styles for the precomputed results
% structure is defined in this manner to allow easy rearrangement of order of
% curves (in the legend)
% dataSfUcm is our baseline
dataSfUcm=struct('out','Output_sf_ucm','legend','SE ucm','style',{{'LineStyle','--'}}); % multiscale, model.opts.nms=1
dataBest=[...
  struct('out','Output_sf_segs','legend','SE watershed','style',{{}}),...
  dataSfUcm,...
  struct('out','Output_sf_sPb_nms','legend','SE + sPb','style',{{'LineStyle','--'}}),... % non-max-suppressed E as input to sPb
  struct('out','Output_MCG_downloaded','legend','MCG','style',{{}}),...
  struct('out','Output_BSDS_downloaded','legend','gPb+ucm','style',{{}})...
  ];
% our experiments
dataRSRI=[...
  struct('out','Output_RSRI_segs','legend','segs 256 RSRI','style',{{'Marker','x'}}),... % used to be calles 'CpdSegs', now 256
  struct('out','Output_RSRI_segs_merge','legend','s. merge RSRI','style',{{'Marker','x'}}),... % RSRI segs improved by merging some regions of the superpixelisation
  struct('out','Output_fair_segs_merge','legend','fair s. merge RSRI','style',{{'Marker','x'}}),...
  struct('out','Output_RSRI_segs_merge_Pb','legend','s. merge RSRI .*pb','style',{{'LineStyle','--','Marker','x'}}),... % segs merge RSRI, value-multiplied with the pb from create_finest_partition by Arbelaez
  struct('out','Output_RI','legend','RI (32640)','style',{{'LineStyle',':','Marker','x'}}),... % rather than RSRI, increases the nSample to the max, so we have a RI measure; same results, only slower (is it really slower?)
  struct('out','Output_line_RSRI','legend','l. RSRI','style',{{'Marker','x'}}),... % the first patch has only two segments - the fitted line
  ];
% dataVPRnormTs=[... % VPR normalised on the side of the trees
%   struct('out','Output_segs_VPR_normalised_trees','legend','s. VPR norm Ts','style',{{'Marker','x'}}),...
%   struct('out','Output_segs_VPR_normalised_trees_pb','legend','s. VPR Ts .*pb','style',{{'LineStyle','--','Marker','x'}}),...
%   struct('out','Output_line_VPR_normalised_trees','legend','line VPR norm Ts','style',{{'Marker','x'}}),...
%   struct('out','Output_line_VPR_normalised_trees_pb','legend','l. VPR norm Ts .*pb','style',{{'LineStyle','--','Marker','x'}}),...
%   ];
dataVPRnormTs=[... % VPR normalised on the side of the trees
  struct('out','Output_segs_VPR_normalised_trees','legend','s. VPR norm Ts','style',{{'Marker','x'}}),...
  struct('out','Output_line_VPR_normalised_trees','legend','line VPR norm Ts','style',{{'Marker','x'}}),...
  ];
% dataVPRnormWS=[... % VPR normalised on the side of the watershed
%   struct('out','Output_segs_VPR_normalised_ws','legend','s. VPR norm ws','style',{{'Marker','x'}}),...
%   struct('out','Output_segs_VPR_normalised_ws_pb','legend','s. VPR ws .*pb','style',{{'LineStyle','--','Marker','x'}}),...
%   struct('out','Output_line_VPR_normalised_ws','legend','l. VPR norm ws','style',{{'Marker','x'}}),...
%   struct('out','Output_line_VPR_normalised_ws_pb','legend','l. VPR norm ws .*pb','style',{{'LineStyle','--','Marker','x'}}),...
%   struct('out','Output_poly_VPR_normalised_ws_1','legend','poly1 VPR norm ws','style',{{'Marker','x'}}),...
%   ];
dataVPRnormWS=[... % VPR normalised on the side of the watershed
  struct('out','Output_segs_VPR_normalised_ws','legend','s. VPR norm ws','style',{{'Marker','x'}}),...
  struct('out','Output_fair_segs_VPR_normalised_ws','legend','fair s. VPR norm ws','style',{{'Marker','x'}}),...
  struct('out','Output_line_VPR_normalised_ws','legend','l. VPR norm ws','style',{{'Marker','x'}}),...
  struct('out','Output_poly_VPR_normalised_ws_1','legend','poly1 VPR norm ws','style',{{'Marker','x'}}),...
  ];
dataOracleSimple=[... % oracle - using the GT patches instead of the leaves of the SF trees
  struct('out','Output_oracle_segs_merge_RSRI','legend','oracle s. merge RSRI','style',{{'LineStyle','-.','Marker','*'}}),...
  struct('out','Output_oracle_fair_segs_merge','legend','o. fair s. merge RSRI','style',{{'LineStyle','-.','Marker','*'}}),...
  struct('out','Output_oracle_line_RSRI','legend','o. l. RSRI','style',{{'LineStyle','-.','Marker','*'}}),...
  struct('out','Output_oracle_segs_VPR_normalised_trees','legend','o. s. VPR norm Ts','style',{{'LineStyle','-.','Marker','*'}}),...
  ];
dataOracleVPRnormWS=[...
  struct('out','Output_oracle_segs_VPR_normalised_ws','legend','o. s. VPR norm ws','style',{{'LineStyle','-.','Marker','*'}}),...
  struct('out','Output_oracle_fair_segs_VPR_normalised_ws','legend','o. fs. VPR norm ws','style',{{'LineStyle','-.','Marker','x'}}),...
  struct('out','Output_oracle_line_VPR_normalised_ws','legend','o. l. VPR norm ws','style',{{'LineStyle','-.','LineStyle','-.','Marker','*'}}),...
  struct('out','Output_oracle_poly_VPR_normalised_ws_1','legend','o. poly1 VPR norm ws','style',{{'LineStyle','-.','Marker','x'}}),...
];
dataOraclePB=[... % oracle result value-multiplied by the probability of boundary
  struct('out','Output_oracle_line_RSRI_pb','legend','o. l. RSRI pb','style',{{'Marker','o'}}),...
  struct('out','Output_oracle_segs_VPR_normalised_trees_pb','legend','o. s. VPR norm Ts pb','style',{{'Marker','o'}}),...
  struct('out','Output_oracle_segs_VPR_normalised_ws_pb','legend','o. s. VPR norm ws pb','style',{{'Marker','o'}}),...
  struct('out','Output_oracle_line_VPR_normalised_ws_pb','legend','o. l. VPR norm ws pb','style',{{'Marker','o'}}),...
  ];
data_SE_ucm_new_baseline=[... % new baseline - evaluate SF on a pixel (or smaller patch); rescaled ucm2s
  struct('out','Output_ucm_bdry_sz_1_mid_1x1_rescaled','legend','1x1 mid','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_1x1_rescaled','legend','1x1 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_2x2_rescaled','legend','2x2 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_4x4_rescaled','legend','4x4 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_8x8_rescaled','legend','8x8 ul','style',{{'Marker','x'}}),...
  struct('out','Output_ucm_bdry_sz_1_ul_16x16_orig_rescaled','legend','16x16=orig','style',{{'Marker','x'}}),...
];

% BPR
ksz=7;
k=num2str((1:ksz)');
out=num2cell([repmat('Output_bpr_',ksz,1) k],2)';
l=num2cell([repmat('l. BPR',ksz,1) k],2)';
dataBPR=struct('out',out,'legend',l,'style',{{'Marker','x'}});
dataOracleBPR=struct('out',{'Output_oracle_bpr_3' 'Output_oracle_bpr_4'},...
  'legend',{'o. l. BPR3' 'o. l. BPR4'},'style',{{'Marker','x'}});
% Contour
dataContourBpr=struct('out','Output_contour_bpr3','legend','c. BPR3','style',{{}});
dataOracleContourBpr=struct('out','Output_oracle_contour_bpr3','legend','o. c. BPR3','style',{{}});
%
dataOracle=[dataOracleSimple,dataOracleVPRnormWS,dataOracleBPR,dataOracleContourBpr];
dataAllOurs=[...
  dataRSRI,...
  struct('out','Output_segs_VPR_unnormalised','legend','s. VPR unnorm','style',{{'Marker','x'}}),... % unnormalised VPR
  dataVPRnormTs,...
  dataVPRnormWS,...% dataOracle,...  
  dataBPR(2:5),... % these are good values; when having to choose, set for 3px
  ];
dataOurs=[dataBPR(3:4) dataOracleBPR];
dataOurs=[dataOracleSimple,dataOracleBPR]; % all oracles
dataOurs=[dataBPR(3) dataOracleBPR(1)]; % why are we still worse than the baseline?; this motivates the hard-negative mining

dataOurs=[dataContourBpr dataOracleContourBpr]; % the new contour BPR + its oracle
dataOurs=[dataBPR(3) dataContourBpr]; % line vs contour BPR
dataOurs=[dataOracleBPR(1) dataOracleContourBpr]; % same, oracles comparison
dataOurs=[dataVPRnormWS,dataOracleVPRnormWS];
dataOurs=data_SE_ucm_new_baseline;
dataOurs=dataAllOurs;
% TODO add a baseline
dataMidtermPresentationOrig=[...
  struct('out','Output_fair_segs_merge','legend','greedy merge, RIMC','style',{{'Marker','x'}}),...
  struct('out','Output_segs_VPR_unnormalised','legend','segs, VPR unnorm','style',{{'Marker','x'}}),... % unnormalised VPR
  struct('out','Output_segs_VPR_normalised_trees','legend','segs, VPR norm Ts','style',{{'Marker','x'}}),...
  struct('out','Output_line_VPR_normalised_trees','legend','line, VPR norm Ts','style',{{'Marker','x'}}),...
  struct('out','Output_poly_VPR_normalised_ws_1','legend','poly1, VPR norm ws','style',{{'Marker','x'}}),...
  struct('out','Output_bpr_3','legend','line, BPR (dist. 3)','style',{{'Marker','x'}}),...
  struct('out','Output_sf_ucm','legend','baseline (SE+ucm)','style',{{'LineStyle','--'}});
  ];
dataMidtermPresentation=[...
  struct('out','Output_fair_segs_merge','legend','greedy merge, RIMC','style',{{'Marker','x'}}),...
  struct('out','Output_segs_VPR_normalised_trees','legend','segs, VPR norm Ts','style',{{'Marker','x'}}),... % struct('out','Output_poly_VPR_normalised_ws_1','legend','poly1, VPR norm ws','style',{{'Marker','x'}}),...
  struct('out','Output_bpr_3','legend','line, BPR (dist. 3)','style',{{'Marker','x'}}),...
  struct('out','Output_sf_ucm','legend','baseline (SE+ucm)','style',{{'LineStyle','--'}});
  ];
% TODO _oracle_line_VPR_normalised_trees
dataMidtermPresentationOracle=[...
  struct('out','Output_oracle_fair_segs_merge','legend','oracle: greedy merge, RIMC','style',{{'LineStyle','-.','Marker','*'}}),...
  struct('out','Output_oracle_segs_VPR_normalised_trees','legend','o. segs, VPR norm Ts','style',{{'LineStyle','-.','Marker','*'}}),... % struct('out','Output_oracle_poly_VPR_normalised_ws_1','legend','o. poly1, VPR norm ws','style',{{'LineStyle','-.','Marker','x'}}),...
  struct('out','Output_oracle_bpr_3','legend','o. line, BPR (dist. 3)','style',{{'LineStyle','-.','Marker','x'}}),...
  ];

switch experiments_to_plot
  case 'best'
    data=dataBest;
  case 'ours'
    % experiment for checking if anything is lost by reweighing only on the
    % boundary location
    % in all, the E (pb) is not nms (opts.model.nms=0), and detection was single scale
    data=[...
      struct('out','Output_SF_single_scale','legend','SE ucm','style',{{'Marker','x'}}),...
      struct('out','Output_SF_single_scale_on_contours','legend','SE ucm, on contours','style',{{'Marker','x'}}),...
      struct('out','Output_SF_single_scale_png','legend','SE edge','style',{{'Marker','x'}}),...
      struct('out','Output_SF_single_scale_on_contours_png','legend','SE edge, on contours','style',{{'Marker','x'}}),...
      ];
    % initial experiments with metrics and input types
    data=[...
      dataSfUcm,...
      struct('out','Output_VprBdry01','legend','VPR bdry01','style',{{'Marker','x'}}),... % unsuitable: struct('out','Output_VprBdry12','legend','VPR bdry12','style',{{'Marker','x'}}),...
      struct('out','Output_VprSegsUnnormalised','legend','VPR unnorm. segs','style',{{'Marker','x'}}),...
      struct('out','Output_RSRI_bdry01','legend','RSRI bdry01','style',{{'Marker','x'}}),...
      struct('out','Output_RSRI_segs','legend','RSRI segs','style',{{'Marker','x'}}),...
      ];
    % best performing from the above - RSRI_segs, improved in dataOurs
    data=[dataSfUcm,dataOurs];
    data=[dataMidtermPresentation,dataMidtermPresentationOracle];
  otherwise
    assert(strcmp(experiments_to_plot,'all'));
    data=[dataBest,dataOurs];
end
end
