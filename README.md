# Pychophysic task: Picture Naming
 
This is a MATLAB package for running a Psychophysics task on human. You need Psychtoolbox-3 package to run the code. In this experiment, participants sit in front of a computer screen and will be asked to name pictures (stimulus) in their first or second language depending on a preceeding a clue (country flags, iether Australia or different flag). Whilst performing the task, the code records the participant's speed of responding to the pictures (reaction time) and saves it in a .txt file and a .mat file. The code also the name of picture that is presented in each trial. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
There are two folders two .png files, one txt file and two .m files in the package. 
runImageSequence.m is the main code to run. simply call the file in the command window however, it requires a name or code to be saved as the participant's name in form of strings, e.g. runImageSequence('test')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
settingsImageSequence.m is the setting file were you can controle the task parameters including the image presentation time, intertrial interval, etc. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Image folder contains the pictures which will be used during the experiemnt.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Two .png files are the flags which will be used as a clue during the experiement 
