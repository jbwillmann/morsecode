function TransmitKeyboard
% TransmitKeyboard transmits code from the keyboard

%% Initialize the user variables ----------------------------------
% Load the preferences file.
    load('ProgramData/PreferencesFile.mat', 'allUsersPrefs',...
        'windowsPrefs', 'glob');
    
% Load the CodeTableFile.
    load('ProgramData/CodeTableFile.mat', 'codeTable');

% Setup Current User data
    activeUserIndex = glob.selectedUserIndex;
    userName = glob.selectedUserName;
    
% Set up workspace variables.
    audioBusy = 0;
    transmittingOn = 0;
    characterInCount = 0;   % Number of valid Morse input characters typed
    sentKbdString = [];         % Transmitted string
    inputString = cell(4,1);    % Clear input array
    displayInputString = [];    % To display typed input
    defaultString = ['To send code just begin typing. '...
    'All input is converted to caps and the only special '...
    'keys accepted are backspace, escape and F5. '...
    'Use F5 to toggle transmit on and off. '...
    'Backspace will delete the last keyboard input '...
    'and Escape will clear all entries to start over.'];
    transmitControlOffString = ...
        'Use F5 to toggle Transmit On/Off. Current status - Off';
    transmitControlOnString = ...
        'Use F5 to toggle Transmit On/Off. Current status - On';
   
    % Set some audio variables.
    frequency = allUsersPrefs{4,activeUserIndex};
    sampleRate = frequency*200; % 200 is samples per cycle

%% Set up main user interface  ------------------------------------
% Setup GUI parameters
    windowLeft = windowsPrefs{3,5};
    windowBottom = windowsPrefs{4,5};
    windowWidth = windowsPrefs{5,5};
    windowHeight =  windowsPrefs{6,5};
    textFont = windowsPrefs{7,5};

%   figure window
    TransmitKeyboardHandle = figure(...
        'CloseRequestFcn',@CloseRequestCallback,...
        'Units', 'Characters',...
        'Position',[windowLeft, windowBottom,...
            windowWidth,windowHeight],...
        'KeyPressFcn',@KeyPressCallback,...
        'NumberTitle', 'off','MenuBar', 'none','Resize', 'off',...
        'DockControls', 'off','Toolbar', 'none',...
        'Color', glob.figureColor, ...
        'Name', 'Transmit Keyboard'...
    );

%   Set up Application title
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .88 1 .1 ],...
        'FontSize', textFont+2,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'HorizontalAlignment','center',...
        'string', 'Transmit from Keyboard'...
    );

% Transmit Control Display 
    XmitControlHandle = uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .78 1 .1 ],...
        'FontSize', textFont+1,'FontWeight','bold',...
        'HorizontalAlignment','center',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'string', transmitControlOffString...
    ); 
  
%   Transmitted Character Display    
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .02 .6 .2 .17 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'HorizontalAlignment','center',...
        'string', 'Character being Transmitted'...
    ); 
    
    XmitCharacterHandle = uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .05 .23 .13 .38 ],...
        'FontSize', 6*textFont,'FontWeight','bold',...
        'BackgroundColor',glob.xmitBackgroundColor,...
        'HorizontalAlignment','center',...
        'string', ' '...
    ); 

    XmitCharacterNameHandle = uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .02 .08 .2 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'HorizontalAlignment','center',...
        'string', 'Character Name '...
    ); 

%   Transmitted Character String Display   
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .4 .67 .3 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'HorizontalAlignment','center',...
        'string', 'String Being Transmitted'...
    ); 

    XmitStringHandle = uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .25 .22 .7 .45 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.boxColor,...
        'HorizontalAlignment','left',...
        'min',0,'max',10,'enable','inactive',...
        'string', defaultString...
    );
    
% Keyboard Input String Display 
     uicontrol('Style', 'text',...
         'Units', 'normalized',...
        'Position', [ .23 .07 .2 .1 ],...
        'FontSize', textFont+1,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'HorizontalAlignment','center',...
        'string', 'Keyboard Input:'...
    ); 
    
    KbdStringHandle = uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .42 .07 .44 .1 ],...                  
        'FontSize', textFont+2,'FontWeight','bold',...
        'BackgroundColor',glob.boxColor,...
        'HorizontalAlignment','left',...
        'min',1,'max',1,'enable','inactive',...
        'string', ' '...
    );

%% Action pushbutton   --------------------------------------------
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

%% Open Flasher window if enabled ---------------------------------
    if glob.flasherEnabled == 1
        if glob.flasherDocking == 1
            winPosition = get(gcf, 'Position');
        else
            winPosition = 0;
        end
        FlasherHandle = FlasherWindow(winPosition);
        pause(.1);
        figure(TransmitKeyboardHandle);
    end
    
%% Start the program ----------------------------------------------
TxLoop()

%% Set up transmission loop  --------------------------------------
    function TxLoop 
        while transmittingOn
        % If there are no characters to transmit then exit
            if characterInCount < 1  
                % Clear transmit character display of last sent character
                set(XmitCharacterHandle, 'string', ' ');
                set(XmitCharacterNameHandle, 'string', ' ' );
