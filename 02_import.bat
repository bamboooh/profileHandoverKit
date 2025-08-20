@echo off
setlocal

REM ==============================================
REM 01_import.bat
REM �E���̃o�b�`�̂���ꏊ�Ɋ���킹
REM �EyyyyMMdd_HHmmss_import.log �� log �z���ɍ쐬
REM �E�q�o�b�`�o�͂����ׂĒP�ꃍ�O�֏W��
REM ==============================================

cd /d "%~dp0"

REM ���O����
set "LogDir=%CD%\log"
if not exist "%LogDir%" mkdir "%LogDir%"

for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format \"yyyyMMdd_HHmmss\""') do set "LOG_TS=%%I"
set "LOG_FILE=%LogDir%\%LOG_TS%_import.log"

REM �q������Q�Ƃ�������Ύg������ϐ�
set "LOG_DIR=%LogDir%"
set "LOG_FILE_PATH=%LOG_FILE%"

REM �w�b�_
echo ===== START IMPORT %DATE% %TIME% (TS=%LOG_TS%) =====> "%LOG_FILE%"

REM �����o�^���C���|�[�g
echo [STEP] ��01_�����o�^���C���|�[�g �J�n�� >> "%LOG_FILE%"
call "moduleBat\01_�����o�^���C���|�[�g.bat" >> "%LOG_FILE%" 2>&1
echo [STEP] ��01_�����o�^���C���|�[�g �I���� >> "%LOG_FILE%"

REM ���C�ɓ�����C���|�[�g
echo [STEP] ��11_���C�ɓ�����C���|�[�g �J�n�� >> "%LOG_FILE%"
call "moduleBat\11_���C�ɓ�����C���|�[�g.bat" >> "%LOG_FILE%" 2>&1
echo [STEP] ��11_���C�ɓ�����C���|�[�g �I���� >> "%LOG_FILE%"

REM �t�b�^
echo ===== END IMPORT %DATE% %TIME% =====>> "%LOG_FILE%"

echo ���O�o��: "%LOG_FILE%"
echo "��L�̏ꏊ�Ƀ��O���o�͂��A�C���|�[�g�����͏I�����܂���"
pause
endlocal
