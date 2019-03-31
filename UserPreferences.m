function UserPreferences()
% This function is called when the user selects User Preferences on 
% the main figure menu. A preferences window is opened and the user
% can edit user preferences. A new User can also be created.
% Unless the the user exits without making changes, the main program, 
% Morse is restarted and reinitilized with the new changes.

%% Initilize the user variables -----------------------------------
% Get all the varables from the PreferencesFile.mat
% This loads the varable arrays allUsersPrefs and windowsPrefs
    load('ProgramData/PreferencesFile.mat', 'allUsersPrefs',...
        'windowsPrefs', 'glob');

% Get the number of users
    numUsers = size(allUsersPrefs,2);

% Populate the allUserNames array.
    allUserNames{1} = 'Select a User';
    allUserNames{2} = 'Add a New User';
    allUserNames(3:numUsers+1) = allUsersPrefs(1,2:numUsers);
    
% Determine SelectedUser
    for index = 2:numUsers
        if allUsersPrefs{9,index} == 1
            break;
        end
    end
    
% Index of the selected user
    currentUserIndex = index;

% Get selected user name
    currentUserName = allUsersPrefs{1, currentUserIndex};
    
% Initilize some variables
    tempNewUser = cell(9);
    inputCount = zeros(4,1);
    workingUserName = '';
    dropdownSelect = 0;
    userSelect = 0;
    codeSpeed = 0;
    userNamePrompt = 'Enter New Values';
    numericWarning1 = 'You must enter a numeric value!';
    numericWarning2 = 'There is a missing entry';

% Get the handle of the calling figure
    MorseFigHandle = findobj('Type', 'figure');
    
%% Set up main user interface  ------------------------------------

% Setup GUI parameters       
    windowWidth = windowsPrefs{5,6};
    windowHeight =  windowsPrefs{6,6};
    textFont = windowsPrefs{7,6};

    green = [.255 .627 .225];     
    white = [1  1  1]; 
    
% Create the new figure
    figure(...
        'CloseRequestFcn',@CloseRequestCallback,...
        'Units', 'characters',...
        'Position',[windowsPrefs{3,6},windowsPrefs{4,6},...
            windowWidth,windowHeight],...
        'NumberTitle', 'off','MenuBar', 'none','Resize', 'off',...
        'DockControls', 'off','Toolbar', 'none','Color', white, ...
        'Name', 'User Preferences'...
        );
    
% Set up Application title
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .89 1 .1 ],...
        'FontSize', textFont+2,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'string','User Preferences Management'...
        ); 
    
% Create uicontrol to display Current Selected User Name
    UserDisplayHandle = uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ 0 .8 1 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'string', ['Current Selected User:  ' currentUserName]...
        ); 

% Create drop down box to display all users for selection
    DropDownHandle = uicontrol('Style', 'popup',...
        'Units', 'normalized',...
        'Position', [ .2 .70 .6 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'string', allUserNames,...
        'callback', {@UpdateUserCallback, 0 });

% Create uicontrol to display User Name
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .1 .58 .3 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'string', '  User Name:  '...
        ); 

    UserNameHandle = uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .4 .60 .4 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'enable','inactive',...
        'string', ' ',...
        'callback', {@UpdateUserCallback, 1 });
    
% Create uicontrol to display Code Speed
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .1 .47 .3 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'string', 'Code Speed:  '...
        ); 

    CodeSpeedHandle = uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .4 .49 .4 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'enable','inactive',...
        'string', ' ',...
        'callback', {@UpdateUserCallback, 2 }...
        );
    
% Create uicontrol to display Word Speed
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .1 .34 .3 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'string', 'Word Speed:  '...
        );  

   WordSpeedHandle = uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .4 .36 .4 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'enable','inactive',...
        'string', ' ',...
        'callback', {@UpdateUserCallback, 3 }...
        );

% Create uicontrol to display Frequency
    uicontrol('Style', 'text',...
        'Units', 'normalized',...
        'Position', [ .1 .23 .3 .1 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'string', '  Frequency:  '...
        );  

   FrequencyHandle = uicontrol('Style', 'edit',...
        'Units', 'normalized',...
        'Position', [ .4 .25 .4 .08 ],...
        'FontSize', textFont,'FontWeight','bold',...
        'BackgroundColor',white,'HorizontalAlignment','center',...
        'enable','inactive',...
        'string', ' ',...
        'callback', {@UpdateUserCallback, 4 }...
        );

%% Action pushbuttons ---------------------------------------------
%   Save/Add pushbutton
    SaveAddPushbuttonHandle = uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .05 .08 .15 .12 ],...
        'FontSize', textFont-2,'FontWeight','bold',...
        'ForegroundColor', green,'HorizontalAlignment','center',...
        'enable','inactive',...
        'string', '',...
        'callback', {@UpdateUserCallback, 5 }...
        );
    
% Make Active pushbutton
    MakeActivePushbuttonHandle = uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .245 .08 .25 .12 ],...
        'FontSize', textFont-2,'FontWeight','bold',...
        'ForegroundColor', green,'HorizontalAlignment','center',...
        'enable','inactive',...
        'string', '',...
        'callback', {@UpdateUserCallback, 6 }...
        );
    
