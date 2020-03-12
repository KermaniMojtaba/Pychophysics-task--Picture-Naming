%% Settings for image sequence experiment
% Change these to suit your experiment!

% Path to text file input (optional; for no text input set to 'none')
textFile = 'Language_choice.txt';
%textFile = 'none';

% Response keys (optional; for no subject response use empty list)
% responseKeys = {'y','n'};
responseKeys = {};

% Number of trials to show before a break (for no breaks, choose a number
% greater than the number of trials in your experiment)
breakAfterTrials = 1000;

% Background color: choose a number from 0 (black) to 255 (white)
backgroundColor = 128;

% Text color: choose a number from 0 (black) to 255 (white)
textColor = 0;

% Image format of the image files in this experiment (eg, jpg, gif, png, bmp)
% imageFormat = 'jpg';
imageFormat = 'png';

% Time between text and image(in seconds)
delay1=1;

% How long to show text (in seconds)
textDuration = 0.1; 

% audio capture trigger
triggerlevel = 0.3;

% How long to wait (in seconds) for subject response before the trial times out
imageDuration = 0.15;

% How long to pause in between trials (if 0, the experiment will wait for
% the subject to press a key before every trial)
timeBetweenTrials = 1;