function [allUsersPrefs, windowsPrefs, glob] = CreatePrefsArray()
% This function creates the allUsersPrefs array, windowsPrefs ----
% and the alphaPrefs.  Also some "global" variables which need 
% to be persistentand saved between sessions.

%% Values for the default user -----------------------------------
    defaultCodeSpeed = 12;
    defaultWordSpeed = 6;
    defaultFrequency = 400;

%% "Global" glob variables ---------------------------------------
    glob.saveWindows = 1;           % Save window position on close.
    glob.saveTextOnExit = 0;        % Save transmitted text on exit.
    glob.saveAudioOnExit = 0;       % Save transmitted audio on exit.
    glob.scaleFactor = 1.;          % Scale factor for all windows.
    glob.volume = .75;              % Audio volume.
    glob.displayFlasher = 1;        % Display Flasher Window.
    glob.selectedUserIndex = 2;     % set to default user index.
    glob.selectedUserName = 'DefaultUser';
    glob.dotTime = round(1./defaultCodeSpeed,2);
    glob.flasherEnabled = 0;    % Off by default, 1 to enable
    glob.flasherDocking = 1;    % On by default, 0 to disable
    glob.flasherOn = [.851 .325 .098];          % Red
    glob.flasherOff = [1  1  1];                % White
    glob.foregroundColor = [.16 .39 .16];       % Green
    glob.backgroundColor = [.920 .920 .920];    % Grey
    glob.boxColor = [.95 .95 .95];              % White
    glob.figureColor = [.99 .99 .99];           % White
    glob.xmitBackgroundColor = [.80 .95 .80];   % Light Green

%% Create alphabet transmit default preferences ------------------
    % 1 = Alphabet=26, 2 = +Numbers = 36, 3 = +Punctuation = 53,
    % 4 = +Special Characters = 59
    alphaPrefs.include = 1;     % 1 = Alphabet only    
    alphaPrefs.format = 1;      % 1 = continuous ; 2 = random
    alphaPrefs.group = 1;       % 1 = no group ; 2 = groups
    alphaPrefs.min = 0;         % group minimum size
    alphaPrefs.max = 0;         % group maximum size
    
%% Create allUsersPrefs cell array -------------------------------
    allUsersPrefs = cell(9,2);

    allUsersPrefs(1:9,1) = {'Name';'CodeSpeed';'WordSpeed';'Frequency';...
        'AlphabetPrefs'; 'AudioFile';'FileUserCopied';'KeyboardInFile';...
        'SelectedUser'};

    allUsersPrefs(1:9,2) = {'DefaultUser'; defaultCodeSpeed;...
        defaultWordSpeed; defaultFrequency; alphaPrefs;...
        'AudioFile1.wav';'FileUserCopied1.txt';...
        'KeyboardInFile1.txt';1};
        
%% Get some GUI windows parameters -------------------------------
% First get the monitor size
    set(0,'Units','Character');
    Sc = get(0, 'ScreenSize');          % Screen size in Characters
    if Sc(3) < Sc(4)
        size = round(Sc(3)-1);
    else
        size = round(Sc(4)-1);
    end
    % disp(size);  
    WindowWidth = round(3*size/2);      % Width of GUI      
    WindowHeight = round(size/4);       % Height of GUI    
    WindowLeft = round(size/3);         % Offset from left
    WindowBottom = round(size/3);       % Offset from bottom
    TextFont = round(3*size/14,1);      % Text Font
    TextHeight = round(3*size/126,1);   % Text Height

%% Create windowsPrefs cell array  -------------------------------
    windowsPrefs = cell(8,14);    
    windowsPrefs(1:8,1) = {'WindowName'; 'ScaleFactor';...
        'Left'; 'Bottom'; 'Width'; 'Height';...
        'TextFont'; 'TextHeight'};   
    windowsPrefs(1:8,2) = {'Morse'; 1;...
        WindowLeft; WindowBottom; WindowWidth; WindowHeight;...
        TextFont; TextHeight};    
    windowsPrefs(1:8,3) = {'Transmit Alphabet'; 1; WindowLeft+3;...
        WindowBottom; round(1.58*WindowWidth); round(1.3*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};   
    windowsPrefs(1:8,4) = {'Transmit File'; 1; WindowLeft+6;...
        WindowBottom; round(1.58*WindowWidth); round(1.3*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};     
    windowsPrefs(1:8,5) = {'Transmit Keyboard'; 1; WindowLeft+9;...
        WindowBottom; round(1.58*WindowWidth); round(1.5*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};     
    windowsPrefs(1:8,6) = {'User Preferences'; 1; WindowLeft+12;...
        WindowBottom; round(.79*WindowWidth); round(1.48*WindowHeight);...
        round(TextFont-1,1); round(TextHeight,1)};     
    windowsPrefs(1:8,7) = {'Alphabet Preferences'; 1; WindowLeft+15;...
        WindowBottom; round(.79*WindowWidth); round(1*WindowHeight);...
        round(TextFont-1,1); round(TextHeight,1)};    
     windowsPrefs(1:8,8) = {'Program Preferences'; 1; WindowLeft+18;...
        WindowBottom; round(.79*WindowWidth); round(1.9*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};   
     windowsPrefs(1:8,9) = {'Warning Window'; 1; WindowLeft+21;...
         WindowBottom; round(.7*WindowWidth); round(1*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};   
    windowsPrefs(1:8,10) = {'Code Table'; 1; WindowLeft+24;...
        WindowBottom; round(1*WindowWidth); round(1*WindowHeight);...
        round(TextFont-2,1); round(TextHeight,1)};  
    windowsPrefs(1:8,11) = {'Help'; 1; WindowLeft+27;...
        WindowBottom; round(1*WindowWidth); round(1*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};     
    windowsPrefs(1:8,12) = {'About'; 1; WindowLeft+30;...
        WindowBottom; round(.64*WindowWidth); round(.6*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)}; 
    windowsPrefs(1:8,13) = {'Flasher'; 1; WindowLeft+33;...
        WindowBottom; round(.6*WindowWidth); round(.6*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)}; 

end % end CreatePrefsArray