%   Delete pushbutton
    DeletePushbuttonHandle = uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .54 .08 .18 .12 ],...
        'FontSize', textFont-2,'FontWeight','bold',...
        'ForegroundColor', green,'HorizontalAlignment','center',...
        'enable','inactive',...
        'string', '',...
        'callback', {@UpdateUserCallback, 7 }...
        );
       
%   Exit pushbutton
    uicontrol('Style', 'pushbutton',...
        'Units', 'normalized',...
        'Position', [ .76 .08 .14 .12 ],...
        'FontSize', textFont-2,'FontWeight','bold',...
        'ForegroundColor', green,'HorizontalAlignment','center',...
        'string', 'Exit',...
        'callback', {@UpdateUserCallback, 8 }...
        );
     
%% UpdateUserCallback ---------------------------------------------
function UpdateUserCallback(src, ~, num)
    switch num
        case 0  % Drop Down Menu
            dropdownSelect = get(src,'Value');
            
            % Index of selected uder if dropdownSelect > 2.
            userSelect = dropdownSelect - 1;
            
            if dropdownSelect == 1   % Select a User - Clear and return.
                tempNewUser = cell(9);
                set(UserNameHandle,'string',' ');
                set(CodeSpeedHandle,'string',' ');
                set(WordSpeedHandle,'string',' ');
                set(FrequencyHandle,'string',' ');
                set(SaveAddPushbuttonHandle,'string','');
                set(SaveAddPushbuttonHandle,'enable','inactive');
                set(MakeActivePushbuttonHandle,'string','');
                set(MakeActivePushbuttonHandle,'enable','inactive');
                set(DeletePushbuttonHandle,'string','');
                set(DeletePushbuttonHandle,'enable','inactive');
            end
            
            if dropdownSelect == 2  % Add a new user
                tempNewUser = cell(9);
                inputCount = zeros(4,1);
                set(UserNameHandle,'string',userNamePrompt);
                set(CodeSpeedHandle,'string','X');
                set(WordSpeedHandle,'string','X');
                set(FrequencyHandle,'string','X');
                set(UserNameHandle,'enable','on');
                set(CodeSpeedHandle,'enable','on');
                set(WordSpeedHandle,'enable','on');
                set(FrequencyHandle,'enable','on');
                set(SaveAddPushbuttonHandle,'string','Save');
                set(SaveAddPushbuttonHandle,'enable','on');
                set(DeletePushbuttonHandle,'string','');
                set(DeletePushbuttonHandle,'enable','inactive');
            end
            
            if dropdownSelect == 3  % Default user selected
                set(UserNameHandle,'string',allUsersPrefs{1, userSelect});
                set(CodeSpeedHandle,'string',allUsersPrefs{2, userSelect});
                set(WordSpeedHandle,'string',allUsersPrefs{3, userSelect});
                set(FrequencyHandle,'string',allUsersPrefs{4, userSelect});
                set(UserNameHandle,'enable','inactive');
                set(CodeSpeedHandle,'enable','inactive');
                set(WordSpeedHandle,'enable','inactive');
                set(FrequencyHandle,'enable','inactive');
                set(SaveAddPushbuttonHandle,'string','');
                set(SaveAddPushbuttonHandle,'enable','inactive');
                set(DeletePushbuttonHandle,'string','');
                set(DeletePushbuttonHandle,'enable','inactive');
                if currentUserIndex > 2
                    set(MakeActivePushbuttonHandle,'string','Make Active');
                    set(MakeActivePushbuttonHandle,'enable','on');
                end
            end
            
            if dropdownSelect > 3
                workingUserName = allUsersPrefs{1, userSelect};
                set(UserNameHandle,'string',allUsersPrefs{1, userSelect});
                set(CodeSpeedHandle,'string',allUsersPrefs{2, userSelect});
                set(WordSpeedHandle,'string',allUsersPrefs{3, userSelect});
                set(FrequencyHandle,'string',allUsersPrefs{4, userSelect});
        %        set(UserNameHandle,'enable','on');
                set(CodeSpeedHandle,'enable','on');
                set(WordSpeedHandle,'enable','on');
                set(FrequencyHandle,'enable','on');
                set(SaveAddPushbuttonHandle,'string','Save');
                set(SaveAddPushbuttonHandle,'enable','on');
                if currentUserIndex ~= userSelect
                    set(MakeActivePushbuttonHandle,'string','Make Active');
                    set(MakeActivePushbuttonHandle,'enable','on');
                end
                set(DeletePushbuttonHandle,'string','Delete');
                set(DeletePushbuttonHandle,'enable','on');
                
            end   
            
        case 1  % User Name          
            userName = get(src,'String');           
            inputCount(1) = 1;
            if dropdownSelect == 2  % Add new user
                tempNewUser{1} = userName;
            else
                allUsersPrefs{1, userSelect} = userName;
            end

        case 2  % Code Speed
            codeSpeed = str2double(get(src,'String'));
            if isnan(codeSpeed)
                WarningWindow(windowsPrefs,numericWarning1);
                set(src,'String',' ');
                inputCount(2) = 0;
                return
            end
            inputCount(2) = 1;
            if dropdownSelect == 2
                tempNewUser{2} = codeSpeed;
            else
                allUsersPrefs{2, userSelect} = codeSpeed;
            end

        case 3  % Word Speed
            wordSpeed = str2double(get(src,'String'));
            if isnan(wordSpeed)
                WarningWindow(windowsPrefs,numericWarning1);
                set(src,'String',' ');
                inputCount(3) = 0;
                return
            end
            inputCount(3) = 1;
            if dropdownSelect == 2
                set(src,'string',num2str(wordSpeed));         
                tempNewUser{3} = wordSpeed;
            else
                allUsersPrefs{3, userSelect} = wordSpeed;
            end
                                
        case 4  % Frequency
            frequency = str2double(get(src,'String'));
            if isnan(frequency)
                WarningWindow(windowsPrefs,numericWarning1);
                set(src,'String',' ');
                inputCount(4) = 0;
                return
            end
            inputCount(4) = 1;
            if dropdownSelect == 2
                tempNewUser{4} = frequency;
            else
                allUsersPrefs{4, userSelect} = frequency;
            end
            
        case 5  % Save changes           
            if dropdownSelect == 2  % Add a new user
                % Make sure that all 4 entry boxes have been filled by the
                % operator
                for index0 = 1:4
                    if inputCount(index0) ~= 1
                        WarningWindow(windowsPrefs,numericWarning2);
                        return
                    end
                end

                % Add the new user to the allUsersPrefs array 
                numUsers = numUsers+1;
                allUsersPrefs(1:4, numUsers) = tempNewUser(1:4);
                allUsersPrefs(5:8, numUsers) = allUsersPrefs(5:8, 2);
                allUsersPrefs{9, numUsers} = 0;
                
                % Add the new user to the drop down menu
                allUserNames = [allUserNames tempNewUser{1}];
                
                
                % Make a new directory if one doesnt already exist
                newDir = ['UserData/' tempNewUser{1}];
                if exist(newDir, 'dir') == 7
                else
                    mkdir(newDir)
                end                                                           
            end
            
            % Clean up the ui
            set(DropDownHandle,'string', allUserNames);
            set(DropDownHandle,'value',1);
            set(UserNameHandle,'string',' ');
            set(CodeSpeedHandle,'string',' ');
            set(WordSpeedHandle,'string',' ');
            set(FrequencyHandle,'string',' ');  
            
            % Update all the files
            save('ProgramData/PreferencesFile.mat',...
                'allUsersPrefs', 'windowsPrefs','glob');
            
            % Update Morse.n if the current user is modified
            if currentUserName ==  workingUserName
                delete(gcf)
                delete(MorseFigHandle)
                run('Morse')
            end
            
        case 6  % Make Active  
                allUsersPrefs{9, currentUserIndex} = 0;
                allUsersPrefs{9, userSelect} = 1;
                selectedUserName = allUsersPrefs{1, userSelect};
                glob.selectedUserName = selectedUserName;
                glob.selectedUserIndex = userSelect;
                set(UserDisplayHandle,'string',...
                    ['Current Selected User:  ' selectedUserName]);
                save('ProgramData/PreferencesFile.mat',...
                    'allUsersPrefs', 'windowsPrefs','glob');
                
                delete(gcf)
                delete(MorseFigHandle)
                run('Morse')

        case 7  % Delete a user
            messageString = ...
                ['This will delete the currently selected User. '...
                        'Select OK to procede or Exit to cancel']; 
            warningAction = WarningWindow(windowsPrefs,messageString);
        
            if warningAction == 1    % User didn't cancel so do it! 
                % If the deleted user is the selected user, make the
                % Default User the selected user.
                if allUsersPrefs{9, userSelect} == 1
                    allUsersPrefs{9, 2} = 1;
                end

                % Remove the Users folder and all files therein
                dirToRemove = ...
                    ['UserData/' allUserNames{userSelect}];
                rmdir(dirToRemove, 's');

                % Remove the user from the drop down menu
                allUserNames(userSelect) = [];
                set(DropDownHandle, 'string', allUserNames);
                set(DropDownHandle, 'value', 1);                

                % Delete the column in the allUsersPrefs
                allUsersPrefs(:, userSelect) = [];

                % Clean up the Delete button
                set(DeletePushbuttonHandle,'string','');
                set(DeletePushbuttonHandle,'enable','inactive');

                % Save the updated variables
                save('ProgramData/PreferencesFile.mat',...
                    'allUsersPrefs', 'windowsPrefs', 'glob');
                delete(gcf)
                delete(MorseFigHandle)
                run('Morse')
            else           
                delete(gcf)
            end  
     
        case 8  % Exit
            CloseRequestCallback()
          
    end   % switch           
end  % UpdateUserCallback 

%% CloseRequestCallback -------------------------------------------
    function CloseRequestCallback(~, ~)
        CloseWindow()
    end  

end  % end UserPreferences