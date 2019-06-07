function TransmitAlphabet()
% TransmitAlphabet transmits the alphabet from the codeTable

%% Initialize the user variables ----------------------------------
% Load the preferences file.
    load('ProgramData/PreferencesFile.mat', 'allUsersPrefs',...
        'windowsPrefs', 'glob');
    
% Load the codeTable file.
    load('ProgramData/CodeTableFile.mat', 'codeTable');

% Setup Current User data
    activeUserIndex = glob.selectedUserIndex;
    userName = glob.selectedUserName;
    
% Set up workspace variables.
    alphaPrefs = allUsersPrefs{5,activeUserIndex};
    space = 0;
    stopXmit = 0;
    firstTime = 0;
    sentString = [];
    saveTextFile = 0;
    helpString = ['To send code just begin typing. '...
    'All input is converted to caps and the only special '...
    'keys accepted are backspace, escape and F5. '...
    'Use F5 to toggle transmit on and off. '...
    'Backspace will delete the last keyboard input '...
    'and Escape will clear all entries to start over. '...
    'Select Save text to file below to save a copy of your '...
    'transmitted text to a file of your choice upon exit.'];
    
% Set up alphabet preferences
    switch alphaPrefs.include
        case 1  % Alphabet = 26
            alphaChosen = 'Alphabet Only';
            stopCount = 26;
        case 2  % Plus Numbers = 36
            alphaChosen = 'Alphabet + Numbers';
            stopCount = 36;
        case 3  % Plus Punctuation = 53
            alphaChosen = 'Alpha + Num + Punctuation';
            stopCount = 53;
        case 4  % Plus Special Characters = 59
            alphaChosen = 'Alpha + Num + Punctuation + Special';
            stopCount = 59;
    end
    
    if alphaPrefs.format == 1
        alphaMode = 'Sequential';
    else
        alphaMode = 'Random';
    end

    if alphaPrefs.group == 1
        isGroupName = 'No Groups';
    else
        isGroupName = 'Groups';
        currentGroupSize = alphaPrefs.min;
    end

    modeDisplay = ['Mode:  '  alphaChosen ' -  ' ...
        alphaMode ' -  ' isGroupName];
    enableAction = 'on';
    firstXmitAlpha = 0;


% Set some audio variables.
    frequency = allUsersPrefs{4,activeUserIndex};
    sampleRate = frequency*200; % 200 is samples per cycle
    
%% Set up main user interface  ------------------------------------
% Setup GUI parameters
    windowLeft = windowsPrefs{3,3};
    windowBottom = windowsPrefs{4,3};
    windowWidth = windowsPrefs{5,3};
    windowHeight =  windowsPrefs{6,3};
    textFont = windowsPrefs{7,3};
    
%   figure window
    AlphabetWinHandle = figure(...
        'CloserequestFcn',@CloseRequestCallback,...
        'Units', 'Characters',...
        'Position', [windowLeft, windowBottom,...
            windowWidth, windowHeight],...
        'NumberTitle', 'off','MenuBar', 'none','Resize', 'off',...
        'DockControls', 'off','Toolbar', 'none',...
        'Color', glob.figureColor ,...
        'Name', 'Transmit Alphabet'...
    );
      
%   Set up Application title
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .89 1 .1 ],...
        'FontSize', textFont+2,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Transmit Alphabet'...
    );

%   Set up Mode Display   
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .78 1 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', modeDisplay...
    ); 
   
%   Transmitted Character Display    
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .02 .67 .2 .17 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...            
        'string', 'Character being Transmitted'...
    ); 
    
    XmitCharacterHandle = uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .05 .20 .13 .44 ],...
        'FontSize', 6*textFont,'FontWeight','bold',...
        'BackgroundColor',glob.xmitBackgroundColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', ' '...
    ); 

    XmitCharacterNameHandle = uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .01 .07 .2 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Character Name'...
    ); 

%   Transmitted Character String Display   
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .4 .65 .3 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',... 
        'string', 'String Being Transmitted'...
    ); 

    XmitStringHandle = uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .25 .20 .7 .45 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.boxColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','left',...
        'min',0,'max',10,'enable','inactive',...
        'string', helpString...
    );

%% Action pushbuttons  --------------------------------------------
% Save text file checkbox
    uicontrol('Style', 'checkbox',...
        'Units', 'normalized',...
        'Position', [ .25 .06 .22 .1 ],...
        'FontSize', textFont-1,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Save text file on exit',...
        'Callback', @CheckBoxCallback ...
    );

%   Select Mode pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .49 .06 .14 .1 ],...
        'FontSize', textFont-1,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...    
        'string', 'Select Mode',...
        'Callback', @SelectModeCallback ...
    );

%   Start/Stop pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .65 .06 .21 .1 ],...
        'FontSize', textFont-1,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',... 
        'string', 'Start Transmission',...
        'Enable', enableAction,...
        'Callback', @StartStopCallback ...
    );
    
%   Exit pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .88 .06 .07 .1 ],...
        'FontSize', textFont-1,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',... 
        'string', 'Exit',...
        'Callback', @CloseRequestCallback ...
    );

