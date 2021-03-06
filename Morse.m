function Morse()
% This is the main program to start the process. See the file      
% MorseHelp/MorseHelp.html for all the details.

%% Initialize the user variables ----------------------------------
% First, test to see if the PreferencesFile.mat file is in the
% ProgramData directory. If not, set some varables and create the file.
    if exist('ProgramData/PreferencesFile.mat','file') == 0
        InitializeProgram()
    end
    
% Load the PreferencesFile.mat file from the ProgramData directory.
    load('ProgramData/PreferencesFile.mat',...
        'allUsersPrefs', 'windowsPrefs', 'glob');
    
% Setup Current User data
    activeUserIndex = glob.selectedUserIndex;
    userName = glob.selectedUserName;
    
% Build the code table for the selected user    
    codeSpeed = allUsersPrefs{2,activeUserIndex};
    wordSpeed = allUsersPrefs{3,activeUserIndex};
    frequency = allUsersPrefs{4,activeUserIndex};
    samplesPerCycle = 200;
    codeTable = FillCodeTable(codeSpeed, wordSpeed,...
        frequency, samplesPerCycle);
    
% Save the codeTable to the CodeTableFile.mat file in the ProgramData
% directory
    save('ProgramData/CodeTableFile.mat', 'codeTable'); 

%% Set up main user interface  ------------------------------------

% Setup GUI parameters 
    windowLeft = windowsPrefs{3,2};
    windowBottom = windowsPrefs{4,2};
    windowWidth = windowsPrefs{5,2};
    windowHeight =  windowsPrefs{6,2};
    textFont = windowsPrefs{7,2};

%   Main figure window
    figure(...
        'CloseRequestFcn',@CloseWindow,...
        'Units', 'Characters',...
        'Position',[windowLeft, windowBottom,...
            windowWidth,windowHeight],...
        'NumberTitle', 'off','MenuBar', 'none','Resize', 'off',...
        'DockControls', 'off','Toolbar', 'none',...
        'Color', glob.figureColor ,...
        'Name', 'Morse'...
    );
      
%   Set up Application title
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .89 1 .1 ],...
        'FontSize', textFont+2,'FontWeight','bold',...
        'BackgroundColor', glob.figureColor,...
        'ForegroundColor', glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Morse Code Practice System'...
    ); 
 
% Create uicontrol to display User Name
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .75 1 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor', glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', ['User Name:  ' userName]...
    ); 

% Create uicontrol to display Code Speed
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .1 .62 .4 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor', glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', ['Code Speed:  ' num2str(codeSpeed)]...      
    );
    
% Create uicontrol to display Word Speed
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .5 .62 .4 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor', glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', ['Word Speed:  ' num2str(wordSpeed)]...
    ); 
 
% Create uicontrol to display SEND text label
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .49 1 .1 ],... 
        'FontSize', textFont+2,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor', glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'SEND'...
    ); 
 
% Create uicontrol to draw a horziontal line
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .4 1 .09 ],...            
        'FontSize', textFont-2,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor', glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', ['_________________________________' ,...
        '_________________________']...
    );

%% Action pushbuttons  --------------------------------------------

%   Transmit Alphabet pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .025 .13 .3 .2 ],...
        'FontSize', textFont-2,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...    
        'string', 'Transmit Alphabet',...
        'Callback', @TransmitAlphabetCallback ...
    );

%   Transmit File pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .35 .13 .3 .2 ] ,...
        'FontSize', textFont-2,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Transmit File',...
        'Callback', @TransmitFileCallback ...
    );
    
%   Transmit from Keyboard pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .675 .13 .3 .2 ] ,...
        'FontSize', textFont-2,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Transmit Keyboard',...
        'Callback', @TransmitKeyboardCallback ...
    );

%% Drop down menus  -----------------------------------------------
%   Drop down menus for main window

    % Preferences Menus
    pm = uimenu('Label', '| Preferences |',...
        'ForegroundColor',glob.foregroundColor ...
    );
        uimenu(pm, 'Label', 'User Preferences',...
            'ForegroundColor',glob.foregroundColor,...
            'Callback',@UserPreferencesCallback ...
        );
        uimenu(pm, 'Label', 'Program Preferences',...
            'ForegroundColor',glob.foregroundColor,...
            'Callback',@ProgramPreferencesCallback ...
        );

        uimenu(pm, 'Label', 'Reset All Preferences',...
            'ForegroundColor',glob.foregroundColor,...
            'Callback', @ResetPreferencesCallback ...
        );

    % File Menus
    fm = uimenu('Label', '| File |',...
        'ForegroundColor',glob.foregroundColor...
    );
        uimenu(fm, 'Label', 'Play Audio File',...
            'ForegroundColor',glob.foregroundColor,...
            'Callback', @PlayAudioCallback ...
        );

    % Help Menus
    hm = uimenu('Label', '|  Help  |',...
        'ForegroundColor',glob.foregroundColor...
    );
        uimenu(hm, 'Label', 'Help',...
            'ForegroundColor',glob.foregroundColor,...
            'Callback', @HelpCallback...
        );
            uimenu(hm, 'Label', 'Code Table',...
                'ForegroundColor',glob.foregroundColor,...
            'Callback', @DisplayCodeTableCallback ...
        );
        uimenu(hm, 'Label', 'About',...
            'ForegroundColor',glob.foregroundColor,...
            'Callback', @AboutCallback...
        );
    
%% Action Buttons Callbacks----------------------------------------
    % Transmit Alphabet
    function TransmitAlphabetCallback(~,~)
        TransmitAlphabet();
    end

    % Transmit File
    function TransmitFileCallback(~,~)
        TransmitFile();
    end

    % Transmit Keyboard
    function TransmitKeyboardCallback(~,~)
        TransmitKeyboard();
    end
           
%% Menu Callbacks -------------------------------------------------
% User Preferences Callback
    function UserPreferencesCallback(~,~)
        UserPreferences();
    end

% Window Preferences Callback
    function ProgramPreferencesCallback(~,~)
        ProgramPreferences();
    end

% Reset Preferences Callback
    function ResetPreferencesCallback(~, ~ )        
    % Display a warning message to allow the user to cancel
    
    % Message string to display
        messageString = ['This will delete all users and '...
            'the UserData directory and reset every thing to '...
            '"factory defaults". '...
            'Select OK to proceed or Exit cancel.']; 
        
    % Call the function to display the message box
        userAction = WarningWindow(messageString);
     
    % User didn't cancel so do it, otherwise just return
        if userAction == 1    
            delete('ProgramData/PreferencesFile.mat');
            delete('ProgramData/CodeTableFile.mat')
            delete(gcf)
            run('Morse')
        end        
    end

% Play Audio File Callback
    function PlayAudioCallback(~, ~)
        WavePlay(userName);
    end

% Help Callback
    function HelpCallback(~,~)
        HelpAndAboutDisplay(1);
    end

% Code Table Callback
    function DisplayCodeTableCallback(~,~)
        DisplayCodeTable();
    end

% About Callback
    function AboutCallback(~,~)
        HelpAndAboutDisplay(2);
    end

end % end Morse