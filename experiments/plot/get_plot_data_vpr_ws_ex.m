% Zornitsa Kostadinova
% Feb 2015
% 8.3.0.532 (R2014a)
% dataVPRnormWS=[... % VPR normalised on the side of the watershed
%   struct('out','Output_segs_VPR_normalised_ws','legend','s. VPR norm ws','style',{{'Marker','x'}}),...
%   struct('out','Output_segs_VPR_normalised_ws_pb','legend','s. VPR ws .*pb','style',{{'LineStyle','--','Marker','x'}}),...
%   struct('out','Output_line_VPR_normalised_ws','legend','l. VPR norm ws','style',{{'Marker','x'}}),...
%   struct('out','Output_line_VPR_normalised_ws_pb','legend','l. VPR norm ws .*pb','style',{{'LineStyle','--','Marker','x'}}),...
%   struct('out','Output_poly_VPR_normalised_ws_1','legend','poly1 VPR norm ws','style',{{'Marker','x'}}),...
%   ];

% merge
data_fairer_merge_vpr_norm_ws=[struct('out','Output_fairer_merge_VPR_normalised_ws','legend','fairer s. VPR norm ws','style',{{'Marker','x'}})];
data_region_bdry_fairer_merge_vpr_norm_ws=[struct('out','Output_region_bdry_fairer_merge_VPR_normalised_ws','legend','region bdry fairer s. VPR norm ws','style',{{'Marker','x'}})];
data_region_bdry_fair_segs_vpr_norm_ws=[struct('out','Output_region_bdry_fair_segs_VPR_normalised_ws','legend','region bdry fs. VPR norm ws','style',{{'Marker','x'}})];
% 1-of-3) line
data_line_vpr_norm_ws=struct('out','Output_line_VPR_normalised_ws','legend','l. VPR norm ws','style',{{'Marker','x'}});
% 2-of-3) line_centre
data_arc_line_centre_vpr_norm_ws=struct('out','Output_line_centre_VPR_normalised_ws','legend','l.c. VPR norm ws','style',{{'Marker','x'}});
data_mixed_voting_line_centre_vpr_norm_ws=[struct('out','Output_mixed_voting_line_centre_vpr_norm_ws_rescaled','legend','m. l.c. VPR norm ws','style',{{'Marker','x'}})]; % rescaled
data_region_bdry_line_centre_vpr_norm_ws=[struct('out','Output_region_bdry_line_centre_VPR_normalised_ws','legend','r.b. l.c. VPR norm ws','style',{{'Marker','x'}})];
% summary
data_line_centre_vpr_norm_ws=[data_arc_line_centre_vpr_norm_ws data_mixed_voting_line_centre_vpr_norm_ws data_region_bdry_line_centre_vpr_norm_ws];
% 3-of-3) line_lls
data_arc_line_lls_vpr_norm_ws=struct('out','Output_line_lls_VPR_normalised_ws_rescaled','legend','l.lls. VPR norm ws','style',{{'Marker','x'}}); % rescaled
data_mixed_voting_line_lls_vpr_norm_ws=[struct('out','Output_mixed_voting_scope_line_lls_VPR_normalised_ws_rescaled','legend','m. l.lls. VPR norm ws','style',{{'Marker','x'}})]; % rescaled
% summary
data_line_lls_vpr_norm_ws=[data_arc_line_lls_vpr_norm_ws data_mixed_voting_line_lls_vpr_norm_ws];
% conic
data_conic_vpr_norm_ws=[ % UPDATE: 2015-02-17 rescaled the 'watershed arc' method, and ``dirty fix'' version; small improvement: 0.52 -> 0.54
  struct('out','Output_conic_VPR_normalised_ws_rescaled','legend','c. VPR norm ws','style',{{}}),... % Output_conic_VPR_normalised_ws
  struct('out','Output_region_bdry_conic_VPR_normalised_ws','legend','region bdry c. VPR norm ws','style',{{}}),... % ,'style',{{'Marker','x'}}),...
  ];
data_vote_range_vpr_norm_ws=[... % the 'c' is computed in the 'region boundary' fashion (although I suspect it would make no difference)
  struct('out','Output_votes0_line_centre_VPR_normalised_ws','legend','vote.0 region bdry l.c. VPR norm ws','style',{{'Marker','x'}}),... % vote is cast only on a single pixel; vertices with no internal edge pixels of the c. (contours)-structure are set to 0
  struct('out','Output_votespb_line_centre_VPR_normalised_ws','legend','vote.Pb region bdry l.c. VPR norm ws','style',{{'Marker','x'}}),... % vote is cast only on a single pixel; vertices with no internal edge pixels of the c. (contours)-structure are filled in from the pb
  ];
data_naive_greedy_merge=struct('out','Output_naive_greedy_merge_VPR_normalised_ws_rescaled','legend','naive greedy merge VPR norm ws','style',{{'Marker','x'}});
data_merge_vpr_norm_ws=[ % no perceivable difference between the 3 experiments:
  data_region_bdry_fair_segs_vpr_norm_ws,...
  data_region_bdry_fairer_merge_vpr_norm_ws,...
  data_fairer_merge_vpr_norm_ws,...
];
dataVPRnormWS=[... % VPR normalised on the side of the watershed
  struct('out','Output_segs_VPR_normalised_ws','legend','s. VPR norm ws','style',{{'Marker','x'}}),...
  struct('out','Output_fair_segs_VPR_normalised_ws','legend','fair s. VPR norm ws','style',{{'Marker','x'}}),...
  data_naive_greedy_merge,...
  data_merge_vpr_norm_ws,...
  data_line_vpr_norm_ws,...
  data_line_centre_vpr_norm_ws,...
  data_line_lls_vpr_norm_ws,...
  data_conic_vpr_norm_ws,...
  data_vote_range_vpr_norm_ws,...
  struct('out','Output_poly_VPR_normalised_ws_1','legend','poly1 VPR norm ws','style',{{'Marker','x'}}),...
  ];

% data_line_centre_VPR_norm_ws_pb=[ % 2015-02-08; update: MUST RERUN them after the rescaling works; might be able to get some results better than SE-UCM baseline for the high-recall range!
%   struct('out','Output_pb_line_centre_VPR_normalised_ws','legend','pb region bdry l.c. VPR norm ws','style',{{}}),...
%   struct('out','Output_oracle_pb_line_centre_VPR_normalised_ws','legend','o. pb region bdry l.c. VPR norm ws','style',{{}}),...
%   ];
data_line_centre_VPR_norm_ws_pb=[ % 2015-02-08; update: rerun them after the rescaling works; might be able to get some results better than SE-UCM baseline for the high-recall range!
  struct('out','Output_mixed_voting_scope_line_centre_VPR_normalised_ws_pb_rescaled','legend','mixed l.c. VPR norm ws .* pb','style',{{'Marker','x'}}),...
  struct('out','Output_oracle_mixed_voting_scope_line_centre_VPR_normalised_ws_pb_rescaled','legend','o. mixed l.c. VPR norm ws .* pb','style',{{'LineStyle','-.','Marker','x'}}),...
  ];
