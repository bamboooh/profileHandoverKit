@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 932 >nul

rem =========================================================
rem profileHandoverKit �� ZIP �����ăA�b�v���[�h��ɃR�s�[
rem ��ZIP�EDownloads��ZIP�E���O�ɓ����^�C���X�^���v��t�^
rem ���O�o�͂ŃX�y�[�X���܂ޒl�������Ȃ��悤�ɏC��
rem =========================================================

rem �X�N���v�g/�f�B���N�g�����i���� \ ���������Đ��K���j
set "KIT_DIR=%~dp0"
if "%KIT_DIR:~-1%"=="\" set "KIT_DIR=%KIT_DIR:~0,-1%"

rem �t�H���_���Ɛe�f�B���N�g���擾
for %%I in ("%KIT_DIR%") do set "KIT_NAME=%%~nI"
for %%I in ("%KIT_DIR%\..") do set "PARENT_DIR=%%~fI"

rem �^�C���X�^���v�iyyyyMMdd_HHmmss�j
for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "TS=%%I"

rem �A�b�v���[�h��i�������D��j
if "%~1"=="" (
  set "DEST_DIR=%USERPROFILE%\Downloads"
) else (
  set "DEST_DIR=%~1"
)
if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

rem �t�@�C�����i���ׂă^�C���X�^���v�擪�j
set "ZIP_NAME_LOCAL=%TS%_%KIT_NAME%.zip"   rem ���f�B���N�g��
set "ZIP_NAME_DEST=%TS%_%KIT_NAME%.zip"    rem Downloads
set "LOG_FILE=%DEST_DIR%\%TS%_upload.log"  rem ���O

set "ZIP_PATH_LOCAL=%PARENT_DIR%\%ZIP_NAME_LOCAL%"
set "ZIP_PATH_DEST=%DEST_DIR%\%ZIP_NAME_DEST%"

call :log "�J�n"
call :log "KIT_DIR=%KIT_DIR%"
call :log "KIT_NAME=%KIT_NAME%"
call :log "PARENT_DIR=%PARENT_DIR%"
call :log "ZIP_PATH_LOCAL=%ZIP_PATH_LOCAL%"
call :log "ZIP_PATH_DEST=%ZIP_PATH_DEST%"
call :log "DEST_DIR=%DEST_DIR%"

rem ����ZIP�폜
if exist "%ZIP_PATH_LOCAL%" del /f /q "%ZIP_PATH_LOCAL%" >>"%LOG_FILE%" 2>&1
if exist "%ZIP_PATH_DEST%"  del /f /q "%ZIP_PATH_DEST%"  >>"%LOG_FILE%" 2>&1

rem ===== ZIP �쐬�i�t�H���_���Ɗ܂߂�j=====
call :log "ZIP���k�����s"
powershell -NoProfile -Command ^
  "$src = '%KIT_DIR%'; $dest = '%ZIP_PATH_LOCAL%';" ^
  "Set-Location (Split-Path $src -Parent);" ^
  "Compress-Archive -Path (Split-Path $src -Leaf) -DestinationPath $dest -Force" ^
  >>"%LOG_FILE%" 2>&1

if not exist "%ZIP_PATH_LOCAL%" (
  call :log "[ERROR] ���f�B���N�g��ZIP�쐬�Ɏ��s"
  exit /b 1
)

rem ===== Downloads ���ɃR�s�[�i�����^�C���X�^���v���j=====
call :log "�R�s�[���s -> %ZIP_PATH_DEST%"
copy /y "%ZIP_PATH_LOCAL%" "%ZIP_PATH_DEST%" >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
  call :log "[ERROR] �R�s�[���s"
  exit /b 1
)

call :log "����"
call :log "�A�b�v���[�h��t�@�C��: %ZIP_PATH_DEST%"
echo ����: "%ZIP_PATH_DEST%"
exit /b 0

:log
echo [%DATE% %TIME%] %*
>>"%LOG_FILE%" echo [%DATE% %TIME%] %*
goto :eof
