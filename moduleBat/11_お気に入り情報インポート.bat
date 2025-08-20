@echo off
setlocal enabledelayedexpansion

REM 一時保管ディレクトリ定義
set "BackupRoot=%CD%\data\Bookmarks"
set "ChromeBackup=%BackupRoot%\chrome"
set "EdgeBackup=%BackupRoot%\edge"

REM ブラウザの保存先パス
set "ChromeDest=%APPDATA%\Google\Chrome\Default"
set "EdgeDest=%APPDATA%\Microsoft\Edge\Default"

REM 対象ファイル定義
set FILES=Bookmarks Bookmarks.bak BookmarkMergedSurfaceOrdering

echo [INFO] ブラウザを自動終了しています...

REM 対象ブラウザを強制終了
taskkill /F /IM chrome.exe >nul 2>&1
taskkill /F /IM msedge.exe >nul 2>&1

REM Chrome お気に入り情報のインポート
if exist "%ChromeBackup%" (
    echo [INFO] Chromeのお気に入り情報を復元中...
    for %%F in (%FILES%) do (
        if exist "%ChromeBackup%\%%F" (
   	    echo [INFO] Chromeお気に入り情報をコピー: %%F
            copy /Y "%ChromeBackup%\%%F" "%ChromeDest%\%%F"
            echo [SUCS] Chromeお気に入り情報コピー完了: %%F
        ) else (
            echo [EROR] Chrome: %%F（バックアップに存在せず）
        )
    )
) else (
    echo [WARN] Chromeバックアップフォルダが見つかりません: %ChromeBackup%
)

REM Edge お気に入り情報のインポート
if exist "%EdgeBackup%" (
    echo [INFO] Edgeのお気に入り情報を復元中...
    for %%F in (%FILES%) do (
        if exist "%EdgeBackup%\%%F" (
            echo [INFO] Edgeお気に入り情報をコピー: %%F
            copy /Y "%EdgeBackup%\%%F" "%EdgeDest%\%%F"
            echo [SUCS] Edgeお気に入り情報のコピー完了: %%F
        ) else (
            echo [EROR] Edge: %%F（バックアップに存在せず）
        )
    )
) else (
    echo [WARN] Edgeバックアップフォルダが見つかりません: %EdgeBackup%
)

echo [SUCS] お気に入り情報のインポートが完了しました。
echo ※反映にはブラウザの再起動が必要です。

endlocal
