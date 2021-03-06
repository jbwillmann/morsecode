function ProgramPreferences()
% This function is called when the user selects Window Preferences 
% on the main figure menu. This window opens and the user can edit 
% Window Preferences.

%% Initialize the user variables ----------------------------------
% Get all the variables from the PreferencesFile.mat
% This loads the variable arrays allUsersPrefs, windowsPrefs and glob.
    load('ProgramData/PreferencesFile.mat', 'allUsersPrefs',...
        'windowsPrefs', 'glob');
  
% Set up some variables
    windowLeft = windowsPrefs{3,8};
    windowBottom = windowsPrefs{4,8};
    windowWidth = windowsPrefs{5,8};
    windowHeight =  windowsPrefs{6,8};
    textFont = windowsPrefs{7,8};
    line = ...
    '-------------------------------------------------------------------';
    userDisplayString = ['Selected User:  ' glob.selectedUserName];
    
%% Create the figure and its header -------------------------------
% Create the new figure
    figure(...
        'CloseRequestFcn',@CloseRequestCallback,...
        'Units', 'Characters',...
        'Position',[windowLeft,windowBottom,...
            windowWidth,windowHeight],...
        'NumberTitle', 'off', 'Toolbar', 'none', 'Resize', 'off',...  
        'MenuBar', 'none', 'DockControls', 'off',...
        'Color', glob.figureColor ,...
        'Name', 'Program Preferences'...
    );
    
% Set up Application title
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .83 1 .13 ],...
        'FontSize', textFont+2,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string','Program Preferences Management'...
        ); 
  
% Create uicontrol to display Current Selected User Name
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .75 1 .12 ],... 
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', userDisplayString...
        );
    
% Draw line
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .74 1 .05 ],...         
        'FontSize', textFont-5,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', line...
        );
    
%%  Window Functions --------=-------------------------------------
% Create uicontrol for checkbox about saving window position on exit
    uicontrol('Style', 'checkbox',...
        'Units', 'normalized',...
        'Position', [ .16 .65 .78 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', '  Save Window Position on exit',...
        'Style','check','Value',glob.saveWindows,...
        'Callback', @SavePositionCallback ...
    );

%%  Audio Functions -----------------------------------------------
% Draw line
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .60 1 .05 ],...         
        'FontSize', textFont-5,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', line...
        );
          
% Create uicontrol to display volume control
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .19 .50 .5 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Audio Volume  '...
        );

    uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .61 .53 .1 .07 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.boxColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', num2str(glob.volume,4),...
        'callback', @AudioCallback...
    );

%%  Flash Functions -----------------------------------------------
% Draw line
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .48 1 .05 ],...         
        'FontSize', textFont-5,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', line...
        );
          
% Create uicontrol checkbox for enabling the Flasher function
    uicontrol('Style', 'checkbox',...
        'Units', 'normalized',...
        'Position', [ .20 .40 .8 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', '  Enable Flasher Function',...
        'Style','check','Value',glob.flasherEnabled,...
        'Callback', @FlasherEnableCallback ...
    ); 

% Create uicontrol checkbox for docking the Flasher window
    uicontrol('Style', 'checkbox',...
        'Units', 'normalized',...
        'Position', [ .20 .34 .8 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', '  Dock Flasher Window',...
        'Style','check','Value',glob.flasherDocking,...
        'Callback', @FlasherDockingCallback ...
    ); 

% Create uicontrol to display Flasher colors
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .23 1 .12 ],... 
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Flasher colors - Click to change'...
        );

% On Color pushbutton
    OnHandle = uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [.31 .20 .15 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.flasherOn,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'On',...
        'callback', {@ChangeColorCallback, 1}...
    );

%  Off Color pushbutton
    OffHandle = uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [.56 .20 .15 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',glob.flasherOff,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Off',...
        'callback', {@ChangeColorCallback, 2}...
    );
     
%%  Action pushbuttons --------------------------------------------
% Draw line
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .14 1 .05 ],...         
        'FontSize', textFont-5,'FontWeight','bold',...
        'BackgroundColor',glob.figureColor,...
        'ForegroundColor',glob.foregroundColor,...
        'HorizontalAlignment','center',...
        'string', line...
        );
    
% Color pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [.09 .05 .2 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Color',...
        'callback', @WindowsColorsCallback...
    );
    
% Save pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [.41 .05 .2 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Save',...
        'callback', @saveWinCallback...
    );

%  Exit pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [.72 .05 .2 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'ForegroundColor',glob.foregroundColor,...
        'BackgroundColor',glob.backgroundColor,...
        'HorizontalAlignment','center',...
        'string', 'Exit',...
        'callback', @CloseRequestCallback...
    );

%% Callbacks ------------------------------------------------------
 % SavePositionCallback
    function SavePositionCallback(src , ~)
        glob.saveWindows = get(src,'Value');
    end

% AudioCallback
    function AudioCallback(src , ~)
        inputValue = str2double(get(src,'String'));
        if inputValue <= 1
            glob.volume = str2double(get(src,'String'));
        else
            set(src, 'String', ' ');
        end
    end

% FlasherEnableCallback
    function FlasherEnableCallback(src , ~)
        glob.flasherEnabled = get(src,'Value');
    end

% FlasherDockingCallback
    function FlasherDockingCallback(src , ~)
        glob.flasherDocking = get(src,'Value');
    end

% ChangeColorCallback
    function ChangeColorCallback(~,~,num)
        switch num
            case 1  % On Color
                selectedColor = uisetcolor(glob.flasherOn,...
                    'Select an On Color');
                set(OnHandle, 'BackgroundColor',selectedColor);
                glob.flasherOn = selectedColor;
            case 2  % Off Color
                selectedColor = uisetcolor(glob.flasherOff,...
                    'Select an Off Color');
                set(OffHandle, 'BackgroundColor',selectedColor);
                glob.flasherOff = selectedColor;
        end % switch   
    end

% WindowsColorsCallback
    function WindowsColorsCallback(~, ~)
        WindowsColors()
    end

% saveWinCallback
    function saveWinCallback(~,~)
        save('ProgramData/PreferencesFile.mat',...
            'allUsersPrefs', 'windowsPrefs', 'glob');
        CloseWindow()
    end
 
 % CloseRequestCallback 
    function CloseRequestCallback(~, ~)
        CloseWindow()
    end

end % end ProgramPreferences