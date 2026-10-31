$Host.UI.RawUI.WindowTitle = "RobloxSHT - Control Panel"

function Show-Menu {
    Clear-Host
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host "             RobloxSHT - Control Panel              " -ForegroundColor Cyan
    Write-Host "====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " [1] Otpravit izmeneniya na GitHub (avtodeploy)" -ForegroundColor Yellow
    Write-Host " [2] Zabrat svezhiy kod s GitHub" -ForegroundColor Green
    Write-Host " [3] Zapustit Rojo dlya svyazi so Studio" -ForegroundColor Magenta
    Write-Host " [4] Ustanovit plagin Rojo v Studio" -ForegroundColor Blue
    Write-Host " [0] Vyhod" -ForegroundColor Gray
    Write-Host ""
    Write-Host "====================================================" -ForegroundColor Cyan
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Vvedite punkt [0-4]"
    
    switch ($choice) {
        "1" {
            Clear-Host
            Write-Host "[1/3] Zabiraem svezhie izmeneniya..." -ForegroundColor Yellow
            git pull origin main
            Write-Host "`n[2/3] Dobavlyaem fayly..." -ForegroundColor Yellow
            git add .
            $diff = git status --porcelain
            if (-not $diff) {
                Write-Host "`nNet novyh izmeneniy." -ForegroundColor Green
            } else {
                Write-Host "`n[3/3] Otpravlyaem na GitHub..." -ForegroundColor Yellow
                $msg = Read-Host "Opisanie (Enter dlya avto)"
                if ([string]::IsNullOrWhiteSpace($msg)) { $msg = "Update project" }
                git commit -m "$msg"
                git push origin main
                Write-Host "`nGotovo! Kod otpravlen." -ForegroundColor Green
            }
            Write-Host ""
            cmd /c pause
        }
        "2" {
            Clear-Host
            Write-Host "Poluchaem obnovleniya..." -ForegroundColor Yellow
            git pull origin main
            Write-Host "`nGotovo! Fayly obnovleny." -ForegroundColor Green
            Write-Host ""
            cmd /c pause
        }
        "3" {
            Clear-Host
            Write-Host "====================================================" -ForegroundColor Magenta
            Write-Host "Zapusk Rojo na portu 34872..." -ForegroundColor Magenta
            Write-Host "Ne zakryvayte eto okno, poka rabotaete v Studio!" -ForegroundColor Yellow
            Write-Host "V Studio vo vkladke Plugins nazhmite Rojo -> Connect." -ForegroundColor Cyan
            Write-Host "====================================================" -ForegroundColor Magenta
            Write-Host ""
            rojo serve
            cmd /c pause
        }
        "4" {
            Clear-Host
            Write-Host "Ustanovka plagina Rojo..." -ForegroundColor Blue
            $p = "$env:LOCALAPPDATA\Roblox\Plugins"
            if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p -Force }
            Invoke-WebRequest "https://github.com/rojo-rbx/rojo/releases/download/v7.7.1/Rojo.rbxm" -OutFile "$p\Rojo.rbxm"
            Write-Host "Plagin ustanovlen v $p\Rojo.rbxm" -ForegroundColor Green
            cmd /c pause
        }
        "0" {
            exit
        }
    }
}