%% CheckBoxCallback -----------------------------------------------
    function CheckBoxCallback(src , ~)
        saveTextFile = get(src,'Value');
    end % end CheckBoxCallback

%% Open Flasher window if enabled ---------------------------------
   if glob.flasherEnabled == 1
        if glob.flasherDocking == 1
            winPosition = get(gcf, 'Position');
        else
            winPosition = 0;
        end
        FlasherHandle = FlasherWindow(winPosition);
        pause(.1);
        figure(AlphabetWinHandle);
    end

%% Xmit Alphabet Processing ---------------------------------------
% This function is called by the StartStopCallback when the 
% Start Transmission button is selected
    function XmitAlphabet
        
        isRandom = alphaPrefs.format;   % 1 = continuous; 2 = random
        isGroup = alphaPrefs.group;     % 1 = no group; 2 = group
        groupMin = alphaPrefs.min;      % group minimum size
        groupMax = alphaPrefs.max;      % group maximum size

        persistent characterIndex  groupCount 
        
        if firstXmitAlpha == 0
            sentString = [];
            characterIndex = 0;
            firstXmitAlpha = 1;
            groupCount = 0;
            space = 0;
        end
        
    %  Output the CodeTable a character at a time;
        previousCharacterIndex = 0;

        while stopXmit == 0
            if isRandom == 1    % Sequential
                characterIndex = characterIndex + 1;
                if characterIndex > stopCount
                    characterIndex = 1;
                end
            else    % Random
                characterIndex = randi(stopCount);
                if characterIndex == previousCharacterIndex
                    characterIndex = randi(stopCount);
                end
                previousCharacterIndex = characterIndex;
            end
            
            if isGroup == 2 % Make groups
                groupCount = groupCount + 1;
                if groupMin == groupMax  % Fixed group Size           
                    if groupCount > groupMax% Send a space
                        space = 1;
                        saveCharacterIndex = characterIndex;
                        characterIndex = 60;
                        groupCount = 0;
                    end
                else    % Random group size
                    if groupCount > currentGroupSize  % Send a space
                        space = 1;
                        saveCharacterIndex = characterIndex;
                        characterIndex = 60;
                        groupCount = 0;
                        currentGroupSize = randi([groupMin,groupMax]);
                    end
                end
            end

            currentCharacter = codeTable{characterIndex,1};
            currentCharacterName = codeTable{characterIndex,4};
            codeGroup = codeTable{characterIndex,2};
            sentString = [sentString ' ' currentCharacter];
            
            if glob.flasherEnabled == 1
                if space == 0
                    FlasherTask(FlasherHandle, glob.dotTime, codeGroup);
                end
            end
            
            % Update the displays
            set(XmitCharacterHandle, 'string', currentCharacter );
            set(XmitCharacterNameHandle, 'string', currentCharacterName );
            set(XmitStringHandle, 'string', sentString );
            drawnow

            % Transmit the character
            player = audioplayer(glob.volume*codeTable{characterIndex,6}, sampleRate);
            playblocking(player);
            space = 0;
            if characterIndex == 60
                characterIndex = saveCharacterIndex-1;
            end
        end
        
    % Stopped transmitting. Clear transmit character display of last
    % sent character        
        if ishandle(XmitCharacterHandle)
            set(XmitCharacterHandle, 'string', ' ' );
            set(XmitCharacterNameHandle, 'string', ' ' );
        end
        stopXmit = 0;
        
    end % end XmitAlphabet

%% SelectModeCallback ---------------------------------------------
    function SelectModeCallback(~, ~, ~)
           AlphabetPreferences(AlphabetWinHandle);
    end % end SelectModeCallback

%% StartStopCallback callback -------------------------------------
    function StartStopCallback(src, ~, ~)
        if firstTime == 0           
            firstTime = 1;           
            set(src, 'string', 'Pause Transmission')
            XmitAlphabet;
        else
            stopXmit = 1;
            firstTime = 0;
            set(src, 'string', 'Start Transmission')
        end       
    end % end StartStopCallback

%% CloseRequestCallback -------------------------------------------
    function CloseRequestCallback(~, ~)
        stopXmit = 1;
        
    % Close Flasher window if enabled
        if glob.flasherEnabled == 1
            if ishandle(FlasherHandle)
                pause(.2);
                close(FlasherHandle);
            end
        end
        
    % Write input text to .txt file if enabled   
        if firstXmitAlpha == 1 && saveTextFile == 1
            defaultFileName = 'AlphabetText';
            startDirectory = cd;           
            [fileNameWithTag, fileDirectory] = uiputfile({'*.txt'},...
            'Save the Text file',...
            [startDirectory  '\UserData\' userName '\' defaultFileName]);
            if fileDirectory ~= 0
                fileName = [fileDirectory '\' fileNameWithTag];
                fid = fopen(fileName,'w');
                fprintf(fid, sentString);
                fclose(fid);
            end             
        end  
        
    % Finish closing
        CloseWindow()
        
    end % end CloseRequestCallback

end % end TransmitAlphabet