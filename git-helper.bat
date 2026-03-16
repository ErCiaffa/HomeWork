@echo off
cls
:menu
echo ===========================================
echo                GIT HELPER
echo ===========================================
echo 1) Sincronizza (Pull dal Main)
echo 2) Salva e Invia (Add + Commit + Push)
echo 3) Crea Nuovo Ramo (Branch)
echo 4) Unisci Ramo al Main (Merge)
echo 5) Stato del Progetto (Status)
echo 6) Esci
echo ===========================================
set /p choice="Scegli un'opzione [1-6]: "

if "%choice%"=="1" goto pull
if "%choice%"=="2" goto push
if "%choice%"=="3" goto branch
if "%choice%"=="4" goto merge
if "%choice%"=="5" goto status
if "%choice%"=="6" goto exit

:pull
git pull origin main
echo.
echo Progetto aggiornato!
pause
goto menu

:push
set /p msg="Descrivi cosa hai fatto: "
git add .
git commit -m "%msg%"
for /f "tokens=*" %%a in ('git rev-parse --abbrev-ref HEAD') do set current_branch=%%a
git push origin %current_branch%
echo.
echo Modifiche inviate su %current_branch%!
pause
goto menu

:branch
set /p branchname="Nome del nuovo ramo (es: gestione-errori): "
git checkout -b %branchname%
echo.
echo Ora sei sul ramo: %branchname%
pause
goto menu

:merge
for /f "tokens=*" %%a in ('git rev-parse --abbrev-ref HEAD') do set current_branch=%%a
echo Unendo %current_branch% al Main...
git checkout main
git pull origin main
git merge %current_branch%
git push origin main
echo.
echo Lavoro unito con successo!
pause
goto menu

:status
git status
echo.
pause
goto menu

:exit
exit
