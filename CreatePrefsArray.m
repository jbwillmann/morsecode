function [allUsersPrefs, windowsPrefs, glob] = CreatePrefsArray()
% This function creates the allUsersPrefs array, windowsPrefs and the
% alphaPrefs.  Also some "global" variables which need to be persistant and
% saved between sessions.

% "Global" variables
    glob.saveWindows = 1;       % set to 1 to save window position on close,
    glob.scaleFactor = 1.;      % scale factor for all windows,
    glob.selectedUserIndex = 2;      % set to default user index,
    glob.userChanged = 1;       % Means we have to rebuild code table
    glob.selectedUserName = 'Default User';


% Create alphabet transmit default preferences
    % 1 = Alphabet=26, 2 = +Numbers = 36, 3 = +Puncuation = 53,
    % 4 = +Special Characters = 59
    alphaPrefs.include = 1;     % 1 = Alphabet only    
    alphaPrefs.format = 1;      % 1 = continuous ; 2 = random
    alphaPrefs.group = 1;       % 1 = no group ; 2 = groups
    alphaPrefs.min = 0;         % group minimum size
    alphaPrefs.max = 0;         % group maximum size

% Remove the old UserData directory and all files therein
    dirToRemove = 'UserData';
    dirRmStat = rmdir(dirToRemove, 's');
                
% Make a new directory with DefaultUser as a sub directory
    newDir = 'UserData/DefaultUser';
    dirMkStat = mkdir(newDir);

% Code Groups
    codeGroups = ['OVLH MYBL URXO HIZO VICT FINX SCXS HTYV IQNT UBML '...
        'ABLB EJLN CYZB ZWCN JNDZ UTLZ KLAB DEFZ VNUW KFRE JICOY '...
        'TXSTY 38�95 RDIHA JXTDZ OXYDW XPZSY RSPHD 89706 CUSPI'];

    fid = fopen('UserData/DefaultUser/CodeGroups.txt', 'w');
    fprintf(fid, codeGroups);
    closeStat = fclose(fid);
    
% Create allUsersPrefs cell array
    allUsersPrefs = cell(9,2);

    allUsersPrefs(1:9,1) = {'Name';'CodeSpeed';'WordSpeed';'Frequency';...
        'AlphabetPrefs'; 'AudioFile';'FileUserCopied';'KeyboardInFile';...
        'SelectedUser'};

    allUsersPrefs(1:9,2) = {'DefaultUser'; 12; 6; 400; alphaPrefs ;...
        'AudioFile1.wav';'FileUserCopied1.txt';'KeyboardInFile1.txt';1};
        
% Get some GUI windows parameters
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

% Create windowsPrefs cell array
    windowsPrefs = cell(8,12);    
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
     windowsPrefs(1:8,8) = {'Window Preferences'; 1; WindowLeft+18;...
        WindowBottom; round(.82*WindowWidth); round(.9*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};   
     windowsPrefs(1:8,9) = {'WarningWindow'; 1; WindowLeft+21;...
         WindowBottom; round(.7*WindowWidth); round(1*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};   
    windowsPrefs(1:8,10) = {'Code Table'; 1; WindowLeft+24;...
        WindowBottom; round(1*WindowWidth); round(1*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};  
    windowsPrefs(1:8,11) = {'Help'; 1; WindowLeft+27;...
        WindowBottom; round(1*WindowWidth); round(1*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)};     
    windowsPrefs(1:8,12) = {'About'; 1; WindowLeft+30;...
        WindowBottom; round(.64*WindowWidth); round(.6*WindowHeight);...
        round(TextFont,1); round(TextHeight,1)}; 

end

