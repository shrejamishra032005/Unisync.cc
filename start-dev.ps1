# UniSync Local Development Startup Script
# This script starts all required services for local development

Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║          🚀 UniSync Local Development Setup                ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Configuration
$dataDir = 'C:\Users\omsat\OneDrive\Desktop\unisync-main\pgsql-data'
$pgBin = 'C:\Program Files\PostgreSQL\18\bin\pg_ctl.exe'
$psql = 'C:\Program Files\PostgreSQL\18\bin\psql.exe'

# Start PostgreSQL
Write-Host "`n📦 Starting PostgreSQL..." -ForegroundColor Yellow
$pgStatus = & $pgBin -D $dataDir status 2>&1
if ($pgStatus -match 'no server running') {
    Write-Host "   Initializing cluster on port 5433..." -ForegroundColor Gray
    & $pgBin -D $dataDir -o '-p 5433' -l "$dataDir\logfile" start | Out-Null
    Start-Sleep -Seconds 3
    Write-Host "   ✅ PostgreSQL started" -ForegroundColor Green
} else {
    Write-Host "   ✅ PostgreSQL already running" -ForegroundColor Green
}

# Test database connection
Write-Host "`n🔗 Testing database connection..." -ForegroundColor Yellow
$env:PGPASSWORD='uniconnect_dev'
$dbTest = & $psql -h 127.0.0.1 -p 5433 -U uniconnect -d uniconnect -c 'SELECT 1;' 2>&1
Remove-Item env:PGPASSWORD -ErrorAction SilentlyContinue
if ($dbTest -match '1') {
    Write-Host "   ✅ Database connected" -ForegroundColor Green
} else {
    Write-Host "   ❌ Database connection failed" -ForegroundColor Red
    exit 1
}

# Check if dev servers are already running
$backendRunning = (netstat -ano 2>/dev/null | findstr ':4000.*LISTENING') -ne $null
$frontendRunning = (netstat -ano 2>/dev/null | findstr ':3000.*LISTENING') -ne $null

Write-Host "`n📋 Service Status:" -ForegroundColor Yellow
Write-Host "   Backend (http://localhost:4000):  $(if ($backendRunning) { '✅ Running' } else { '⚠️ Not running' })" -ForegroundColor $(if ($backendRunning) { 'Green' } else { 'Yellow' })
Write-Host "   Frontend (http://localhost:3000): $(if ($frontendRunning) { '✅ Running' } else { '⚠️ Not running' })" -ForegroundColor $(if ($frontendRunning) { 'Green' } else { 'Yellow' })

Write-Host "`n" -ForegroundColor Cyan
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              ✅ ALL REQUIRED SERVICES READY                ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

Write-Host "`n📱 Frontend: http://localhost:3000" -ForegroundColor Green
Write-Host "🔧 Backend API: http://localhost:4000" -ForegroundColor Green
Write-Host "📚 Swagger Docs: http://localhost:4000/api/docs" -ForegroundColor Green
Write-Host "🗄️  Database: postgresql://uniconnect:uniconnect_dev@localhost:5433/uniconnect" -ForegroundColor Green

Write-Host "`n" -ForegroundColor Cyan
if (-not $backendRunning) {
    Write-Host "💡 To start the backend, open a new terminal and run:" -ForegroundColor Yellow
    Write-Host "   npm run dev --workspace @uniconnect/api" -ForegroundColor White
}

if (-not $frontendRunning) {
    Write-Host "💡 To start the frontend, open a new terminal and run:" -ForegroundColor Yellow
    Write-Host "   npm run dev --workspace @uniconnect/web" -ForegroundColor White
}

Write-Host "`n"