%                 transmittingOn = 0;
%                 set(XmitControlHandle,'string', transmitControlOffString);
                return
            end

        % We have a character to transmit. It's the first on the string
            audioBusy = 1;
            characterIn = inputString{1,1};        
            waveFile = inputString{2,1};
            currentCharacterName = inputString{3,1};
            codeGroup = inputString{4,1};

        % remove the first entry and reduce the character count
            inputString = inputString(:,2:characterInCount);
            characterInCount = characterInCount - 1;

        % Remove the first character in the displayInputString and 
        % add to the output string
            displayInputString = ...
                    displayInputString(1,2:size(displayInputString,2));           
            sentKbdString = [sentKbdString ' ' characterIn];

        % Update the displays
            set(KbdStringHandle, 'string', displayInputString);
            set(XmitCharacterHandle, 'string', characterIn);
            set(XmitCharacterNameHandle, 'string', currentCharacterName );
            set(XmitStringHandle, 'string',  sentKbdString );
            drawnow % nocallbacks 
            
            if glob.flasherEnabled == 1
                FlasherTask(FlasherHandle, glob.dotTime, codeGroup);
            end
            
        % Transmit the character
            player = audioplayer(glob.volume*waveFile, sampleRate);
            playblocking(player);
        
            audioBusy = 0;
            
        end % end while transmittingOn

    end % end TxLoop

%% KeyPressCallback -----------------------------------------------
    function KeyPressCallback(~, evnt)
        keyIn = evnt.Key;
        % Clear all entries to start over if escape is pressed
        if strcmp(keyIn, 'escape')
            set(XmitCharacterHandle, 'string', ' ');
            set(XmitStringHandle, 'string', defaultString);
            set(KbdStringHandle, 'string', ' ');
            set(XmitControlHandle,'string', transmitControlOffString);
            transmittingOn = 0;
            characterInCount = 0;   % Number of valid input characters
            sentKbdString = [];         % Transmitted string
            inputString = cell(4,1);    % Clear input array          
            displayInputString = [];    % To display typed input
            drawnow nocallbacks 
            return
        end
        
        % Remove the last character if backspace is entered 
        % and there is a character to delete   
        if characterInCount > 0 && strcmp(keyIn, 'backspace')
            characterInCount = characterInCount-1;
            inputString = inputString(:,1:characterInCount);
            displayInputString = ...
                displayInputString(1,1:size(displayInputString,2) - 1);
            set(KbdStringHandle, 'string', displayInputString);
            drawnow nocallbacks 
            return
        end
        
        % If F5 is pressed toggle transmit on/off
        if strcmp(keyIn, 'f5')
            if transmittingOn == 0              
                transmittingOn = 1;
                set(XmitControlHandle,'string', transmitControlOnString);
                TxLoop()
            else
                transmittingOn = 0;
                pause(1);
                set(XmitControlHandle,'string', transmitControlOffString);
                set(XmitCharacterHandle, 'string', ' ');
                set(XmitCharacterNameHandle, 'string', ' ' );
            end
            return   
        end
        
     %  A character has been typed that needs to be processed. 
     %  If it is a valid character. Convert to upper and find
     %  it in the CodeTable.   
        typedCharacter = upper(evnt.Character);
        Found = 0;
        % Look through the code table for the typed character
        for m=1:60
            if typedCharacter == codeTable{m,1}
                characterInCount = characterInCount+1;
                inputString{1,characterInCount} = typedCharacter; 
                inputString{2,characterInCount} = codeTable{m,6}; 
                inputString{3,characterInCount} = codeTable{m,4};
                inputString{4,characterInCount} = codeTable{m,2};
                Found = 1;
                break
            end
        end
        
        %  If it wasn't found get out and wait for the next one   
        if Found == 0
            return
        end
        
        % Display the character in the keyboard input display
        if characterInCount == 1    % First one
            displayInputString = typedCharacter;
            for ind = 1:20
                if audioBusy == 0
                    TxLoop();
                    return
                else            
                    pause(.04);
                end
            end
            
        else
            displayInputString = [displayInputString  typedCharacter];
        end
        set(KbdStringHandle, 'string', displayInputString);
        drawnow
        
    end % end KeyPressCallback
                  
%% CloseRequestCallback -------------------------------------------
    function CloseRequestCallback(~, ~)
        
    % Close Flasher window if enabled
        if glob.flasherEnabled == 1
            if ishandle(FlasherHandle)
                pause(.2);
                close(FlasherHandle);
            end
        end
        
     % Write input text to .txt file if enabled   
        if glob.saveTextOnExit == 1
            baseFileName = 'EnteredText';
            startDirectory = cd;           
            fileName = [startDirectory '\UserData\'...
                userName '\' baseFileName '.txt'];
            fid = fopen(fileName,'w');
            fprintf(fid, sentKbdString);
            fclose(fid);
        end
     
    % Finish up
        CloseWindow()
        
    end % end CloseRequestCallback

end % end TransmitKeyboard