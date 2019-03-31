function DisplayCodeTable()
% This function displays the built in Code Table
% Load the preferences file.
    load('ProgramData/PreferencesFile.mat', 'allUsersPrefs', 'windowsPrefs', 'glob');
    
% Load the codeTable file.
    load('ProgramData/CodeTableFile.mat', 'codeTable');
    
% Set some variables
    windowWidth = windowsPrefs{5,10}';    windowHeight = windowsPrefs{6,10};
    textFont = windowsPrefs{7,6}-2;       
    white = [1  1  1]; 
    
% Create the figure to display the table
    figure(...
        'Units', 'Characters',...
        'CloseRequestFcn',@CloseWindow,...
        'Position',[windowsPrefs{3,10}, windowsPrefs{4,10},...
            windowWidth, windowHeight ],...
        'NumberTitle', 'off','MenuBar', 'none','Resize', 'off',...
        'DockControls', 'off','Toolbar', 'none','Color', white,...
        'Name', 'Code Table'...
    );

%   Build the data cell array to display
    DisplayData = cell(59,5);
    for i = 1:59
        for j = 1:5
            DisplayData(i,j) = codeTable(i,j);
            if j==1
            DisplayData{i,j} = ['      ' DisplayData{i,j}];
            end
            if j==2
            DisplayData{i,j} = ['         ' DisplayData{i,j}];
            end
            if j==3
            DisplayData{i,j} = ['       ' DisplayData{i,j}];
            end
            if j==4
            DisplayData{i,j} = ['         ' DisplayData{i,j}];
            end
            if j==5
            DisplayData{i,j} = ['       ' DisplayData{i,j}];
            end
        end
    end
   
% Remove colums 2 and 3
    DisplayData(:,2) = [];
    DisplayData(:,2) = [];

% Build the table
% Note that uitable uses pixels for the columb widths
    columnNames = {'Character' 'Code Name' 'Dots and Dashes'};
    width = 1.8*windowWidth;
    share = width/2;
    columnWidths = {width-share width+share/2 width+share/2};

    uitable(...
        'Units', 'normalized',...
        'Position', [ 0 0 1 1 ],...
        'ColumnWidth', columnWidths,...
        'ColumnName', columnNames,...
        'RowName', [],...
        'Data', DisplayData,...
        'FontSize', textFont+2 ...
    );
end % end DisplayCodeTable