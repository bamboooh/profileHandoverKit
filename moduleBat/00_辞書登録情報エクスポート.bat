@echo off
setlocal enabledelayedexpansion

REM �f�B���N�g����`
set "BackupDir=%CD%\data\IME_Dictionary"

REM �G�N�X�|�[�g�f�B���N�g���쐬
if not exist "%BackupDir%" (
    echo [INFO] �ꎞ�ۊǃt�H���_���쐬��: %BackupDir%
    mkdir "%BackupDir%"
    if !errorlevel! == 0 (
        echo [SUCS] �t�H���_�쐬����: %BackupDir%
    ) else (
        echo [EROR] �t�H���_�쐬���s: %BackupDir% �G���[�R�[�h: !errorlevel!
    )
) else (
    echo [INFO] �ꎞ�ۊǃt�H���_�͊��ɑ���: %BackupDir%
)

REM �����o�^���t�@�C���̃p�X�i�����j
set "IME_DIC=%AppData%\Microsoft\IME\15.0\IMEJP\UserDict\imjp15cu.dic"

REM �R�s�[��
set "BackupFile=%BackupDir%\imjp15cu.dic"

REM �����o�^���t�@�C���̑��݊m�F�ƃR�s�[
if exist "%IME_DIC%" (
    echo [INFO] �����o�^���t�@�C�����R�s�[
    copy /Y "%IME_DIC%" "%BackupFile%"
    if %errorlevel%==0 (
        echo [SUCS] �R�s�[����: %IME_DIC% �� %BackupFile%
    ) else (
        echo [EROR] �R�s�[���s �G���[�R�[�h: %errorlevel%
    )
) else (
    echo [EROR] �����o�^���t�@�C����������܂���: %IME_DIC%
)

echo [INFO] �ۑ���: %BackupFile%
echo [INFO] �����o�^���t�@�C���̃G�N�X�|�[�g���������܂����B

endlocal
