# 🚀 UniSync Local Setup Guide

## ✅ What's Installed & Running

### Core Services (All Working)
- **PostgreSQL 18.4** - Running on port 5433 (local standalone cluster)
- **NestJS Backend API** - Running on port 4000
- **Next.js Frontend** - Running on port 3000
- **Prisma ORM** - Connected and migrated

### Access Points
- Frontend: http://localhost:3000
- Backend API: http://localhost:4000
- Swagger Docs: http://localhost:4000/api/docs
- Database: postgresql://uniconnect:uniconnect_dev@localhost:5433/uniconnect

## 🗂️ Local PostgreSQL Cluster

The project uses a **standalone PostgreSQL cluster** at:
```
C:\Users\omsat\OneDrive\Desktop\unisync-main\pgsql-data
```

### Starting PostgreSQL
```powershell
$dataDir = 'C:\Users\omsat\OneDrive\Desktop\unisync-main\pgsql-data'
& 'C:\Program Files\PostgreSQL\18\bin\pg_ctl.exe' -D $dataDir -o '-p 5433' -l "$dataDir\logfile" start
```

### Stopping PostgreSQL
```powershell
& 'C:\Program Files\PostgreSQL\18\bin\pg_ctl.exe' -D $dataDir stop
```

### Quick Start Script
```powershell
.\start-dev.ps1
```

## ⚙️ Optional Services (Docker)

### ⚠️ Docker Desktop Issue
Docker Desktop on this system is experiencing connectivity issues due to the Docker daemon not starting properly. This affects:
- Redis (optional - for caching)
- Elasticsearch (optional - for search indexing)

**Status**: Both Redis and Elasticsearch are marked as **optional** in the project's `.env` files, so the app runs fully without them.

### If You Need Docker (Workaround)
1. **Start Docker Desktop manually**: Open Docker Desktop from the Start menu
2. **Wait 2-3 minutes** for the daemon to initialize
3. **Test connection**: Run `docker ps`
4. **Start services**: 
   ```powershell
   cd C:\Users\omsat\OneDrive\Desktop\unisync-main
   docker compose up -d redis elasticsearch
   ```

### Manual Docker Restart (Admin Required)
```powershell
# Run PowerShell as Administrator
Stop-Process -Name "Docker Desktop" -Force -ErrorAction SilentlyContinue
& "C:\Program Files\Docker\Docker\Docker Desktop.exe"
Start-Sleep -Seconds 30
docker ps
```

## 📦 Dependencies Installed

✅ Node.js v22.22.3
✅ npm 10.9.8 (1,593 packages)
✅ All workspace packages (@uniconnect/api, @uniconnect/web, @uniconnect/shared, @uniconnect/mobile, @uniconnect/config)
✅ Prisma Client v6.19.3
✅ Prisma schema migrated (18 tables)

## 🔄 Development Workflows

### Start Backend Only
```powershell
npm run dev --workspace @uniconnect/api
```

### Start Frontend Only
```powershell
npm run dev --workspace @uniconnect/web
```

### Build Production
```powershell
npm run build
```

### Prisma Operations
```powershell
# Generate Prisma client
npm run db:generate

# Push schema changes
npm run db:push

# Open Prisma Studio
npm run db:studio
```

## 🐛 Troubleshooting

### PostgreSQL won't start
```powershell
# Check if already running
Get-Process postgres.exe

# Check logs
Get-Content 'C:\Users\omsat\OneDrive\Desktop\unisync-main\pgsql-data\logfile' | Select-Object -Last 20

# Kill any hung processes (use carefully)
Stop-Process -Name postgres -Force -ErrorAction SilentlyContinue
```

### Cannot connect to database
```powershell
# Test connection manually
$env:PGPASSWORD='uniconnect_dev'
& 'C:\Program Files\PostgreSQL\18\bin\psql.exe' -h 127.0.0.1 -p 5433 -U uniconnect -d uniconnect -c 'SELECT 1;'
```

### Backend/Frontend not responding
```powershell
# Check if ports are in use
netstat -ano | findstr ':4000'  # Backend
netstat -ano | findstr ':3000'  # Frontend

# Clear Next.js cache
Remove-Item -Recurse -Force 'apps\web\.next'
npm run build --workspace @uniconnect/web
```

## 📝 Environment Files

All configured for local development at:
- `apps/api/.env` - Backend configuration
- `apps/web/.env` - Frontend configuration
- `.env` (root) - Global database URL

Database URL: `postgresql://uniconnect:uniconnect_dev@localhost:5433/uniconnect`

## ✨ Next Steps

1. **Open Frontend**: http://localhost:3000
2. **Try Sign Up**: Demo mode is enabled for testing
3. **API Docs**: http://localhost:4000/api/docs
4. **Start Developing**: Edit code in `apps/api/src` or `apps/web/src`

---

**Happy coding! 🎉**
