% Create a figure for the GUI
fig = uifigure('Position', [100, 100, 600, 800], 'Name', 'Accident-Free Days Counter');

% Title label
uilabel(fig, 'Text', 'Automated Accident-Free Days Counter System', ...
    'Position', [50, 750, 500, 40], 'FontSize', 16, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% Section label for Plant
uilabel(fig, 'Text', 'Plant', 'Position', [50, 700, 200, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

% Display for Accident-Free Days in Plant
uilabel(fig, 'Text', 'Accident-Free Days:', 'Position', [50, 650, 150, 30], 'FontSize', 12, 'HorizontalAlignment', 'left');
plantDaysDisplay = uilabel(fig, 'Text', '0', 'Position', [200, 650, 100, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', 'white');

% Buttons for Plant
uibutton(fig, 'Text', 'UP', 'Position', [310, 650, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(plantDaysDisplay, 1));
uibutton(fig, 'Text', 'DOWN', 'Position', [370, 650, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(plantDaysDisplay, -1));
uibutton(fig, 'Text', 'RESET', 'Position', [430, 650, 50, 30], 'ButtonPushedFcn', @(btn,event) resetDisplay(plantDaysDisplay));

% Display for Last Accident Day in Plant
uilabel(fig, 'Text', 'Last Accident Day:', 'Position', [50, 600, 150, 30], 'FontSize', 12, 'HorizontalAlignment', 'left');
plantLastAccidentDisplay = uilabel(fig, 'Text', 'N/A', 'Position', [200, 600, 100, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', 'white');

% Section label for Workshop
uilabel(fig, 'Text', 'Workshop', 'Position', [50, 550, 200, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

% Display for Accident-Free Days in Workshop
uilabel(fig, 'Text', 'Accident-Free Days:', 'Position', [50, 500, 150, 30], 'FontSize', 12, 'HorizontalAlignment', 'left');
workshopDaysDisplay = uilabel(fig, 'Text', '0', 'Position', [200, 500, 100, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', 'white');

% Buttons for Workshop
uibutton(fig, 'Text', 'UP', 'Position', [310, 500, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(workshopDaysDisplay, 1));
uibutton(fig, 'Text', 'DOWN', 'Position', [370, 500, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(workshopDaysDisplay, -1));
uibutton(fig, 'Text', 'RESET', 'Position', [430, 500, 50, 30], 'ButtonPushedFcn', @(btn,event) resetDisplay(workshopDaysDisplay));

% Display for Last Accident Day in Workshop
uilabel(fig, 'Text', 'Last Accident Day:', 'Position', [50, 450, 150, 30], 'FontSize', 12, 'HorizontalAlignment', 'left');
workshopLastAccidentDisplay = uilabel(fig, 'Text', 'N/A', 'Position', [200, 450, 100, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', 'white');

% Section label for Employee Data
uilabel(fig, 'Text', 'Employee Data', 'Position', [50, 400, 200, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

% Display for Daily Head Count
uilabel(fig, 'Text', 'Daily Head Count:', 'Position', [50, 350, 150, 30], 'FontSize', 12, 'HorizontalAlignment', 'left');
dailyHeadCountDisplay = uilabel(fig, 'Text', '0', 'Position', [200, 350, 100, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', 'white');

% Buttons for Daily Head Count
uibutton(fig, 'Text', 'UP', 'Position', [310, 350, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(dailyHeadCountDisplay, 1));
uibutton(fig, 'Text', 'DOWN', 'Position', [370, 350, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(dailyHeadCountDisplay, -1));
uibutton(fig, 'Text', 'RESET', 'Position', [430, 350, 50, 30], 'ButtonPushedFcn', @(btn,event) resetDisplay(dailyHeadCountDisplay));

% Display for Total Employees
uilabel(fig, 'Text', 'Total Employees:', 'Position', [50, 300, 150, 30], 'FontSize', 12, 'HorizontalAlignment', 'left');
totalEmployeesDisplay = uilabel(fig, 'Text', '0', 'Position', [200, 300, 100, 30], 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', 'white');

% Buttons for Total Employees
uibutton(fig, 'Text', 'UP', 'Position', [310, 300, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(totalEmployeesDisplay, 1));
uibutton(fig, 'Text', 'DOWN', 'Position', [370, 300, 50, 30], 'ButtonPushedFcn', @(btn,event) updateDisplay(totalEmployeesDisplay, -1));
uibutton(fig, 'Text', 'RESET', 'Position', [430, 300, 50, 30], 'ButtonPushedFcn', @(btn,event) resetDisplay(totalEmployeesDisplay));

% Callback functions
function updateDisplay(display, value)
    currentValue = str2double(display.Text);
    newValue = currentValue + value;
    if newValue < 0
        newValue = 0;
    end
    display.Text = num2str(newValue);
end

function resetDisplay(display)
    display.Text = '0';
end
