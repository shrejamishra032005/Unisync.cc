# UniSync Architecture

## 1. Overview
UniSync is a TypeScript monorepo that provides:
- Web app: Next.js App Router in apps/web
- Mobile app: Expo React Native in apps/mobile
- API service: NestJS in apps/api
- Shared contracts and constants: packages/shared
- Database schema and client generation: prisma/schema.prisma

## 2. Monorepo Layout
- apps/web: UI, server routes, auth/session handling, dashboard features
- apps/api: modular backend (auth, users, connections, ai), Swagger docs, JWT flows
- apps/mobile: Expo app with auth and tab navigation screens
- packages/shared: common DTOs, constants, university list, shared types
- packages/config: shared config package scaffold
- prisma: source of truth for data model

## 3. Runtime Boundaries
- Web and mobile consume shared contracts from packages/shared.
- API owns business logic and persistence through Prisma.
- Prisma client is generated from prisma/schema.prisma and used by API and web server-side code.
- Cross-service communication is HTTP API based.

## 4. Core Data Domains
- Identity and access: user role, auth methods, onboarding status
- Network graph: connections and requests
- Collaboration: teams, team links, project records, chat
- Opportunities: internships, hackathons, research discovery
- AI assistance: mentor and productivity tool outputs
- Engagement: leaderboard, activity, achievements

## 5. API Architecture (NestJS)
Pattern used:
- Module -> Controller -> Service -> Prisma
- DTO validation via class-validator at boundaries
- JWT auth and guards on protected routes
- Swagger generated from source annotations

Current modules in apps/api/src:
- auth
- users
- connections
- ai
- prisma

## 6. Web Architecture (Next.js)
- App Router pages under apps/web/src/app
- Dashboard area grouped by feature routes (discover, teams, chat, leaderboard, upgrade)
- Reusable components in apps/web/src/components
- Local API wrapper and auth context in apps/web/src/lib

## 7. Mobile Architecture (Expo)
- Route-based screens in apps/mobile/app
- Shared API helper in apps/mobile/src/lib/api.ts
- Uses shared types from packages/shared

## 8. Build and Verification
Root scripts:
- npm run lint: turbo run lint across workspaces
- npm run test: turbo run test across workspaces
- npm run build: turbo run build across workspaces

Web build path:
- Prisma generate
- Next.js production build

API build path:
- nest build

## 9. Configuration and Environments
- Environment variables are expected per app.
- .env and .env.local are ignored by git.
- Vercel build uses apps/web with Prisma generate before Next build.

## 10. Known Technical Gaps
- Lint is placeholder in some packages (mobile/shared/config).
- Turborepo warnings for output-less build tasks in config/mobile.
- Brand/package naming is mixed: user-facing brand is UniSync, package scope remains @uniconnect for compatibility.
- Some generated artifact folders (.next, dist, .turbo) exist locally and should never be committed.

## 11. Recommended Near-Term Architecture Actions
1. Standardize lint across all workspaces (ESLint or Biome).
2. Add integration tests for API auth/connection workflows.
3. Define consistent API response envelope and error code map in packages/shared.
4. Add ADRs (Architecture Decision Records) under docs/adr.
5. Separate mock/demo data from runtime API adapter to reduce app/web/src/lib/api.ts size.
6. Add CI gates: lint + test + build on every PR.
