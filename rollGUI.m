function RollMotionGUI()
    % Create the figure window
    fig = figure('Name', 'Roll Motion Analysis', 'Position', [500, 300, 400, 300]);

    % File Selection Button
    uicontrol('Style', 'pushbutton', 'String', 'Upload Time Series', ...
              'Position', [50, 250, 300, 30], ...
              'Callback', @uploadFile);

    % Sampling Frequency Input
    uicontrol('Style', 'text', 'String', 'Sampling Frequency (Hz):', ...
              'Position', [50, 210, 200, 20]);
    fsInput = uicontrol('Style', 'edit', 'Position', [250, 210, 100, 25]);

    % Checkboxes for exercises
    check(1) = uicontrol('Style', 'checkbox', 'String', 'Amplitude & Phase Spectrum', ...
                         'Position', [50, 180, 300, 20]);
    check(2) = uicontrol('Style', 'checkbox', 'String', 'Blackman Window PSD', ...
                         'Position', [50, 160, 300, 20]);
    check(3) = uicontrol('Style', 'checkbox', 'String', 'Chebyshev Lowpass Filter', ...
                         'Position', [50, 140, 300, 20]);
    check(4) = uicontrol('Style', 'checkbox', 'String', 'Hilbert-Huang Transform', ...
                         'Position', [50, 120, 300, 20]);

    % Run Button
    uicontrol('Style', 'pushbutton', 'String', 'Run Analysis', ...
              'Position', [50, 70, 300, 40], ...
              'Callback', @runAnalysis);

    % Variables for storing data
    fileName = '';
    
    % Callback for file upload
    function uploadFile(~, ~)
        [file, path] = uigetfile('*.mat', 'Select the time series file');
        if file ~= 0
            fileName = fullfile(path, file);
            disp(['File Selected: ', fileName]);
        end
    end

    % Callback for running analysis
    function runAnalysis(~, ~)
        if isempty(fileName)
            errordlg('Please upload a time series file.', 'Error');
            return;
        end
        fs = str2double(get(fsInput, 'String'));
        if isnan(fs) || fs <= 0
            errordlg('Please enter a valid sampling frequency.', 'Error');
            return;
        end

        % Create the RollMotionAnalyzer object
        analyzer = RollMotionAnalyzer(fileName, fs);

        % Run selected analyses
        if get(check(1), 'Value'), analyzer.computeAmplitudePhase(); end
        if get(check(2), 'Value'), analyzer.computeBlackmanPSD(); end
        if get(check(3), 'Value'), analyzer.computeChebyshevFilter(); end
        if get(check(4), 'Value'), analyzer.computeHHT(); end
    end
end
