@echo off
setlocal

REM 一時保管ディレクトリ作成
set "BackupDir=%CD%\data\IME_Dictionary"
if not exist "%BackupDir%" (
    echo [INFO] 一時保管フォルダを作成中: %BackupDir%
    mkdir "%BackupDir%"
) else (
    echo [INFO] 一時保管フォルダは既に存在: %BackupDir%
)

REM 辞書登録情報ファイルのパス（旧環境）
set "IME_DIC=%AppData%\Microsoft\IME\15.0\IMEJP\UserDict\imjp15cu.dic"

REM コピー先
set "BackupFile=%BackupDir%\imjp15cu.dic"

REM 辞書登録情報ファイルの存在確認とコピー
if exist "%IME_DIC%" (
    echo [INFO] 辞書登録情報ファイルをコピー
    copy /Y "%IME_DIC%" "%BackupFile%"
    echo [SUCS] 辞書登録情報ファイルのコピー完了
) else (
    echo [EROR] 辞書登録情報ファイルが見つかりません: %IME_DIC%
)

echo [INFO] 保存先: %BackupFile%
echo [SUCS] 辞書登録情報ファイルのエクスポートが完了しました。

endlocal
