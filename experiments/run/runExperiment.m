% Zornitsa Kostadinova
% Jun 2014
function runExperiment(experiment_name,det_out_type)
% SRF training and evaluation (using the VSB100 benchmark)
assert(~strcmp(experiment_name,'foo'));
LOG.repoDir='/BS/kostadinova/work/video_segm';
LOG.evalDir='/BS/kostadinova/work/video_segm_evaluation';
dss=[...
  struct('name','BSDS500','isVideo',false),...
  struct('name','VSB100_40','isVideo',true),...
  struct('name','VSB100_full','isVideo',true),...
  struct('name','VSB100_half','isVideo',true),... % only added so that we can run the memory-greedy "sf + sPb" on VSB100
  struct('name','VSB100_tiny','isVideo',true),...
  ];
dsName='BSDS500';
LOG.ds=dss(strcmp({dss.name},dsName));
% TODO remove this when we add temporal features
LOG.ds.isVideo=false;
LOG.experimentName=experiment_name;
LOG.detOutputType=det_out_type;
% log directories
LOG.dsDir=fullfile(LOG.evalDir, LOG.ds.name);
LOG.recordingsDir=fullfile(LOG.dsDir, 'test', 'recordings');
if ~exist(LOG.recordingsDir, 'dir'), mkdir(LOG.recordingsDir), end
LOG.timestamp=datestr(clock,'yyyy-mm-dd_HH-MM-SS'); disp(LOG.timestamp);
LOG.experimentDirR=[LOG.timestamp '_Output_' LOG.experimentName];
LOG.timestampDir=fullfile(LOG.recordingsDir, LOG.experimentDirR);
mkdir(LOG.timestampDir);

% for detection and benchmark; relative directories name
LOG.imDirR='Images'; % input test images
LOG.resDirR=['Ucm2_' LOG.experimentName]; % result of the detector; output type can be .png, .mat
LOG.gtDirR='Groundtruth'; % ground truths for the test images

% example log files:
% video_segm_evaluation/VSB100_40/test/recordings/2014-06-05_13-37-46/_recordings.txt - git version, runtimes
% video_segm_evaluation/VSB100_40/test/recordings/2014-06-05_13-37-46/_recordings.mat - training, detection and benchmark options; benchmark output
LOG.txtFile=fullfile(LOG.timestampDir, '_recordings.txt');
LOG.matFile=fullfile(LOG.timestampDir, '_recordings.mat');
LOG.fid=fopen(LOG.txtFile, 'w');
save(LOG.matFile,'LOG');

gitCmd=sprintf('git --git-dir=%s/.git --work-tree=%s --no-pager log --format="%%H" -n 1',LOG.repoDir,LOG.repoDir);
[status, gitCommitId]=system(gitCmd);
if (status), warning('no git repository in %s', pwd); else
  fprintf(LOG.fid, 'Last git commit %s \n', gitCommitId); end

% Training
model=edgesTrainWrapper(LOG);

% Detection
segmDetectWrapper(model,LOG);

% Rescale the detected ucm2's so that the nonzero values are in [0.01,0.99] -
% for the benefit of the benchmark
%
% the original values are kept in a folder Ucm2_xx_orig
rescale_ucm2(LOG.experimentName);

% Benchmark
benchmarkWrapper(LOG);

%%
if ~isempty(gcp('nocreate')), delete(gcp('nocreate')); end
fprintf(LOG.fid, '\n'); fclose(LOG.fid);
end
