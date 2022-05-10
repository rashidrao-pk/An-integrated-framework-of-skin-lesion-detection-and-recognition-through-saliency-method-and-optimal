
function task(time)
defaultString = ['Task has been completed! and it took ' time 'time'];
%caUserInput = inputdlg(userPrompt, titleBar, 1, {defaultString});
caUserInput=defaultString;
if isempty(caUserInput)
	return;
end; % Bail out if they clicked Cancel.
caUserInput = char(caUserInput); % Convert from cell to string.
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, caUserInput);
end