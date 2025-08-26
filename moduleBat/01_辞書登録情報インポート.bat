@echo off
setlocal enabledelayedexpansion

REM �ꎞ�ۊǃf�B���N�g���̃p�X
set "BackupDir=%CD%\data\IME_Dictionary"
set "BackupFile=%BackupDir%\imjp15cu.dic"

REM �����o�^���̊i�[��p�X(�V��)
set "IME_DIC=%AppData%\Microsoft\IME\15.0\IMEJP\UserDict\imjp15cu.dic"

REM �ꎞ�t�H���_���̃t�@�C�����݊m�F
if exist "%BackupFile%" (
    echo [INFO] �ꎞ�t�H���_���玫���o�^�����C���|�[�g�J�n...
    
    REM �R�s�[����
    copy /Y "%BackupFile%" "%IME_DIC%"
    if !errorlevel! == 0 (
        echo [SUCS] �C���|�[�g����: %BackupFile% -> %IME_DIC%
    ) else (
        echo [EROR] �C���|�[�g���s: %BackupFile% -> %IME_DIC% (�G���[�R�[�h: !errorlevel!)
        goto :END
    )
) else (
    echo [EROR] �ꎞ�ۊǃt�@�C����������Ȃ�: %BackupFile%
)

echo [INFO] �����o�^���̃C���|�[�g����
echo ����: ���f�ɂ�Windows OS�̍ċN�����K�v
echo ����: OS�ċN���܂Ń��[�U�[�����c�[�����N�����Ȃ�����

endlocal
