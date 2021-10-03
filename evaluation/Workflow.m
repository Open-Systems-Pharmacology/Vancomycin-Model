% Script to perform a Qualification Plan workflow
% Qualification Plan Workflow developed with Matlab 2017b
% --------------------------------------------------------------

close all
tic

if exist(fullfile(cd,'re_input'),'dir')>0 rmdir(fullfile(cd,'re_input'),'s'); end
if exist(fullfile(cd,'re_output'),'dir')>0 rmdir(fullfile(cd,'re_output'),'s'); end
if exist(fullfile(cd,'report'),'dir')>0 rmdir(fullfile(cd,'report'),'s'); end


% --------------------------------------------------------------
% replace qualificationRunnerFolder and markdownJoinerFolder with your paths
qualificationRunnerFolder = 'C:\OSPQualification\QualificationRunner10.0.41';
markdownJoinerFolder = 'C:\OSPQualification\markdown-joiner_1.2.0.8';
PKSimPortableFolder = 'C:\OSPQualification\PK-Sim10.0.229';

% --------------------------------------------------------------
% replace basisDir and qualificationPlanName with your paths
%
% assuming the following structure
%   basisDir
%   - input
%      - qualificationPlanName
%   - re_input
%   - re_output
%   - report
%

basisDir = fullfile(cd);
qualificationPlanName = 'Evaluation_plan.json';

% In case your folder structure is different from assumed above, 
% qualificationPlan, REInput_path, REOutput_path and ReportOutput_path must be adjusted as well 
%
% - REInput_path: input path for the Reporting engine 
%                 (corresponds to the output path defined in the Qualification Runner)
%
% - REOutput_path: outputs of the Reporting Engine will be created here
%                  CAUTION: if the folder is not empty, its contents will be deleted
%
% - ReportOutput_path: final report will be generated here
qualificationPlan = fullfile(basisDir,'Input',qualificationPlanName);
REInput_path = fullfile(basisDir,'re_input');
REOutput_path = fullfile(basisDir,'re_output');
ReportOutput_path=fullfile(basisDir,'report');

% --------------------------------------------------------------
% STEP #1: start qualification runner to generate inputs for the reporting engine
startQualificationRunner(qualificationRunnerFolder, qualificationPlan, REInput_path, ['-p ' PKSimPortableFolder ]);

% --------------------------------------------------------------
% STEP #2: start reporting engine
% Get the Configuration Plan Settings
reportConfigurationPlan = 'report-configuration-plan.json';
[WSettings, ConfigurationPlan, TaskList, ObservedDataSets] = initializeQualificationWorkflow(reportConfigurationPlan, REInput_path, REOutput_path);

%OPTIONAL: set watermark. If set, it will appear in all generated plots
%WSettings.Watermark = 'Preliminary';

% run the Worklfow tasklist of ConfigurationPlan
runQualificationWorkflow(WSettings, ConfigurationPlan, TaskList, ObservedDataSets);

QualificationWorkflowTime = toc/60;
fprintf('\n Qualification Workflow Duration: %0.1f minutes \n', QualificationWorkflowTime);

% --------------------------------------------------------------
% STEP #3: call MarkdownJoiner to combine Reporting Engine output into the final report
MarkdownJoiner_path=fullfile(markdownJoinerFolder,'markdown-joiner.exe');

% alternative #1: ReportOutput_path must be empty. If not, report generation will fail
status = system(['"' MarkdownJoiner_path '" -i "' REOutput_path '" -o "' ReportOutput_path '"']);

% alternative #2: (CAUTION) ReportOutput_path will be cleared first
%status = system(['"' MarkdownJoiner_path '" -i "' REOutput_path '" -o "' ReportOutput_path '" -f']);

if status~=0 error('MarkdownJoiner failed'); end

