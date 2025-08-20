@echo off
setlocal enabledelayedexpansion

REM �f�B���N�g����`
set "BackupRoot=%CD%\data\Bookmarks"
set "ChromeBackup=%BackupRoot%\chrome"
set "EdgeBackup=%BackupRoot%\edge"

set "ChromeSrc=%APPDATA%\Google\Chrome\Default"
set "EdgeSrc=%APPDATA%\Microsoft\Edge\Default"

REM �Ώۃt�@�C����`
set FILES=Bookmarks Bookmarks.bak BookmarkMergedSurfaceOrdering

echo [INFO] �u���E�U�������I�����Ă��܂�...

REM �u���E�U�v���Z�X�������I��
taskkill /F /IM chrome.exe >nul 2>&1
taskkill /F /IM msedge.exe >nul 2>&1

echo [INFO] �G�N�X�|�[�g��t�H���_���쐬���Ă��܂�...

REM �G�N�X�|�[�g�f�B���N�g�����쐬
for %%D in ("%ChromeBackup%" "%EdgeBackup%") do (
    if not exist "%%~D" (
        mkdir "%%~D"
        echo [CREATE] %%~D
    )
)

REM Chrome���C�ɓ�����̃o�b�N�A�b�v
echo [INFO] Chrome�̂��C�ɓ�������o�b�N�A�b�v��...
for %%F in (%FILES%) do (
    if exist "%ChromeSrc%\%%F" (
        echo [INFO] Chrome���C�ɓ�������R�s�[: %%F
        copy /Y "%ChromeSrc%\%%F" "%ChromeBackup%\%%F"
        echo [SUCS] Chrome���C�ɓ�����R�s�[����: %%F
    ) else (
        echo [EROR] Chrome: %%F�i���݂����j
    )
)

REM Edge���C�ɓ�����̃o�b�N�A�b�v
echo [INFO] Edge�̂��C�ɓ�������o�b�N�A�b�v��...
for %%F in (%FILES%) do (
    if exist "%EdgeSrc%\%%F" (
        echo [INFO] Edge���C�ɓ�������R�s�[: %%F
        copy /Y "%EdgeSrc%\%%F" "%EdgeBackup%\%%F"
        echo [SUCS] Edge���C�ɓ�����̃R�s�[����: %%F
    ) else (
        echo [EROR] Edge: %%F�i���݂����j
    )
)

echo [INFO] �ۑ���: %BackupRoot%
echo [SUCS] ���C�ɓ�����̃G�N�X�|�[�g���������܂����B

endlocal
