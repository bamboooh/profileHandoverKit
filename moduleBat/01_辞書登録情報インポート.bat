@echo off
setlocal enabledelayedexpansion

REM 一時保管ディレクトリのパス
set "BackupDir=%CD%\data\IME_Dictionary"
set "BackupFile=%BackupDir%\imjp15cu.dic"

REM 辞書登録情報の格納先パス(新環境)
set "IME_DIC=%AppData%\Microsoft\IME\15.0\IMEJP\UserDict\imjp15cu.dic"

REM 一時フォルダ内のファイル存在確認
if exist "%BackupFile%" (
    echo [INFO] 一時フォルダから辞書登録情報をインポート開始...
    
    REM コピー処理
    copy /Y "%BackupFile%" "%IME_DIC%"
    if !errorlevel! == 0 (
        echo [SUCS] インポート成功: %BackupFile% -> %IME_DIC%
    ) else (
        echo [EROR] インポート失敗: %BackupFile% -> %IME_DIC% (エラーコード: !errorlevel!)
        goto :END
    )
) else (
    echo [EROR] 一時保管ファイルが見つからない: %BackupFile%
)

echo [INFO] 辞書登録情報のインポート完了
echo 注意: 反映にはWindows OSの再起動が必要
echo 注意: OS再起動までユーザー辞書ツールを起動しないこと

endlocal
