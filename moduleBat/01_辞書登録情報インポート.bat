@echo off
setlocal

REM 一時保管ディレクトリのパス
set "BackupDir=%CD%\data\IME_Dictionary"
set "BackupFile=%BackupDir%\imjp15cu.dic"

REM 辞書登録情報の格納先パス（新環境）
set "IME_DIC=%AppData%\Microsoft\IME\15.0\IMEJP\UserDict\imjp15cu.dic"

REM 一時フォルダ内のファイル存在確認
if exist "%BackupFile%" (
    echo [INFO] 一時フォルダから辞書登録情報をインポート中...
    
    REM 既存ファイルを削除（必要に応じて）
    if exist "%IME_DIC%" (
        echo [INFO] 既存ファイルを削除中...
        del /f "%IME_DIC%"
    )

    REM コピー処理
    copy /Y "%BackupFile%" "%IME_DIC%"
    echo [SUCS] インポート完了: %IME_DIC%
) else (
    echo [EROR] 一時保管ファイルが見つかりません: %BackupFile%
)

echo [SUCS] 辞書登録情報のインポートが完了しました。
echo ※反映にはWindowsOSの再起動が必要です。
echo ※ユーザー辞書ツール(アプリ)はOS再起動するまで絶対に開かないでください。

endlocal
