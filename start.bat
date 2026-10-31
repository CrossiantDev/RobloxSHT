@echo off
chcp 65001 >nul
title RobloxSHT - Панель управления

:menu
cls
echo ====================================================
echo             RobloxSHT - Панель управления
echo ====================================================
echo.
echo [1] Отправить изменения на GitHub (обновит плейс)
echo [2] Забрать свежий код с GitHub
echo [3] Запустить Rojo для связи с Roblox Studio
echo [4] Установить плагин Rojo в Roblox Studio
echo [0] Выход
echo.
echo ====================================================
set /p choice="Выберите пункт [0-4] и нажмите Enter: "

if "%choice%"=="1" goto push_changes
if "%choice%"=="2" goto pull_changes
if "%choice%"=="3" goto start_rojo
if "%choice%"=="4" goto install_plugin
if "%choice%"=="0" exit /b
goto menu

:push_changes
cls
echo [1/3] Забираем свежие изменения...
git pull origin main
echo.
echo [2/3] Добавляем ваши файлы...
git add .
git diff-index --quiet HEAD --
if %errorlevel% equ 0 (
    echo.
    echo Нет новых изменений для отправки.
    pause
    goto menu
)
echo.
echo [3/3] Отправляем изменения на сервер...
set /p msg="Введите кратко, что изменили (или нажмите Enter для авто): "
if "%msg%"=="" set msg=Update by teammate
git commit -m "%msg% (%date% %time%)"
git push origin main
echo.
echo Готово! Изменения отправлены на GitHub, автодеплой запущен.
pause
goto menu

:pull_changes
cls
echo Получаем изменения с сервера...
git pull origin main
echo.
echo Готово! Ваши файлы обновлены.
pause
goto menu

:start_rojo
cls
echo ====================================================
echo Запуск Rojo сервера на порту 34872...
echo Не закрывайте это окно, пока работаете в Roblox Studio!
echo В Studio во вкладке Plugins нажмите Rojo -> Connect.
echo ====================================================
echo.
rojo serve
pause
goto menu

:install_plugin
cls
echo Установка плагина Rojo в Roblox Studio...
powershell -Command "$p=\"$env:LOCALAPPDATA\Roblox\Plugins\"; if(!(Test-Path $p)){New-Item -ItemType Directory -Path $p -Force}; Invoke-WebRequest 'https://github.com/rojo-rbx/rojo/releases/download/v7.7.1/Rojo.rbxm' -OutFile \"$p\Rojo.rbxm\""
echo Плагин успешно помещен в папку Roblox Studio.
pause
goto menu
