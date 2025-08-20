@echo off
setlocal

REM ==============================================
REM 00_export.bat
REM ・このバッチのある場所に基準合わせ
REM ・yyyyMMdd_HHmmss_export.log を log 配下に作成
REM ・子バッチ出力をすべて単一ログへ集約
REM ==============================================

cd /d "%~dp0"

REM ▼ ログ準備
set "LogDir=%CD%\log"
if not exist "%LogDir%" mkdir "%LogDir%"

for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format \"yyyyMMdd_HHmmss\""') do set "LOG_TS=%%I"
set "LOG_FILE=%LogDir%\%LOG_TS%_export.log"

REM ▼ 子からも参照したければ使える環境変数（引数は不要）
set "LOG_DIR=%LogDir%"
set "LOG_FILE_PATH=%LOG_FILE%"

REM ▼ ヘッダ
echo ===== START EXPORT %DATE% %TIME% (TS=%LOG_TS%) =====> "%LOG_FILE%"

REM ▼ 辞書登録情報エクスポート
echo [STEP] ●00_辞書登録情報エクスポート 開始● >> "%LOG_FILE%"
call "moduleBat\00_辞書登録情報エクスポート.bat" >> "%LOG_FILE%" 2>&1
echo [STEP] ●00_辞書登録情報エクスポート 終了● >> "%LOG_FILE%"

REM ▼ お気に入り情報エクスポート
echo [STEP] ●10_お気に入り情報エクスポート 開始● >> "%LOG_FILE%"
call "moduleBat\10_お気に入り情報エクスポート.bat" >> "%LOG_FILE%" 2>&1
echo [STEP] ●10_お気に入り情報エクスポート 終了● >> "%LOG_FILE%"

REM ▼ フッタ
echo ===== END EXPORT %DATE% %TIME% =====>> "%LOG_FILE%"

echo ログ出力: "%LOG_FILE%"
echo "上記の場所にログを出力し、エクスポート処理は終了しました"
pause
endlocal
