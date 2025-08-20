@echo off
setlocal

REM ==============================================
REM 00_export.bat
REM �E���̃o�b�`�̂���ꏊ�Ɋ���킹
REM �EyyyyMMdd_HHmmss_export.log �� log �z���ɍ쐬
REM �E�q�o�b�`�o�͂����ׂĒP�ꃍ�O�֏W��
REM ==============================================

cd /d "%~dp0"

REM �� ���O����
set "LogDir=%CD%\log"
if not exist "%LogDir%" mkdir "%LogDir%"

for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format \"yyyyMMdd_HHmmss\""') do set "LOG_TS=%%I"
set "LOG_FILE=%LogDir%\%LOG_TS%_export.log"

REM �� �q������Q�Ƃ�������Ύg������ϐ��i�����͕s�v�j
set "LOG_DIR=%LogDir%"
set "LOG_FILE_PATH=%LOG_FILE%"

REM �� �w�b�_
echo ===== START EXPORT %DATE% %TIME% (TS=%LOG_TS%) =====> "%LOG_FILE%"

REM �� �����o�^���G�N�X�|�[�g
echo [STEP] ��00_�����o�^���G�N�X�|�[�g �J�n�� >> "%LOG_FILE%"
call "moduleBat\00_�����o�^���G�N�X�|�[�g.bat" >> "%LOG_FILE%" 2>&1
echo [STEP] ��00_�����o�^���G�N�X�|�[�g �I���� >> "%LOG_FILE%"

REM �� ���C�ɓ�����G�N�X�|�[�g
echo [STEP] ��10_���C�ɓ�����G�N�X�|�[�g �J�n�� >> "%LOG_FILE%"
call "moduleBat\10_���C�ɓ�����G�N�X�|�[�g.bat" >> "%LOG_FILE%" 2>&1
echo [STEP] ��10_���C�ɓ�����G�N�X�|�[�g �I���� >> "%LOG_FILE%"

REM �� �t�b�^
echo ===== END EXPORT %DATE% %TIME% =====>> "%LOG_FILE%"

echo ���O�o��: "%LOG_FILE%"
echo "��L�̏ꏊ�Ƀ��O���o�͂��A�G�N�X�|�[�g�����͏I�����܂���"
pause
endlocal
