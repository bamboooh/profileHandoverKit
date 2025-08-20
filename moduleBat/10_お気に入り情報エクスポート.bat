@echo off
setlocal enabledelayedexpansion

REM ディレクトリ定義
set "BackupRoot=%CD%\data\Bookmarks"
set "ChromeBackup=%BackupRoot%\chrome"
set "EdgeBackup=%BackupRoot%\edge"

set "ChromeSrc=%APPDATA%\Google\Chrome\Default"
set "EdgeSrc=%APPDATA%\Microsoft\Edge\Default"

REM 対象ファイル定義
set FILES=Bookmarks Bookmarks.bak BookmarkMergedSurfaceOrdering

echo [INFO] ブラウザを自動終了しています...

REM ブラウザプロセスを強制終了
taskkill /F /IM chrome.exe >nul 2>&1
taskkill /F /IM msedge.exe >nul 2>&1

echo [INFO] エクスポート先フォルダを作成しています...

REM エクスポートディレクトリを作成
for %%D in ("%ChromeBackup%" "%EdgeBackup%") do (
    if not exist "%%~D" (
        mkdir "%%~D"
        echo [CREATE] %%~D
    )
)

REM Chromeお気に入り情報のバックアップ
echo [INFO] Chromeのお気に入り情報をバックアップ中...
for %%F in (%FILES%) do (
    if exist "%ChromeSrc%\%%F" (
        echo [INFO] Chromeお気に入り情報をコピー: %%F
        copy /Y "%ChromeSrc%\%%F" "%ChromeBackup%\%%F"
        echo [SUCS] Chromeお気に入り情報コピー完了: %%F
    ) else (
        echo [EROR] Chrome: %%F（存在せず）
    )
)

REM Edgeお気に入り情報のバックアップ
echo [INFO] Edgeのお気に入り情報をバックアップ中...
for %%F in (%FILES%) do (
    if exist "%EdgeSrc%\%%F" (
        echo [INFO] Edgeお気に入り情報をコピー: %%F
        copy /Y "%EdgeSrc%\%%F" "%EdgeBackup%\%%F"
        echo [SUCS] Edgeお気に入り情報のコピー完了: %%F
    ) else (
        echo [EROR] Edge: %%F（存在せず）
    )
)

echo [INFO] 保存先: %BackupRoot%
echo [SUCS] お気に入り情報のエクスポートが完了しました。

endlocal
