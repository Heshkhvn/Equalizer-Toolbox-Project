classdef MSE491_app < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        Panel3                     matlab.ui.container.Panel
        UIAxes_4                   matlab.ui.control.UIAxes
        UIAxes_3                   matlab.ui.control.UIAxes
        UIAxes_2                   matlab.ui.control.UIAxes
        UIAxes                     matlab.ui.control.UIAxes
        Panel2                     matlab.ui.container.Panel
        VolumeSlider               matlab.ui.control.Slider
        VolumeSliderLabel          matlab.ui.control.Label
        KHzSlider_4                matlab.ui.control.Slider
        KHzSlider_4Label           matlab.ui.control.Label
        KHzSlider_3                matlab.ui.control.Slider
        KHzSlider_3Label           matlab.ui.control.Label
        KHzSlider_2                matlab.ui.control.Slider
        KHzSlider_2Label           matlab.ui.control.Label
        KHzSlider                  matlab.ui.control.Slider
        KHzSliderLabel             matlab.ui.control.Label
        HzSlider_2                 matlab.ui.control.Slider
        HzSlider_2Label            matlab.ui.control.Label
        HzSlider                   matlab.ui.control.Slider
        HzSliderLabel              matlab.ui.control.Label
        Panel                      matlab.ui.container.Panel
        ChorusSlider               matlab.ui.control.Slider
        ChorusSliderLabel          matlab.ui.control.Label
        FrequencyShiftButton       matlab.ui.control.Button
        EchoButton                 matlab.ui.control.Button
        PlayModifiedAudioButton    matlab.ui.control.Button
        PlayOrignalAudioButton     matlab.ui.control.Button
        SaveButton                 matlab.ui.control.Button
        FileAddressEditField       matlab.ui.control.EditField
        FileAddressEditFieldLabel  matlab.ui.control.Label
        BrowseButton               matlab.ui.control.Button
    end


    properties (Access = private)
        Property % Description

        InputFileName; %File Name of Input
        FilenameEditField ;%File Name display
        Fs; %sampling frequency
        AudioD; % audio Data
        AudioPlayer; %Audio Player
        LowPB1 = [];
        LowPB2 = [];
        LowPB3 = [];
        LowPB4 = [];
        LowPB5 = [];
        HighPB = [];
        temp_signal = [];
        total_sum_of_segments = [];
        VolumeIncrease=[];

    end

    methods (Access = private)

        %%Here I start creating Filters
        function lowPass_Filter1(app, gain)


            % Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.

            % All frequency values are in Hz.
            SampFreq = app.Fs;  % Sampling Frequency

            N     = 50;  % Order
            Fpass = 80;  % Passband Frequency
            Apass = 1;   % Passband Ripple (dB)

            % Construct an FDESIGN object and call its CHEBY1 method.
            h  = fdesign.lowpass('N,Fp,Ap', N, Fpass, Apass, SampFreq);
            Hd = design(h, 'cheby1');
            % Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.
            app.temp_signal = db2mag(gain)*filter(Hd, app.AudioD);
        end

        function lowPass_Filter2(app, gain)
            % Chebyshev Type II Bandpass filter designed using FDESIGN.BANDPASS.
            if isempty(app.AudioD)
                disp('Error: app.AudioD is empty.');
                return;
            end
            % All frequency values are in Hz.
            SampFreq = app.Fs;  % Sampling Frequency

            N      = 50;   % Order
            Fstop1 = 80;   % First Stopband Frequency
            Fstop2 = 200;  % Second Stopband Frequency
            Astop  = 80;   % Stopband Attenuation (dB)

            % Construct an FDESIGN object and call its CHEBY2 method.
            h  = fdesign.bandpass('N,Fst1,Fst2,Ast', N, Fstop1, Fstop2, Astop, SampFreq);
            Hd = design(h, 'cheby2');
            % Chebyshev Type II Lowpass filter designed using FDESIGN.LOWPASS.
            app.temp_signal = db2mag(gain)*filter(Hd, app.AudioD);


        end
        function lowPass_Filter3(app, gain)
            % Chebyshev Type II Bandpass filter designed using FDESIGN.BANDPASS.

            % All frequency values are in Hz.
            SampFreq = app.Fs;  % Sampling Frequency

            N      = 50;    % Order
            Fstop1 = 200;   % First Stopband Frequency
            Fstop2 = 1000;  % Second Stopband Frequency
            Astop  = 80;    % Stopband Attenuation (dB)

            % Construct an FDESIGN object and call its CHEBY2 method.
            h  = fdesign.bandpass('N,Fst1,Fst2,Ast', N, Fstop1, Fstop2, Astop, SampFreq);
            Hd = design(h, 'cheby2');
            % Chebyshev Type II Lowpass filter designed using FDESIGN.LOWPASS.
            app.temp_signal = db2mag(gain)*filter(Hd, app.AudioD);

        end
        function lowPass_Filter4(app, gain)
            % Chebyshev Type II Bandpass filter designed using FDESIGN.BANDPASS.

            % All frequency values are in Hz.
            SampFreq = app.Fs;  % Sampling Frequency

            N      = 50;    % Order
            Fstop1 = 1000;  % First Stopband Frequency
            Fstop2 = 3000;  % Second Stopband Frequency
            Astop  = 80;    % Stopband Attenuation (dB)

            % Construct an FDESIGN object and call its CHEBY2 method.
            h  = fdesign.bandpass('N,Fst1,Fst2,Ast', N, Fstop1, Fstop2, Astop, SampFreq);
            Hd = design(h, 'cheby2');
            % Chebyshev Type II Lowpass filter designed using FDESIGN.LOWPASS.
            app.temp_signal = db2mag(gain)*filter(Hd, app.AudioD);
        end
        function lowPass_Filter5(app, gain)
            % Chebyshev Type II Bandpass filter designed using FDESIGN.BANDPASS.

            % All frequency values are in Hz.
            SampFreq = app.Fs;  % Sampling Frequency

            N      = 50;    % Order
            Fstop1 = 3000;  % First Stopband Frequency
            Fstop2 = 8000;  % Second Stopband Frequency
            Astop  = 80;    % Stopband Attenuation (dB)

            % Construct an FDESIGN object and call its CHEBY2 method.
            h  = fdesign.bandpass('N,Fst1,Fst2,Ast', N, Fstop1, Fstop2, Astop, SampFreq);
            Hd = design(h, 'cheby2');
            % Chebyshev Type II Lowpass filter designed using FDESIGN.LOWPASS.
            app.temp_signal = db2mag(gain)*filter(Hd, app.AudioD);
        end
        function HighPass_Filter(app, gain)
            % Chebyshev Type II Highpass filter designed using FDESIGN.HIGHPASS.

            % All frequency values are in Hz.
            SampFreq = app.Fs;  % Sampling Frequency

            N     = 50;    % Order
            Fstop = 8000;  % Stopband Frequency
            Astop = 80;    % Stopband Attenuation (dB)

            % Construct an FDESIGN object and call its CHEBY2 method.
            h  = fdesign.highpass('N,Fst,Ast', N, Fstop, Astop, SampFreq);
            Hd = design(h, 'cheby2');
            % Chebyshev Type II Lowpass filter designed using FDESIGN.LOWPASS.
            app.temp_signal = db2mag(gain)*filter(Hd, app.AudioD);
        end

        function updateEqualizer(app)
            disp('Sizes of arrays:');
            disp(size(app.LowPB1));
            disp(size(app.LowPB2));
            disp(size(app.LowPB3));
            disp(size(app.LowPB4));
            disp(size(app.LowPB5));
            disp(size(app.HighPB));
            app.total_sum_of_segments = app.LowPB1 + app.LowPB2 + app.LowPB3 + app.LowPB4 + app.LowPB5 + app.HighPB;
            app.VolumeIncrease=app.total_sum_of_segments;
        end


        function copyAxes(app, dest)
            % Copy the contents of the source axes to the destination subplot
            copyobj(app.Children, dest);
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: BrowseButton
        function ButtonPushed(app, event)
            % Get user to browse audio file
            [filename] = uigetfile({'.wav';'.mp3';'.m4a';'.*'});
            % Set filename  to public variable
            app.InputFileName = filename;
            % Display filename in GUI
            app.FilenameEditField.Value = filename;

            % Read the audio file
            [audioData, sampleRate] = audioread(app.InputFileName);
            app.Fs = sampleRate;
            app.AudioD = audioData;
            % Calculate time vector
            time = (0:length(audioData)-1) / sampleRate;

            % Plot the time-domain signal
            plot(app.UIAxes, time, audioData);

            FFTData = fft(audioData);
            Len = length(audioData);

            P2 = abs(FFTData/Len);

            % Take the one-sided power spectrum
            P1 = P2(1:Len/2+1);
            % Double the amplitudes of all frequencies except DC and Nyquist
            P1(2:end-1) = 2*P1(2:end-1);

            % Calculate the frequency values for the plot
            f = app.Fs*(0:(Len/2))/Len;

            % Plot the single-sided amplitude spectrum
            plot(app.UIAxes_3,f, P1)
            xlim(app.UIAxes_3,[0 12000])

            app.LowPB1 = zeros(size(app.AudioD));
            app.LowPB2 = zeros(size(app.AudioD));
            app.LowPB3 = zeros(size(app.AudioD));
            app.LowPB4 = zeros(size(app.AudioD));
            app.LowPB5 = zeros(size(app.AudioD));
            app.HighPB = zeros(size(app.AudioD));
            app.total_sum_of_segments = zeros(size(app.AudioD));


        end

        % Button pushed function: PlayOrignalAudioButton
        function PlayOrignalAudioButtonPushed(app, event)
            % Check if the audio player is already playing
            % If not playing, start the playback
            sound(app.AudioD, app.Fs);
            % end
        end

        % Value changed function: HzSlider
        function HzSliderValueChanged(app, event)
            value = app.HzSlider.Value;
            lowPass_Filter1(app, value);
            app.LowPB1 = app.temp_signal;
            disp(['Size of pb1: ' num2str(size(app.LowPB1))]);
            updateEqualizer(app);
        end

        % Value changed function: HzSlider_2
        function HzSlider_2ValueChanged(app, event)
            value = app.HzSlider_2.Value;
            lowPass_Filter2(app, value);
            app.LowPB2 = app.temp_signal;
            updateEqualizer(app);
        end

        % Value changed function: KHzSlider
        function KHzSliderValueChanged(app, event)
            value = app.KHzSlider.Value;
            lowPass_Filter3(app, value);
            app.LowPB3 = app.temp_signal;
            updateEqualizer(app);
        end

        % Value changed function: KHzSlider_2
        function KHzSlider_2ValueChanged(app, event)
            value = app.KHzSlider_2.Value;
            lowPass_Filter4(app, value);
            app.LowPB4 = app.temp_signal;
            updateEqualizer(app);
        end

        % Value changed function: KHzSlider_3
        function KHzSlider_3ValueChanged(app, event)
            value = app.KHzSlider_3.Value;
            lowPass_Filter5(app, value);
            app.LowPB5 = app.temp_signal;
            updateEqualizer(app);
        end

        % Value changed function: KHzSlider_4
        function KHzSlider_4ValueChanged(app, event)
            value = app.KHzSlider_4.Value;
            HighPass_Filter(app, value);
            app.HighPB = app.temp_signal;
            updateEqualizer(app);
        end

        % Button pushed function: PlayModifiedAudioButton
        function PlayModifiedAudioButtonPushed(app, event)
            % Get the modified audio
            sound(app.total_sum_of_segments, app.Fs);

            % Plot the time-domain signal
            time = (0:length(app.total_sum_of_segments)-1) / app.Fs;
            title(app.UIAxes_2, 'Modified Signal in Time Domain');
            plot(app.UIAxes_2, time, app.total_sum_of_segments);

            % FFT calculation
            FFTData = fft(app.total_sum_of_segments);
            Len = length(app.total_sum_of_segments);

            P2 = abs(FFTData/Len);

            % Take the one-sided power spectrum
            P1 = P2(1:Len/2+1);
            % Double the amplitudes of all frequencies except DC and Nyquist
            P1(2:end-1) = 2*P1(2:end-1);

            % Calculate the frequency values for the plot
            f = app.Fs*(0:(Len/2))/Len;

            % Plot the single-sided amplitude spectrum
            plot(app.UIAxes_4, f, P1)
            title(app.UIAxes_4, 'Modified Signal in Freq Domain');
            xlim(app.UIAxes_4, [0 12000])
        end

        % Value changed function: VolumeSlider
        function VolumeSliderValueChanged(app, event)
            value = app.VolumeSlider.Value;
            app.total_sum_of_segments=value*app.total_sum_of_segments;

        end

        % Button pushed function: EchoButton
        function EchoButtonPushed(app, event)
            % Get the modified audio with echo
            echoDelay = round(app.Fs * 0.4);
            echoGain = 0.5;

            % Create a separate variable for the echo effect
            echoSignal = zeros(size(app.total_sum_of_segments));
            echoSignal(echoDelay+1:end) = echoGain * app.total_sum_of_segments(1:end-echoDelay);

            % Combine the original signal and the echo effect
            modifiedSignal = app.total_sum_of_segments + echoSignal;
            app.total_sum_of_segments=modifiedSignal;

            % Play the modified signal
            sound(modifiedSignal, app.Fs);
            % Plot the time-domain signal
            time = (0:length(modifiedSignal)-1) / app.Fs;
            title(app.UIAxes_2, 'Echoed Signal in Time Domain');
            plot(app.UIAxes_2, time, modifiedSignal);

            % FFT calculation
            FFTData = fft(modifiedSignal);
            Len = length(modifiedSignal);

            P2 = abs(FFTData/Len);

            % Take the one-sided power spectrum
            P1 = P2(1:Len/2+1);
            % Double the amplitudes of all frequencies except DC and Nyquist
            P1(2:end-1) = 2*P1(2:end-1);

            % Calculate the frequency values for the plot
            f = app.Fs*(0:(Len/2))/Len;

            % Plot the single-sided amplitude spectrum in UIAxes_4
            plot(app.UIAxes_4, f, P1);
            xlabel(app.UIAxes_4, 'Frequency (Hz)');
            ylabel(app.UIAxes_4, 'Amplitude');
            title(app.UIAxes_4, 'Frequency Spectrum of Echoed Signal');
            xlim(app.UIAxes_4, [0 12000]);


        end

        % Button pushed function: FrequencyShiftButton
        function FrequencyShiftButtonPushed(app, event)
            % Get the modified audio with frequency shift
            shiftFrequency = 1000; % Example shift frequency in Hertz

            % Time vector
            time = (0:length(app.total_sum_of_segments)-1) / app.Fs;

            % Calculate the phase shift
            phaseShift = 2 * pi * shiftFrequency;

            % Apply frequency shift in the time domain
            modifiedSignal = app.total_sum_of_segments .* exp(1i * phaseShift * time.');
            app.total_sum_of_segments=modifiedSignal;
            % Play the modified signal
            sound(real(modifiedSignal), app.Fs);

            % Plot the time-domain signal
            time = (0:length(modifiedSignal)-1) / app.Fs;
            title(app.UIAxes_2, 'Shifted Signal in Time Domain');
            plot(app.UIAxes_2, time, modifiedSignal);

            % FFT calculation
            FFTData = fft(modifiedSignal);
            Len = length(modifiedSignal);

            P2 = abs(FFTData/Len);

            % Take the one-sided power spectrum
            P1 = P2(1:Len/2+1);
            % Double the amplitudes of all frequencies except DC and Nyquist
            P1(2:end-1) = 2*P1(2:end-1);

            % Calculate the frequency values for the plot
            f = app.Fs*(0:(Len/2))/Len;

            % Plot the single-sided amplitude spectrum in UIAxes_4
            plot(app.UIAxes_4, f, P1);
            xlabel(app.UIAxes_4, 'Frequency (Hz)');
            ylabel(app.UIAxes_4, 'Amplitude');
            title(app.UIAxes_4, 'Shifted Signal in Freq Domain');
            xlim(app.UIAxes_4, [0 12000]);

        end

        % Value changed function: ChorusSlider
        function ChorusSliderValueChanged(app, event)
            % Get the chorus depth from the slider (adjust the range as needed)
            chorusDepth = app.ChorusSlider.Value;

            % Set chorus parameters (adjust as needed)
            delayTime = 0.01;  % Delay time in seconds
            modulationDepth = chorusDepth;  % Use the slider value for modulation depth

            % Create a time vector
            time = (0:length(app.total_sum_of_segments)-1) / app.Fs;

            % Initialize the chorus signal
            chorusSignal = zeros(size(app.total_sum_of_segments));

            % Apply chorus by mixing delayed signals with modulation
            for i = 1:3  % Adjust the number of delayed signals as needed
                delayAmount = i * delayTime * sin(2 * pi * modulationDepth * time);
                % Compute the indices corresponding to the delayed signal
                indices = round((time - delayAmount) * app.Fs) + 1;
                indices(indices < 1) = 1;  % Ensure indices are valid
                indices(indices > length(app.total_sum_of_segments)) = length(app.total_sum_of_segments);

                % Add the delayed signal to the chorusSignal using indexing
                chorusSignal(1:length(indices)) = chorusSignal(1:length(indices)) + app.total_sum_of_segments(indices);
            end

            % Normalize the chorus signal to avoid clipping
            chorusSignal = chorusSignal / max(abs(chorusSignal));
            app.total_sum_of_segments=chorusSignal;
            sound(chorusSignal, app.Fs);

            % Plot the time-domain signal
            time = (0:length(chorusSignal)-1) / app.Fs;
            title(app.UIAxes_2, 'Chorus in Time Domain');
            plot(app.UIAxes_2, time, chorusSignal);

            % FFT calculation
            FFTData = fft(chorusSignal);
            Len = length(chorusSignal);

            P2 = abs(FFTData/Len);

            % Take the one-sided power spectrum
            P1 = P2(1:Len/2+1);
            % Double the amplitudes of all frequencies except DC and Nyquist
            P1(2:end-1) = 2*P1(2:end-1);

            % Calculate the frequency values for the plot
            f = app.Fs*(0:(Len/2))/Len;

            % Plot the single-sided amplitude spectrum in UIAxes_4
            plot(app.UIAxes_4, f, P1);
            xlabel(app.UIAxes_4, 'Frequency (Hz)');
            ylabel(app.UIAxes_4, 'Amplitude');
            title(app.UIAxes_4, 'Chorus in Freq Domain');
            xlim(app.UIAxes_4, [0 12000]);

        end

        % Button pushed function: SaveButton
        function SaveButtonPushed(app, event)

            % Store current titles
            title_UIAxes = app.UIAxes.Title.String;
            title_UIAxes_2 = app.UIAxes_2.Title.String;
            title_UIAxes_3 = app.UIAxes_3.Title.String;
            title_UIAxes_4 = app.UIAxes_4.Title.String;

            % Create a new figure
            fig = figure;

            % Copy UIAxes_1 to the new figure
            subplot(2, 2, 1);
            copyobj(app.UIAxes.Children, gca);
            title(title_UIAxes);
            xlabel(app.UIAxes.XLabel.String);
            ylabel(app.UIAxes.YLabel.String);

            % Copy UIAxes_2 to the new figure
            subplot(2, 2, 2);
            copyobj(app.UIAxes_2.Children, gca);
            title(title_UIAxes_2);
            xlabel(app.UIAxes_2.XLabel.String);
            ylabel(app.UIAxes_2.YLabel.String);

            % Copy UIAxes_3 to the new figure
            subplot(2, 2, 3);
            copyobj(app.UIAxes_3.Children, gca);
            title(title_UIAxes_3);
            xlabel(app.UIAxes_3.XLabel.String);
            ylabel(app.UIAxes_3.YLabel.String);

            % Copy UIAxes_4 to the new figure
            subplot(2, 2, 4);
            copyobj(app.UIAxes_4.Children, gca);
            title(title_UIAxes_4);
            xlabel(app.UIAxes_4.XLabel.String);
            ylabel(app.UIAxes_4.YLabel.String);


            % Get the file name for saving
            [saveFileName, savePath] = uiputfile({'*.wav', 'Waveform Audio File Format (*.wav)'; '*.mp3', 'MP3 Audio File (*.mp3)'}, 'Save Modified Audio As', 'modified_audio.wav');

            % Check if the user canceled the operation
            if isequal(saveFileName, 0)
                return;
            end

            % Construct the full path to save the audio file
            saveFullPath = fullfile(savePath, saveFileName);

            % Save the current modified audio
            modifiedAudio = app.total_sum_of_segments;  % Replace this with the variable storing the modified audio

            % Save the modified audio
            audiowrite(saveFullPath, real(modifiedAudio), app.Fs);

            % Display a message indicating successful save
            msgbox(['Modified audio saved successfully as: ' saveFullPath], 'Save Successful');



        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1017 1151];
            app.UIFigure.Name = 'MATLAB App';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.Title = 'Panel';
            app.Panel.Position = [23 1021 986 120];

            % Create BrowseButton
            app.BrowseButton = uibutton(app.Panel, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.BrowseButton.Position = [448 61 100 23];
            app.BrowseButton.Text = 'Browse';

            % Create FileAddressEditFieldLabel
            app.FileAddressEditFieldLabel = uilabel(app.Panel);
            app.FileAddressEditFieldLabel.HorizontalAlignment = 'right';
            app.FileAddressEditFieldLabel.FontWeight = 'bold';
            app.FileAddressEditFieldLabel.Position = [9 61 77 22];
            app.FileAddressEditFieldLabel.Text = 'File Address';

            % Create FileAddressEditField
            app.FileAddressEditField = uieditfield(app.Panel, 'text');
            app.FileAddressEditField.FontWeight = 'bold';
            app.FileAddressEditField.Position = [101 61 340 22];

            % Create SaveButton
            app.SaveButton = uibutton(app.Panel, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.Position = [558 61 100 23];
            app.SaveButton.Text = 'Save';

            % Create PlayOrignalAudioButton
            app.PlayOrignalAudioButton = uibutton(app.Panel, 'push');
            app.PlayOrignalAudioButton.ButtonPushedFcn = createCallbackFcn(app, @PlayOrignalAudioButtonPushed, true);
            app.PlayOrignalAudioButton.Position = [665 60 114 23];
            app.PlayOrignalAudioButton.Text = 'Play Orignal Audio';

            % Create PlayModifiedAudioButton
            app.PlayModifiedAudioButton = uibutton(app.Panel, 'push');
            app.PlayModifiedAudioButton.ButtonPushedFcn = createCallbackFcn(app, @PlayModifiedAudioButtonPushed, true);
            app.PlayModifiedAudioButton.Position = [438 26 121 22];
            app.PlayModifiedAudioButton.Text = 'Play Modified Audio';

            % Create EchoButton
            app.EchoButton = uibutton(app.Panel, 'push');
            app.EchoButton.ButtonPushedFcn = createCallbackFcn(app, @EchoButtonPushed, true);
            app.EchoButton.Position = [291 25 100 23];
            app.EchoButton.Text = 'Echo';

            % Create FrequencyShiftButton
            app.FrequencyShiftButton = uibutton(app.Panel, 'push');
            app.FrequencyShiftButton.ButtonPushedFcn = createCallbackFcn(app, @FrequencyShiftButtonPushed, true);
            app.FrequencyShiftButton.Position = [153 25 100 23];
            app.FrequencyShiftButton.Text = 'Frequency Shift';

            % Create ChorusSliderLabel
            app.ChorusSliderLabel = uilabel(app.Panel);
            app.ChorusSliderLabel.HorizontalAlignment = 'right';
            app.ChorusSliderLabel.Position = [605 26 46 22];
            app.ChorusSliderLabel.Text = 'Chorus';

            % Create ChorusSlider
            app.ChorusSlider = uislider(app.Panel);
            app.ChorusSlider.Limits = [0 0.5];
            app.ChorusSlider.ValueChangedFcn = createCallbackFcn(app, @ChorusSliderValueChanged, true);
            app.ChorusSlider.Position = [672 35 150 3];

            % Create Panel2
            app.Panel2 = uipanel(app.UIFigure);
            app.Panel2.Title = 'Panel2';
            app.Panel2.Position = [22 746 987 276];

            % Create HzSliderLabel
            app.HzSliderLabel = uilabel(app.Panel2);
            app.HzSliderLabel.HorizontalAlignment = 'right';
            app.HzSliderLabel.Position = [74 219 44 22];
            app.HzSliderLabel.Text = '0-80Hz';

            % Create HzSlider
            app.HzSlider = uislider(app.Panel2);
            app.HzSlider.Limits = [-20 20];
            app.HzSlider.Orientation = 'vertical';
            app.HzSlider.ValueChangedFcn = createCallbackFcn(app, @HzSliderValueChanged, true);
            app.HzSlider.Position = [78 12 3 203];

            % Create HzSlider_2Label
            app.HzSlider_2Label = uilabel(app.Panel2);
            app.HzSlider_2Label.HorizontalAlignment = 'right';
            app.HzSlider_2Label.Position = [170 223 57 22];
            app.HzSlider_2Label.Text = '80-200Hz';

            % Create HzSlider_2
            app.HzSlider_2 = uislider(app.Panel2);
            app.HzSlider_2.Limits = [-20 20];
            app.HzSlider_2.Orientation = 'vertical';
            app.HzSlider_2.ValueChangedFcn = createCallbackFcn(app, @HzSlider_2ValueChanged, true);
            app.HzSlider_2.Position = [197 14 3 203];

            % Create KHzSliderLabel
            app.KHzSliderLabel = uilabel(app.Panel2);
            app.KHzSliderLabel.HorizontalAlignment = 'right';
            app.KHzSliderLabel.Position = [281 223 58 22];
            app.KHzSliderLabel.Text = '200-1KHz';

            % Create KHzSlider
            app.KHzSlider = uislider(app.Panel2);
            app.KHzSlider.Limits = [-20 20];
            app.KHzSlider.Orientation = 'vertical';
            app.KHzSlider.ValueChangedFcn = createCallbackFcn(app, @KHzSliderValueChanged, true);
            app.KHzSlider.Position = [295 14 3 203];

            % Create KHzSlider_2Label
            app.KHzSlider_2Label = uilabel(app.Panel2);
            app.KHzSlider_2Label.HorizontalAlignment = 'right';
            app.KHzSlider_2Label.Position = [391 223 45 22];
            app.KHzSlider_2Label.Text = '1-3KHz';

            % Create KHzSlider_2
            app.KHzSlider_2 = uislider(app.Panel2);
            app.KHzSlider_2.Limits = [-20 20];
            app.KHzSlider_2.Orientation = 'vertical';
            app.KHzSlider_2.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_2ValueChanged, true);
            app.KHzSlider_2.Position = [397 14 3 203];

            % Create KHzSlider_3Label
            app.KHzSlider_3Label = uilabel(app.Panel2);
            app.KHzSlider_3Label.HorizontalAlignment = 'right';
            app.KHzSlider_3Label.Position = [513 223 45 22];
            app.KHzSlider_3Label.Text = '3-8KHz';

            % Create KHzSlider_3
            app.KHzSlider_3 = uislider(app.Panel2);
            app.KHzSlider_3.Limits = [-20 20];
            app.KHzSlider_3.Orientation = 'vertical';
            app.KHzSlider_3.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_3ValueChanged, true);
            app.KHzSlider_3.Position = [513 16 3 203];

            % Create KHzSlider_4Label
            app.KHzSlider_4Label = uilabel(app.Panel2);
            app.KHzSlider_4Label.HorizontalAlignment = 'right';
            app.KHzSlider_4Label.Position = [618 223 52 22];
            app.KHzSlider_4Label.Text = '8-12KHz';

            % Create KHzSlider_4
            app.KHzSlider_4 = uislider(app.Panel2);
            app.KHzSlider_4.Limits = [-20 20];
            app.KHzSlider_4.Orientation = 'vertical';
            app.KHzSlider_4.ValueChangedFcn = createCallbackFcn(app, @KHzSlider_4ValueChanged, true);
            app.KHzSlider_4.Position = [631 14 3 203];

            % Create VolumeSliderLabel
            app.VolumeSliderLabel = uilabel(app.Panel2);
            app.VolumeSliderLabel.HorizontalAlignment = 'right';
            app.VolumeSliderLabel.Position = [753 219 45 22];
            app.VolumeSliderLabel.Text = 'Volume';

            % Create VolumeSlider
            app.VolumeSlider = uislider(app.Panel2);
            app.VolumeSlider.Limits = [-20 20];
            app.VolumeSlider.Orientation = 'vertical';
            app.VolumeSlider.ValueChangedFcn = createCallbackFcn(app, @VolumeSliderValueChanged, true);
            app.VolumeSlider.Position = [757 10 3 203];
            app.VolumeSlider.Value = 1;

            % Create Panel3
            app.Panel3 = uipanel(app.UIFigure);
            app.Panel3.Title = 'Panel3';
            app.Panel3.Position = [22 63 987 669];

            % Create UIAxes
            app.UIAxes = uiaxes(app.Panel3);
            title(app.UIAxes, 'Original Time Plot')
            xlabel(app.UIAxes, 'Time')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [23 318 406 289];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.Panel3);
            title(app.UIAxes_2, 'Modified Time Plot')
            xlabel(app.UIAxes_2, 'Time')
            ylabel(app.UIAxes_2, 'Y')
            zlabel(app.UIAxes_2, 'Z')
            app.UIAxes_2.Position = [440 318 378 289];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.Panel3);
            title(app.UIAxes_3, 'Original Frequency Plot')
            xlabel(app.UIAxes_3, 'Frequency')
            ylabel(app.UIAxes_3, 'Y')
            zlabel(app.UIAxes_3, 'Z')
            app.UIAxes_3.Position = [23 13 405 289];

            % Create UIAxes_4
            app.UIAxes_4 = uiaxes(app.Panel3);
            title(app.UIAxes_4, 'Modified Time Plot')
            xlabel(app.UIAxes_4, 'Frequency')
            ylabel(app.UIAxes_4, 'Y')
            zlabel(app.UIAxes_4, 'Z')
            app.UIAxes_4.Position = [440 13 378 289];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = MSE491_app

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
