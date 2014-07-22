function [output,fhs]=ComputeRP(varargin)
% Computes recall and precision for images or videos and plots the curves for
% the corresponding metrics
%
% OUTPUTS
%  output         - structure summarising the evaluation results
%  fhs            - array of figure handles to the plots
%
% Fabio Galasso
% February 2014
%
% modified by Zornitsa Kostadinova
% Jun 2014

% possible benchmark metrics
metrics={
  'bdry',...       % BPR - Boundary Precision-Recall
  '3dbdry'...      % TODO is this not implemented
  'regpr',...      % VPR - Volumetric Precision-Recall
  'sc',...         % SC  - Segmentation Covering
  'pri',...        % PRI - Probabilistic Rand Index
  'vi',...         % VI  - Variation of Information
  'lengthsncl',... % length statistics and number of clusters
  'all'};          % computes all available

dfs={...
  'path',pwd...                 % path to `dirR'
  'dirR','tttttSegm',...        % directory (relative) that contains the directories `Images', `Groundtruth' and `Ucm2' (computed results)
  'outDirR',[],...              % The default directory in dirR is defined in the function Benchmarkcreateoutimvid
  'tempConsistency',true,...    % true for videos TODO do this automatically - we know whether a dataset is images or videos
  'justavideo',[],...
  'metrics',metrics{end},...    % could be a cell, e.g. {'bdry','regpr'}
  'nthresh',5,...               % number of thresholds (hierarchical levels to include) for evaluating the ucm
  'curveColor','r',...          % RP curves color
  'superposePlot',false,...     % superpose RP curves; true - new curves are added to the same graph; false - a new graph is initialized
  'confirmDel',false,...        % TODO is this interactive (if true) form useful
  'minNumIms',0,...             % number of images to wait for starting computation (0 means no wait)
  };

opts=getPrmDflt(varargin,dfs,1);
path_=opts.path;
dirR=opts.dirR;
outDirR=opts.outDirR;
tempConsistency=opts.tempConsistency;
justavideo=opts.justavideo;
metrics=opts.metrics;
nthresh=opts.nthresh;
curveColor=opts.curveColor;
superposePlot=opts.superposePlot;
confirmDel=opts.confirmDel;
minNumIms=opts.minNumIms;

if (~isstruct(path_))
    tmp=path_; clear path_; path_.benchmark=tmp; clear tmp;
end

%Assign input directory names and check existance of folders
onlyassignnames=true;
[~,imgDir,gtDir,inDir,isvalid] = Benchmarkcreatedirsimvid(path_, dirR, onlyassignnames);
%imgDir images (for name listing), gtDir ground truth, inDir ucm2, outDirR output
if (~isvalid)
    fprintf('Some Directories are not existing\n');
    return;
end

%Check existance of output directory and request confirmation of deletion
onlyassignnames=true;
[dirA,outDirA,isvalid] = Benchmarkcreateoutimvid(path_, dirR, onlyassignnames, outDirR); %#ok<ASGLU>
if ( isvalid )
    if (confirmDel)
        theanswer = input('Remove previous output? [ 1 , 0 (default) ] ');
    else
        theanswer=0;
    end
    if ( (~isempty(theanswer)) && (theanswer==1) )
        Removetheoutputimvid(path_,dirR,outDirR);
        isvalid=false;
    end
end
if (~isvalid)
    [dirA,outDirA,isvalid] = Benchmarkcreateoutimvid(path_, dirR, [], outDirR); %#ok<ASGLU>
end

%Wait minNumIms for processing
iids=Listacrossfolders(imgDir,'jpg',Inf); % iids = dir(fullfile(imgDir,'*.jpg'));
if (minNumIms>0)
    while(numel(iids)<minNumIms)
        pause(10);
        iids=Listacrossfolders(imgDir,'jpg',Inf); % iids = dir(fullfile(imgDir,'*.jpg'));
    end
    fprintf('All images are in the directory\n');
end
fprintf('%d images are in the folder (and first-level subfolders)\n',numel(iids));

timeBmSegmEval = tic;
if (isvalid)
    Benchmarksegmeval(imgDir, gtDir, inDir, outDirA, nthresh, [], [], metrics, tempConsistency,justavideo);
end
toc(timeBmSegmEval);

timeBmEvalStats = tic;
if (isvalid)
    Benchmarkevalstats(imgDir, gtDir, inDir, outDirA, nthresh, [], [], metrics, tempConsistency, justavideo);
end
toc(timeBmEvalStats);

[output,fhs]=Plotsegmeval(outDirA,superposePlot,curveColor);

% rmdir(dirA,'s')
% rmdir(outDirA,'s')