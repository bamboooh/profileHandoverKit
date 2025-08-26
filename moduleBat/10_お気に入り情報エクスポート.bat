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
        if !errorlevel! == 0 (
            echo [CREATE] %%~D
        ) else (
            echo [EROR] フォルダ作成失敗: %%~D エラーコード: !errorlevel!
        )
    ) else (
        echo [INFO] 既存フォルダ検出: %%~D
    )
)

REM Chromeお気に入り情報のバックアップ
echo [INFO] Chromeのお気に入り情報をバックアップ中...
for %%F in (%FILES%) do (
    if exist "%ChromeSrc%\%%F" (
        echo [INFO] Chromeお気に入り情報をコピー: %%F
        copy /Y "%ChromeSrc%\%%F" "%ChromeBackup%\%%F"
        if !errorlevel! == 0 (
            echo [SUCS] Chromeコピー成功: %%F
        ) else (
            echo [EROR] Chromeコピー失敗: %%F エラーコード: !errorlevel!
        )
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
        if !errorlevel! == 0 (
            echo [SUCS] Edgeコピー成功: %%F
        ) else (
            echo [EROR] Edgeコピー失敗: %%F エラーコード: !errorlevel!
        )
    ) else (
        echo [EROR] Edge: %%F（存在せず）
    )
)

echo [INFO] 保存先: %BackupRoot%
echo [INFO] お気に入り情報のエクスポートが完了しました。

endlocal
