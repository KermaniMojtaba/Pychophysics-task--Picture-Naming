function runImageSequence(subID)
%% PTB experiment template: Image sequence
% Screen('Preference', 'SkipSyncTests', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up the experiment (don't modify this section)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
settingsImageSequence; % Load all the settings from the file
rand('state', sum(100*clock)); % Initialize the random number generator

% Keyboard setup
KbName('UnifyKeyNames');
 KbCheckList = [KbName('space'),KbName('ESCAPE')];
for i = 1:length(responseKeys)
    KbCheckList = [KbName(responseKeys{i}),KbCheckList];
end
RestrictKeysForKbCheck(KbCheckList);

% Screen setup
clear screen
whichScreen = max(Screen('Screens'));

% [window1, rect] = Screen('Openwindow',1,backgroundColor,[],[],2);
[window1, rect] = Screen('Openwindow',whichScreen,backgroundColor,[],[],2);
slack = Screen('GetFlipInterval', window1)/2;
W=rect(RectRight); % screen width
H=rect(RectBottom); % screen height
% Get the size of the on screen window in pixels
% [screenXpixels, screenYpixels] = Screen('WindowSize', window1);
% Get the centre coordinate of the window in pixels
[xCenter, yCenter] = RectCenter(rect);
baseRect = [0 0 100 100];
centreWhiteRect = CenterRectOnPointd(baseRect, xCenter*2-100, yCenter*2-100);
rectColor = [255 255 255];

Screen(window1,'FillRect',backgroundColor);
Screen('Flip', window1,0);
HideCursor();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up stimuli lists and results file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the image files for the experiment
imageFolder = 'images';
imgList = dir(fullfile(imageFolder,['*.' imageFormat]));
imgList = {imgList(:).name};
nTrials = length(imgList);

% Load the text file (optional)
if strcmp(textFile,'none') == 0
    showTextItem = 1;
    textItems = importdata(textFile);
else
    showTextItem = 0;
end

% Set up the output file
resultsFolder = 'results';
outputfile = fopen([resultsFolder '/resultfile_' num2str(subID) '.txt'],'a');
fprintf(outputfile, 'subID\t imageCondition\t trial\t textItem\t imageFile\t response\t RT\n');

% Randomize the trial list
randomizedTrials = randperm(nTrials);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Run experiment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Start screen
Screen('TextSize',window1, 40);
Screen('DrawText',window1,'Press the space bar to begin', (W/2-300), (H/2), textColor);
Screen('Flip',window1,0)
% Wait for subject to press spacebar
while 1
    [keyIsDown,secs,keyCode] = KbCheck;
    if keyCode(KbName('space'))==1
        break
    end
end

% Run experimental trials
j=0;
for t = randomizedTrials
    
    % Load image
    file = imgList{t};
    img = im2uint8(imread(fullfile(imageFolder,file)));
    img = imresize (img, 0.5);
    img(img < 50)= 50;
    imageDisplay = Screen('MakeTexture', window1, img);
    
    % Calculate image position (center of the screen)
    imageSize = size(img);
    pos = [(W-imageSize(2))/2 (H-imageSize(1))/2 (W+imageSize(2))/2 (H+imageSize(1))/2];
    
    % Screen priority
    Priority(MaxPriority(window1));
    Priority(2);
    
    % Show fixation cross
    fixationDuration = 0.5; % Length of fixation in seconds
    drawCross(window1,W,H);
    tFixation = Screen('Flip', window1,0);
    % Blank screen
    Screen(window1, 'FillRect', backgroundColor);
    Screen('Flip', window1, tFixation + fixationDuration - slack,0);
    
    % Show the flag
%     if showTextItem
        % Display text
        textString = textItems{t};
        flag = imread(textString);
        cueSize = size(img)/2;
    
        
        posFlag = [(W-cueSize(2))/2 (H-cueSize(1))/2 (W+cueSize(2))/2 (H+cueSize(1))/2];
        flagImg = Screen('MakeTexture', window1, flag);
        Screen('DrawTexture', window1, flagImg, [], posFlag);
%         Screen('TextSize',window1, 40);
%         Screen('DrawText', window1, textString, (W/2-50), (H/2), textColor);
        Screen('FillRect', window1, rectColor, centreWhiteRect); %photodiode patch
        tFlag = Screen('Flip', window1,0);
        
        % Blank screen
        Screen(window1, 'FillRect', backgroundColor);
        tDelay=Screen('Flip', window1, tFlag + textDuration - slack,0);
        %                 Screen(tTextdisplay,'Close');
%     else
%         textString = '';
%     end
    
    
    % Show the images
    Screen(window1, 'FillRect', backgroundColor);
    Screen('DrawTexture', window1, imageDisplay, [], pos);
    Screen('FillRect', window1, rectColor, centreWhiteRect); %photodiode patch
    startTime = Screen('Flip', window1, tDelay + delay1); % Start of the trial
    
    % Get keypress response
    rt = 0;
    resp = 0;
    while GetSecs - startTime < imageDuration
        [keyIsDown,secs,keyCode] = KbCheck;
        respTime = GetSecs;
        pressedKeys = find(keyCode);
        
        % ESC key quits the experiment
        if keyCode(KbName('ESCAPE')) == 1
            clear all
            close all
            sca
            return;
        end
        
        % Check for response keys
        if ~isempty(pressedKeys)
            for i = 1:length(responseKeys)
                if KbName(responseKeys{i}) == pressedKeys(1)
                    resp = responseKeys{i};
                    rt = respTime - startTime;
                end
            end
        end
        
        % Exit loop once a response is recorded
        if rt > 0
            break;
        end
        
    end
    
    % Blank screen
    Screen(window1, 'FillRect', backgroundColor);
    Screen('Flip', window1,0);
    
    % Save results to file
    fprintf(outputfile, '%s\t %s\t %d\t %s\t %s\t %s\t %f\n',...
        subID, imageFolder, t, textString, file, resp, rt);
   j=j+1; 
   trialOrder(j) = double(strcmp(textString,'english.png'));
%    save (subID,'trialOrder')
   save(['results\',subID],'trialOrder')
    
    % Clear textures
    Screen(imageDisplay,'Close');
    
    % Provide a short break after a certain number of trials
    if mod(t,breakAfterTrials) == 0
        Screen('DrawText',window1,'Break time. Press space bar when you''re ready to continue', (W/2-300), (H/2), textColor);
        Screen('Flip',window1,0)
        % Wait for subject to press spacebar
        while 1
            [keyIsDown,secs,keyCode] = KbCheck;
            if keyCode(KbName('space')) == 1
                break
            end
        end
    else
        
        % Pause between trials
        if timeBetweenTrials == 0
            while 1 % Wait for space
                [keyIsDown,secs,keyCode] = KbCheck;
                if keyCode(KbName('space'))==1
                    break
                end
            end
        else
            WaitSecs(timeBetweenTrials+rand);
        end
    end
end

Screen('DrawText',window1,'This is the end of the experiment', (W/2-300), (H/2), textColor);
Screen('Flip',window1,0)
KbWait;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% End the experiment (don't change anything in this section)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RestrictKeysForKbCheck([]);
fclose(outputfile);
Screen(window1,'Close');
close all
sca;
return

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subfunctions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Draw a fixation cross (overlapping horizontal and vertical bar)
function drawCross(window,W,H)
barLength = 16; % in pixels
barWidth = 2; % in pixels
barColor = 0.5; % number from 0 (black) to 1 (white)
Screen('FillRect', window, barColor,[ (W-barLength)/2 (H-barWidth)/2 (W+barLength)/2 (H+barWidth)/2]);
Screen('FillRect', window, barColor ,[ (W-barWidth)/2 (H-barLength)/2 (W+barWidth)/2 (H+barLength)/2]);
end