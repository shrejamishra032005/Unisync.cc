@echo off
REM Diagnostic & Repair Script for UniSync Local Setup

setlocal enabledelayedexpansion

title UniSync Diagnostics

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║         🔍 UniSync Local Setup Diagnostics                 ║
echo ╚════════════════════════════════════════════════════════════╝

echo.
echo 📊 Service Status:
echo ──────────────────────────────────────────────────────────────

REM Check PostgreSQL
echo.
echo PostgreSQL:
"C:\Program Files\PostgreSQL\18\bin\pg_ctl.exe" -D "C:\Users\omsat\OneDrive\Desktop\unisync-main\pgsql-data" status >nul 2>&1
if errorlevel 1 (
    echo   ❌ PostgreSQL ^(port 5433^)
) else (
    echo   ✅ PostgreSQL ^(port 5433^)
    set PGPASSWORD=uniconnect_dev
    "C:\Program Files\PostgreSQL\18\bin\psql.exe" -h 127.0.0.1 -p 5433 -U uniconnect -d uniconnect -c "SELECT 1;" >nul 2>&1
    if errorlevel 1 (
        echo   ❌ Database connection
    ) else (
        echo   ✅ Database connection
    )
)

REM Check Backend
echo.
echo Backend Services:
netstat -ano 2>nul | find ":4000" | find "LISTENING" >nul
if errorlevel 1 (
    echo   ⚠️  NestJS API ^(port 4000^) - not running
) else (
    echo   ✅ NestJS API ^(port 4000^)
)

REM Check Frontend
echo.
echo Frontend Services:
netstat -ano 2>nul | find ":3000" | find "LISTENING" >nul
if errorlevel 1 (
    echo   ⚠️  Next.js App ^(port 3000^) - not running
) else (
    echo   ✅ Next.js App ^(port 3000^)
)

REM Check Docker
echo.
echo Optional Services ^(Docker^):
docker --version >nul 2>&1
if errorlevel 1 (
    echo   ⚠️  Docker not installed or not in PATH
) else (
    docker info >nul 2>&1
    if errorlevel 1 (
        echo   ⚠️  Docker daemon not responding
    ) else (
        echo   ✅ Docker running
    )
)

REM Check Config Files
echo.
echo ⚙️  Configuration Files:
if exist "apps\api\.env" (
    echo   ✅ apps/api/.env
) else (
    echo   ❌ apps/api/.env
)
if exist "apps\web\.env" (
    echo   ✅ apps/web/.env
) else (
    echo   ❌ apps/web/.env
)
if exist ".env" (
    echo   ✅ .env
) else (
    echo   ❌ .env
)

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║         📱 Quick Access:                                   ║
echo ║         Frontend:  http://localhost:3000                   ║
echo ║         API:       http://localhost:4000                   ║
echo ║         Docs:      http://localhost:4000/api/docs          ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

endlocal
pause
