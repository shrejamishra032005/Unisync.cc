@echo off
REM UniSync Local Development Startup Script

setlocal enabledelayedexpansion

title UniSync - Local Development

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║          🚀 UniSync Local Development Setup                ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

set PGBIN=C:\Program Files\PostgreSQL\18\bin
set DATADIR=C:\Users\omsat\OneDrive\Desktop\unisync-main\pgsql-data

echo 📦 Starting PostgreSQL...
"%PGBIN%\pg_ctl.exe" -D "%DATADIR%" status >nul 2>&1
if errorlevel 1 (
    echo   Initializing cluster on port 5433...
    "%PGBIN%\pg_ctl.exe" -D "%DATADIR%" -o "-p 5433" -l "%DATADIR%\logfile" start
    timeout /t 3 /nobreak
    echo   ✅ PostgreSQL started
) else (
    echo   ✅ PostgreSQL already running
)

echo.
echo 🔗 Testing database connection...
set PGPASSWORD=uniconnect_dev
"%PGBIN%\psql.exe" -h 127.0.0.1 -p 5433 -U uniconnect -d uniconnect -c "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo   ❌ Database connection failed
    pause
    exit /b 1
) else (
    echo   ✅ Database connected
)

echo.
echo 📋 Service Status:
echo ──────────────────────────────────────────────────────────────

netstat -ano 2>nul | find ":4000" | find "LISTENING" >nul
if errorlevel 1 (
    echo   Backend (http://localhost:4000):  ⚠️ Not running
) else (
    echo   Backend (http://localhost:4000):  ✅ Running
)

netstat -ano 2>nul | find ":3000" | find "LISTENING" >nul
if errorlevel 1 (
    echo   Frontend (http://localhost:3000): ⚠️ Not running
) else (
    echo   Frontend (http://localhost:3000): ✅ Running
)

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║              ✅ ALL REQUIRED SERVICES READY                ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo 📱 Frontend: http://localhost:3000
echo 🔧 Backend API: http://localhost:4000
echo 📚 Swagger Docs: http://localhost:4000/api/docs
echo.
echo To start the backend, open a new terminal and run:
echo   npm run dev --workspace @uniconnect/api
echo.
echo To start the frontend, open a new terminal and run:
echo   npm run dev --workspace @uniconnect/web
echo.

pause
