@echo off
echo Starting Flutter and CocoaPods cleanup process...

REM Run flutter clean
call flutter clean
if %ERRORLEVEL% NEQ 0 (
    echo Error during flutter clean. Exiting...
    exit /b %ERRORLEVEL%
)

REM Run flutter pub get
call flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo Error during flutter pub get. Exiting...
    exit /b %ERRORLEVEL%
)

REM Change to ios directory
cd ios
if %ERRORLEVEL% NEQ 0 (
    echo Error changing to ios directory. Exiting...
    exit /b %ERRORLEVEL%
)

REM Clean CocoaPods cache
call pod cache clean --all
if %ERRORLEVEL% NEQ 0 (
    echo Error during pod cache clean. Exiting...
    exit /b %ERRORLEVEL%
)

REM Deintegrate CocoaPods
call pod deintegrate
if %ERRORLEVEL% NEQ 0 (
    echo Error during pod deintegrate. Exiting...
    exit /b %ERRORLEVEL%
)

REM Install CocoaPods dependencies
call pod install
if %ERRORLEVEL% NEQ 0 (
    echo Error during pod install. Exiting...
    exit /b %ERRORLEVEL%
)

REM Return to the project root directory
cd ..
if %ERRORLEVEL% NEQ 0 (
    echo Error returning to root directory. Exiting...
    exit /b %ERRORLEVEL%
)

REM Run the Flutter app (this will keep the terminal open)
echo Launching Flutter app...
call flutter run

echo Process completed!
pause