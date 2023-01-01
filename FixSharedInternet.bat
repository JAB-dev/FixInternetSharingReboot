NET SESSION
IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE
GOTO ADMINTASKS

:ELEVATE
CD /d %~dp0
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1);close();"
EXIT

:ADMINTASKS
REM Add key to registry, USER NEEDS ADMIN RIGHTS
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedAccess /v EnableRebootPersistConnection /t REG_DWORD /d 1
REM Set service to start automatically, USER NEEDS ADMIN RIGHTS
sc config SharedAccess start=auto
EXIT