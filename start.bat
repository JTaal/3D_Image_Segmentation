@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM Ask user if they want to download the file
echo Do you want to download the .tif training files? [Y/N] 
choice /C YN /M "Press Y for Yes or N for No: "
if %ERRORLEVEL% equ 2 goto skipDownload

REM Download and unzip files
echo Downloading and extracting files...

REM URL of the file to download
set "url=https://filesender.surf.nl/download.php?token=2cfcce3a-7c7d-43ac-824f-b232c409d61d&files_ids=20213963,20213965,20213967,20213969,20213971,20213973,20213975,20213977,20213979,20213981"

REM Destination file path
set zipfile=downloaded.zip

REM Download the file
curl -L "%url%" -o "%zipfile%"

REM Verify download
echo Verifying download...
find "PK" "%zipfile%" >nul
if %errorlevel% neq 0 (
    echo Failed to download ZIP file. Please check the URL or your network connection.
    exit /b
)

REM Unzip the file
echo Extracting files...
unzip "%zipfile%"

REM Optional: remove the ZIP file after extraction
@REM del "%zipfile%"

echo File download and extraction complete.

:skipDownload

REM Get the name of the parent directory
FOR %%i IN ("%cd%") DO SET PARENT_FOLDER_NAME=%%~nxi

REM Install virtual environments
pip install virtualenv

REM Create the virtual environment with the parent folder's name
python -m venv !PARENT_FOLDER_NAME!

REM Activate the virtual environment
CALL !PARENT_FOLDER_NAME!\Scripts\activate

REM Install dependencies from requirements.txt
pip install -r requirements.txt

echo Environment setup complete.

REM Start Jupyter Notebook server
echo Starting Jupyter Notebook...
jupyter notebook

pause
ENDLOCAL
