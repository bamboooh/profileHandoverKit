@echo off
setlocal enabledelayedexpansion

REM �ꎞ�ۊǃf�B���N�g����`
set "BackupRoot=%CD%\data\Bookmarks"
set "ChromeBackup=%BackupRoot%\chrome"
set "EdgeBackup=%BackupRoot%\edge"

REM �u���E�U�̕ۑ���p�X
set "ChromeDest=%APPDATA%\Google\Chrome\Default"
set "EdgeDest=%APPDATA%\Microsoft\Edge\Default"

REM �Ώۃt�@�C����`
set FILES=Bookmarks Bookmarks.bak BookmarkMergedSurfaceOrdering

echo [INFO] �u���E�U�������I�����Ă��܂�...

REM �Ώۃu���E�U�������I��
taskkill /F /IM chrome.exe >nul 2>&1
taskkill /F /IM msedge.exe >nul 2>&1

REM Chrome ���C�ɓ�����̃C���|�[�g
if exist "%ChromeBackup%" (
    echo [INFO] Chrome�̂��C�ɓ�����𕜌���...
    for %%F in (%FILES%) do (
        if exist "%ChromeBackup%\%%F" (
            echo [INFO] Chrome���C�ɓ�������R�s�[: %%F
            copy /Y "%ChromeBackup%\%%F" "%ChromeDest%\%%F"
            if !errorlevel! == 0 (
                echo [SUCS] Chrome�R�s�[����: %%F
            ) else (
                echo [EROR] Chrome�R�s�[���s: %%F �G���[�R�[�h: !errorlevel!
            )
        ) else (
            echo [EROR] Chrome: %%F�i�o�b�N�A�b�v�ɑ��݂����j
        )
    )
) else (
    echo [WARN] Chrome�o�b�N�A�b�v�t�H���_��������܂���: %ChromeBackup%
)

REM Edge ���C�ɓ�����̃C���|�[�g
if exist "%EdgeBackup%" (
    echo [INFO] Edge�̂��C�ɓ�����𕜌���...
    for %%F in (%FILES%) do (
        if exist "%EdgeBackup%\%%F" (
            echo [INFO] Edge���C�ɓ�������R�s�[: %%F
            copy /Y "%EdgeBackup%\%%F" "%EdgeDest%\%%F"
            if !errorlevel! == 0 (
                echo [SUCS] Edge�R�s�[����: %%F
            ) else (
                echo [EROR] Edge�R�s�[���s: %%F �G���[�R�[�h: !errorlevel!
            )
        ) else (
            echo [EROR] Edge: %%F�i�o�b�N�A�b�v�ɑ��݂����j
        )
    )
) else (
    echo [WARN] Edge�o�b�N�A�b�v�t�H���_��������܂���: %EdgeBackup%
)

echo [INFO] ���C�ɓ�����̃C���|�[�g���������܂����B
echo �����f�ɂ̓u���E�U�̍ċN�����K�v

endlocal
