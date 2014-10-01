% Zornitsa Kostadinova
% Jul 2014
function plotContext(LOG)
% Plot precomputed benchmark results (also from other algorithms).
%
% INPUT
%  LOG        - (optional) see runExperiment

% flag to indicate whether we are plotting the best curves or our experiments -
% the weighted (voted) ucms
experiments={'best','ours','all'};
experimentsToPlot=experiments{2};

if nargin==0
  LOG.evalDir='/BS/kostadinova/work/video_segm_evaluation';
  LOG.ds.name='BSDS500';
  LOG.dsDir=fullfile(LOG.evalDir, LOG.ds.name);
end

plotOpts=struct('path',fullfile(LOG.dsDir,'test'),'dirR','precomputed','superposePlot',true);

% TODO add avg human agreement ComputeRP(plotOpts.path,nthresh,benchmarkdir,requestdelconf,0,'k',false,[],'all',[],'Output_general_human');

% courtesy jhosang; colors for up to 16 curves
colorMap = [ ...
228, 229, 97 ; ...
163, 163, 163 ; ...
218, 71, 56 ; ...
219, 135, 45 ; ...
145, 92, 146 ; ...
83, 136, 173 ; ...
135, 130, 174 ; ...
225, 119, 174 ; ...
142, 195, 129 ; ...
138, 180, 66 ; ...
223, 200, 51 ; ...
92, 172, 158 ; ...
177,89,40;
0, 255, 255;
188, 128, 189;
255, 255, 0;
] ./ 256;

% directories, labels and colors for the precomputed results
% structure is defined in this manner to allow easy rearrangement of order of
% curves (in the legend)
dataSfUcm=struct('out','Output_sf_ucm','legend','SF ucm','style',{{'LineStyle','--'}});
dataBest=[...
  struct('out','Output_sf_segs','legend','SF watershed','style',{{}}),...
  dataSfUcm,...
  struct('out','Output_sf_sPb','legend','SF + sPb','style',{{'LineStyle','--'}}),...
  struct('out','Output_mcg_downloaded','legend','MCG','style',{{}}),...
  struct('out','Output_bsds_downloaded','legend','gPb+ucm','style',{{}})...
  ];
dataOurs=[...
  struct('out','Output_CpdSegs','legend','vote','style',{{'Marker','x'}}),...
  struct('out','Output_sf_vote','legend','vote++','style',{{'Marker','x'}}),... % CpdSegs improved by merging some regions of the superpixelisation
  struct('out','Output_sf_votePb','legend','vote .* pb','style',{{'Marker','x'}}),... % vote++ multiplied with the pb from create_finest_partition by Arbelaez
  struct('out','Output_Pri_vote','legend','PRI','style',{{'LineStyle',':','Marker','x'}}),... % rather than CPD, increases the nSample to the max, so we have a PRI measure; same results, only slower
  struct('out','Output_VprSegsNormalised','legend','VprSegsNormalised','style',{{'Marker','x'}}),... % normalised VPR
  struct('out','Output_VprSegsUnnormalised','legend','VprSegsUnnormalised','style',{{'Marker','x'}}),... % unnormalised VPR
  struct('out','Output_VprNormalisedPb','legend','VprNormalised .* pb','style',{{'LineStyle',':','Marker','x'}}),... % normalised VPR multiplied with the pb from create_finest_partition by Arbelaez
  ];
switch experimentsToPlot
  case 'best'
    data=dataBest;
  case 'ours'
    % initial experiments with metrics and input types
    data=[...
      dataSfUcm,...
      struct('out','Output_VprBdry01','legend','VprBdry01','style',{{'Marker','x'}}),... % unsuitable: struct('out','Output_VprBdry12','legend','VprBdry12','style',{{'Marker','x'}}),...
      struct('out','Output_VprSegsUnnormalised','legend','VprSegs (Unnormalised)','style',{{'Marker','x'}}),...
      struct('out','Output_CpdBdry01','legend','CpdBdry01','style',{{'Marker','x'}}),...
      struct('out','Output_CpdSegs','legend','CpdSegs','style',{{'Marker','x'}}),...
      ];
    % best performing from the above - CpdSegs, improved
    data=[dataSfUcm,dataOurs];
  otherwise
    assert(strcmp(experimentsToPlot,'all'));
    data=[dataBest,dataOurs];
end

fsz=4; % number of figures, BPR, VPR, length statistics and number of clusters
l=repmat({data.legend},[fsz 1]); % metric-specific label
for d=1:length(data)
  plotOpts.plotStyle=[{colorMap(d,:)} data(d).style];
  plotOpts.outDirR=data(d).out;
  [output,fhs]=ComputeRP(plotOpts);
  l{1,d}=[l{1,d} ' ' fscoreStr(output.B_G_ODS, output.B_G_OSS)]; % BPR
  l{2,d}=[l{2,d} ' ' fscoreStr(output.R_G_ODS, output.R_G_OSS)]; % VPR
end

if ~strcmp(experimentsToPlot,'ours'), [fhSf,legendSf]=plotBprForSfEdges(plotOpts); end

assert(isequal(fsz,length(fhs)));
for f=1:fsz
  figure(fhs(f));
  l1=l(f,:);
  if exist('fhSf','var') && exist('legendSf','var') && isequal(f,fhSf), l1=[l(f,:) {legendSf}]; end
  legend(l1,'Location','NorthEastOutside');
  figTitle=get(get(gca,'Title'),'String');
  fileName=strrep(figTitle,' ','_');
  saveas(gcf,fullfile(plotOpts.path,plotOpts.dirR,['_',fileName]),'jpg');
end
end

% ----------------------------------------------------------------------
function str=fscoreStr(ODS,OSS)
str=sprintf('[ODS %1.2f, OSS %1.2f]',ODS,OSS);
end

% ----------------------------------------------------------------------
function [fhSf,legendSf] = plotBprForSfEdges(plotOpts)
% SF is an edge detector; segmentation benchmarks are not applicable, only BPR
plotOpts.outDirR='Output_sf_edges';
plotOpts.metrics='bdry';
plotOpts.plotStyle={'k'};
[output,fhSf]=ComputeRP(plotOpts);
legendSf=['SF edge ' fscoreStr(output.B_G_ODS, output.B_G_OSS)];
end
