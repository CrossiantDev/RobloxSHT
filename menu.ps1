$Host.UI.RawUI.WindowTitle = "RobloxSHT - Панель управления"

function Show-Menu {
    Clear-Host
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "             RobloxSHT - Панель управления          " -ForegroundColor Cyan
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " [1] Отправить изменения на GitHub (обновит плейс)" -ForegroundColor Yellow
    Write-Host " [2] Забрать свежий код с GitHub" -ForegroundColor Green
    Write-Host " [3] Запустить Rojo для связи с Roblox Studio" -ForegroundColor Magenta
    Write-Host " [4] Установить плагин Rojo в Roblox Studio" -ForegroundColor Blue
    Write-Host " [0] Выход" -ForegroundColor Gray
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Выберите пункт [0-4]"
    
    switch ($choice) {
        "1" {
            Clear-Host
            Write-Host "[1/3] Забираем свежие изменения..." -ForegroundColor Yellow
            git pull origin main
            Write-Host "`n[2/3] Добавляем файлы..." -ForegroundColor Yellow
            git add .
            $diff = git status --porcelain
            if (-not $diff) {
                Write-Host "`nНет новых изменений для отправки." -ForegroundColor Green
            } else {
                Write-Host "`n[3/3] Отправляем изменения на GitHub..." -ForegroundColor Yellow
                $msg = Read-Host "Краткое описание изменений (Enter для авто)"
                if ([string]::IsNullOrWhiteSpace($msg)) { $msg = "Update project" }
                git commit -m "$msg ($((Get-Date).ToString('dd.MM.yyyy HH:mm')))"
                git push origin main
                Write-Host "`nГотово! Код отправлен, GitHub Actions обновляет плейс." -ForegroundColor Green
            }
            Write-Host ""
            Pause
        }
        "2" {
            Clear-Host
            Write-Host "Получаем обновления с сервера..." -ForegroundColor Yellow
            git pull origin main
            Write-Host "`nГотово! Ваши файлы обновлены." -ForegroundColor Green
            Write-Host ""
            Pause
        }
        "3" {
            Clear-Host
            Write-Host "====================================================" -ForegroundColor Magenta
            Write-Host "Запуск Rojo сервера..." -ForegroundColor Magenta
            Write-Host "Не закрывайте это окно, пока работаете в Roblox Studio!" -ForegroundColor Yellow
            Write-Host "В Studio во вкладке Plugins нажмите Rojo -> Connect." -ForegroundColor Cyan
            Write-Host "====================================================" -ForegroundColor Magenta
            Write-Host ""
            rojo serve
            Pause
        }
        "4" {
            Clear-Host
            Write-Host "Установка плагина Rojo в Roblox Studio..." -ForegroundColor Blue
            $p = "$env:LOCALAPPDATA\Roblox\Plugins"
            if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p -Force }
            Invoke-WebRequest "https://github.com/rojo-rbx/rojo/releases/download/v7.7.1/Rojo.rbxm" -OutFile "$p\Rojo.rbxm"
            Write-Host "Плагин успешно установлен в $p\Rojo.rbxm" -ForegroundColor Green
            Pause
        }
        "0" {
            exit
        }
        Default {
            # continue loop
        }
    }
}
