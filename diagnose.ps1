# Diagnostic & Repair Script for UniSync Local Setup

param(
    [switch]$Repair = $false,
    [switch]$Verbose = $false
)

$ErrorActionPreference = 'Continue'

function Test-Port {
    param([int]$Port)
    $listener = netstat -ano 2>$null | Select-String ":$Port.*LISTENING"
    return $listener -ne $null
}

function Write-Status {
    param([string]$Message, [string]$Status)
    $color = if ($Status -eq 'ok') { 'Green' } elseif ($Status -eq 'warn') { 'Yellow' } else { 'Red' }
    Write-Host "$Message" -ForegroundColor $color
}

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║         🔍 UniSync Local Setup Diagnostics                 ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "`n📊 Service Status:" -ForegroundColor Cyan
Write-Host ('─' * 60)

$pgBin = 'C:\Program Files\PostgreSQL\18\bin\pg_ctl.exe'
$dataDir = 'C:\Users\omsat\OneDrive\Desktop\unisync-main\pgsql-data'

Write-Host "`nPostgreSQL:" -ForegroundColor Yellow
if (Test-Path $pgBin) {
    $pgStatus = & $pgBin -D $dataDir status 2>&1
    if ($pgStatus -match 'server is running') {
        Write-Status "PostgreSQL (port 5433) - running" "ok"

        $env:PGPASSWORD = 'uniconnect_dev'
        $dbTest = & 'C:\Program Files\PostgreSQL\18\bin\psql.exe' -h 127.0.0.1 -p 5433 -U uniconnect -d uniconnect -c 'SELECT 1;' 2>&1
        Remove-Item env:PGPASSWORD -ErrorAction SilentlyContinue

        if ($dbTest -match '1') {
            Write-Status "Database connection" "ok"
        }
        else {
            Write-Status "Database connection" "warn"
        }
    }
    else {
        Write-Status "PostgreSQL (port 5433) - not running" "warn"
        if ($Repair) {
            Write-Host "   Attempting to start PostgreSQL..." -ForegroundColor Gray
            & $pgBin -D $dataDir -o '-p 5433' -l "$dataDir\logfile" start 2>&1 | Out-Null
            Start-Sleep -Seconds 3
            Write-Status "PostgreSQL restarted" "ok"
        }
    }
}
else {
    Write-Status "PostgreSQL binary not found" "error"
}

Write-Host "`nBackend Services:" -ForegroundColor Yellow
if (Test-Port 4000) {
    Write-Status "NestJS API (port 4000)" "ok"
} else {
    Write-Status "NestJS API (port 4000)" "warn"
    Write-Host "   Tip: Run 'npm run dev --workspace @uniconnect/api'" -ForegroundColor Gray
}

Write-Host "`nFrontend Services:" -ForegroundColor Yellow
if (Test-Port 3000) {
    Write-Status "Next.js App (port 3000)" "ok"
} else {
    Write-Status "Next.js App (port 3000)" "warn"
    Write-Host "   Tip: Run 'npm run dev --workspace @uniconnect/web'" -ForegroundColor Gray
}

Write-Host "`nOptional Services (Docker):" -ForegroundColor Yellow
try {
    $dockerVersion = docker --version 2>&1
    if ($dockerVersion -match 'Docker') {
        Write-Status "Docker CLI" "ok"
        $dockerInfo = docker info 2>&1
        if ($dockerInfo -match 'Containers|Images') {
            Write-Status "Docker daemon" "ok"
        }
        else {
            Write-Status "Docker daemon" "warn"
            Write-Host "   Note: Docker daemon not responding" -ForegroundColor Gray
        }
    }
}
catch {
    Write-Status "Docker CLI" "warn"
}

Write-Host "`n⚙️  Configuration Files:" -ForegroundColor Yellow
$envFiles = @('apps/api/.env', 'apps/web/.env', '.env')
foreach ($file in $envFiles) {
    if (Test-Path $file) {
        Write-Status "$file" "ok"
    }
    else {
        Write-Status "$file" "warn"
    }
}

Write-Host "`n" -ForegroundColor Cyan
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
if ((Test-Port 4000) -and (Test-Port 3000) -and ($pgStatus -match 'server is running')) {
    Write-Host "║              ✅ ALL SERVICES OPERATIONAL                   ║" -ForegroundColor Green
}
else {
    Write-Host "║              ⚠️  SOME SERVICES NOT RUNNING                  ║" -ForegroundColor Yellow
}
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "`n📱 Quick Access:" -ForegroundColor Cyan
Write-Host "   Frontend:  http://localhost:3000" -ForegroundColor White
Write-Host "   API:       http://localhost:4000" -ForegroundColor White
Write-Host "   Docs:      http://localhost:4000/api/docs" -ForegroundColor White
Write-Host "   Database:  postgresql://uniconnect:uniconnect_dev@localhost:5433/uniconnect" -ForegroundColor White
Write-Host "`n"
