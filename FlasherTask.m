function FlasherTask(FlasherHandle, dotTime, codeGroup)
%FlasherTask Controls the display in the Flasher window.
%   Detailed explanation goes here

%% Initialize the user variables ----------------------------------
% Load the PreferencesFile.mat file from the ProgramData directory.
    load('ProgramData/PreferencesFile.mat',...
        'allUsersPrefs', 'windowsPrefs', 'glob');

    dotTime = dotTime+.02;
    numberCharacters = size(codeGroup, 2);
    characterCount = 1;
    firstDigit = codeGroup(characterCount);
        switch firstDigit
            case '.'
                flashTime = dotTime; 
            case '-'
                flashTime = 3*dotTime;
        end 
        
        set(FlasherHandle, 'Color', glob.flasherOn);

    startFlash = 0;
    
%% Set up a timer  ------------------------------------------------
    TimerHandle = timer(...
        'TimerFcn', @TimerTaskCallback,...
        'StartDelay', flashTime ...
    );

    % Start the timer task
        start(TimerHandle);    
    
%% TimerTaskCallback ----------------------------------------------
    function TimerTaskCallback(~,~)

        if numberCharacters == characterCount 
            set(FlasherHandle, 'Color', glob.flasherOff);
            stop(TimerHandle);
            delete(TimerHandle);
            return
        end
        
        if startFlash == 0
            set(FlasherHandle, 'Color', glob.flasherOff);
            stop(TimerHandle);
            delete(TimerHandle);
            
            TimerHandle = timer(...
                'TimerFcn', @TimerTaskCallback,...
                'StartDelay', dotTime ...
            );      
            start(TimerHandle);
            startFlash = 1;
            return
        end
        characterCount = characterCount + 1;          
        nextDigit = codeGroup(characterCount);
        switch nextDigit
            case '.'
                flashTime = dotTime; 
            case '-'
                flashTime = 3*dotTime;
        end
        set(FlasherHandle, 'Color', glob.flasherOn);
        stop(TimerHandle);
        delete(TimerHandle);
            
        TimerHandle = timer(...
            'TimerFcn', @TimerTaskCallback,...
            'StartDelay', flashTime ...
        );     
        start(TimerHandle);
        startFlash = 0;
        
    end % end TimerTaskCallback

end % end FlasherTask
