@echo off
setlocal

REM �ꎞ�ۊǃf�B���N�g���쐬
set "BackupDir=%CD%\data\IME_Dictionary"
if not exist "%BackupDir%" (
    echo [INFO] �ꎞ�ۊǃt�H���_���쐬��: %BackupDir%
    mkdir "%BackupDir%"
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
    echo [SUCS] �����o�^���t�@�C���̃R�s�[����
) else (
    echo [EROR] �����o�^���t�@�C����������܂���: %IME_DIC%
)

echo [INFO] �ۑ���: %BackupFile%
echo [SUCS] �����o�^���t�@�C���̃G�N�X�|�[�g���������܂����B

endlocal
