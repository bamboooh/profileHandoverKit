@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 932 >nul

rem =========================================================
rem profileHandoverKit を ZIP 化してアップロード先にコピー
rem 元ZIP・Downloads側ZIP・ログに同じタイムスタンプを付与
rem ログ出力でスペースを含む値も欠けないように修正
rem =========================================================

rem スクリプト/ディレクトリ情報（末尾 \ を除去して正規化）
set "KIT_DIR=%~dp0"
if "%KIT_DIR:~-1%"=="\" set "KIT_DIR=%KIT_DIR:~0,-1%"

rem フォルダ名と親ディレクトリ取得
for %%I in ("%KIT_DIR%") do set "KIT_NAME=%%~nI"
for %%I in ("%KIT_DIR%\..") do set "PARENT_DIR=%%~fI"

rem タイムスタンプ（yyyyMMdd_HHmmss）
for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "TS=%%I"

rem アップロード先（第一引数優先）
if "%~1"=="" (
  set "DEST_DIR=%USERPROFILE%\Downloads"
) else (
  set "DEST_DIR=%~1"
)
if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

rem ファイル名（すべてタイムスタンプ先頭）
set "ZIP_NAME_LOCAL=%TS%_%KIT_NAME%.zip"   rem 元ディレクトリ
set "ZIP_NAME_DEST=%TS%_%KIT_NAME%.zip"    rem Downloads
set "LOG_FILE=%DEST_DIR%\%TS%_upload.log"  rem ログ

set "ZIP_PATH_LOCAL=%PARENT_DIR%\%ZIP_NAME_LOCAL%"
set "ZIP_PATH_DEST=%DEST_DIR%\%ZIP_NAME_DEST%"

call :log "開始"
call :log "KIT_DIR=%KIT_DIR%"
call :log "KIT_NAME=%KIT_NAME%"
call :log "PARENT_DIR=%PARENT_DIR%"
call :log "ZIP_PATH_LOCAL=%ZIP_PATH_LOCAL%"
call :log "ZIP_PATH_DEST=%ZIP_PATH_DEST%"
call :log "DEST_DIR=%DEST_DIR%"

rem 既存ZIP削除
if exist "%ZIP_PATH_LOCAL%" del /f /q "%ZIP_PATH_LOCAL%" >>"%LOG_FILE%" 2>&1
if exist "%ZIP_PATH_DEST%"  del /f /q "%ZIP_PATH_DEST%"  >>"%LOG_FILE%" 2>&1

rem ===== ZIP 作成（フォルダごと含める）=====
call :log "ZIP圧縮を実行"
powershell -NoProfile -Command ^
  "$src = '%KIT_DIR%'; $dest = '%ZIP_PATH_LOCAL%';" ^
  "Set-Location (Split-Path $src -Parent);" ^
  "Compress-Archive -Path (Split-Path $src -Leaf) -DestinationPath $dest -Force" ^
  >>"%LOG_FILE%" 2>&1

if not exist "%ZIP_PATH_LOCAL%" (
  call :log "[ERROR] 元ディレクトリZIP作成に失敗"
  exit /b 1
)

rem ===== Downloads 側にコピー（同じタイムスタンプ名）=====
call :log "コピー実行 -> %ZIP_PATH_DEST%"
copy /y "%ZIP_PATH_LOCAL%" "%ZIP_PATH_DEST%" >>"%LOG_FILE%" 2>&1
if errorlevel 1 (
  call :log "[ERROR] コピー失敗"
  exit /b 1
)

call :log "成功"
call :log "アップロード先ファイル: %ZIP_PATH_DEST%"
echo 完了: "%ZIP_PATH_DEST%"
exit /b 0

:log
echo [%DATE% %TIME%] %*
>>"%LOG_FILE%" echo [%DATE% %TIME%] %*
goto :eof
