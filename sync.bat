@echo off
chcp 65001 >nul
echo ==========================================
echo       Синхронизация проекта с GitHub
echo ==========================================
echo.

echo 1. Получение последних обновлений...
git pull origin main
if errorlevel 1 (
    echo [ОШИБКА] Не удалось получить обновления. Проверьте подключение к сети.
    pause
    exit /b
)

echo.
echo 2. Проверка локальных изменений...
git add .
git diff-index --quiet HEAD --
if %errorlevel% equ 0 (
    echo Нет новых изменений для отправки.
    echo Всё актуально!
    echo.
    pause
    exit /b
)

echo.
echo 3. Отправка изменений на GitHub...
git commit -m "Update from friend (%date% %time%)"
git push origin main
if errorlevel 1 (
    echo [ОШИБКА] Не удалось отправить изменения на GitHub.
    pause
    exit /b
)

echo.
echo ==========================================
echo   Готово! Изменения отправлены на GitHub.
echo   Автодеплой обновит плейс в Roblox.
echo ==========================================
echo.
pause
