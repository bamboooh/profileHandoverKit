@echo off
setlocal

REM �ꎞ�ۊǃf�B���N�g���̃p�X
set "BackupDir=%CD%\data\IME_Dictionary"
set "BackupFile=%BackupDir%\imjp15cu.dic"

REM �����o�^���̊i�[��p�X�i�V���j
set "IME_DIC=%AppData%\Microsoft\IME\15.0\IMEJP\UserDict\imjp15cu.dic"

REM �ꎞ�t�H���_���̃t�@�C�����݊m�F
if exist "%BackupFile%" (
    echo [INFO] �ꎞ�t�H���_���玫���o�^�����C���|�[�g��...
    
    REM �����t�@�C�����폜�i�K�v�ɉ����āj
    if exist "%IME_DIC%" (
        echo [INFO] �����t�@�C�����폜��...
        del /f "%IME_DIC%"
    )

    REM �R�s�[����
    copy /Y "%BackupFile%" "%IME_DIC%"
    echo [SUCS] �C���|�[�g����: %IME_DIC%
) else (
    echo [EROR] �ꎞ�ۊǃt�@�C����������܂���: %BackupFile%
)

echo [SUCS] �����o�^���̃C���|�[�g���������܂����B
echo �����f�ɂ�WindowsOS�̍ċN�����K�v�ł��B
echo �����[�U�[�����c�[��(�A�v��)��OS�ċN������܂Ő�΂ɊJ���Ȃ��ł��������B

endlocal
