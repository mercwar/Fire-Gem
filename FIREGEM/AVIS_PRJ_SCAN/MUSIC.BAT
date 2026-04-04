:: SET MIDI PATH FIRST
set "MIDI_FILE=%~dp0midi\JP-YGATC.mid"

:: IF MIDI DOES NOT EXIST → SKIP BLOCK
if not exist "%MIDI_FILE%" goto NO_MIDI

:: KILL ANY PREVIOUS AUDIO INSTANCE
taskkill /im wscript.exe /f >nul 2>&1

:: IF MIDI EXISTS → RUN THIS BLOCK
> "%temp%\avis_snd.vbs" echo Set o = CreateObject("WMPlayer.OCX")
>>"%temp%\avis_snd.vbs" echo o.URL = "%MIDI_FILE%"
>>"%temp%\avis_snd.vbs" echo o.controls.play
>>"%temp%\avis_snd.vbs" echo WScript.Sleep 500
>>"%temp%\avis_snd.vbs" echo Do While o.playState = 3
>>"%temp%\avis_snd.vbs" echo     WScript.Sleep 200
>>"%temp%\avis_snd.vbs" echo Loop
>>"%temp%\avis_snd.vbs" echo o.close

start "" /b wscript.exe "%temp%\avis_snd.vbs"
goto END_AUDIO

:NO_MIDI
rem MIDI file missing — skip audio

:END_AUDIO