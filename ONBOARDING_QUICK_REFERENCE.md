# 🎯 Onboarding Pipeline - Quick Reference Guide

## 🚀 What Changed

### 1. Created Demo User Utility (`src/lib/demo.ts`)
Centralized list of demo credentials that bypass onboarding:
- `teacher.demo@iitd.ac.in`
- `student.demo@iitd.ac.in`

### 2. Updated Sign-In (`src/app/auth/signin/page.tsx`)
**New Logic:**
```
IF user is demo → dashboard
ELSE IF not onboarded → onboarding
ELSE → dashboard
```

### 3. Updated Dashboard Guard (`src/app/dashboard/layout.tsx`)
**New Protection:**
```
IF not logged in → /auth
ELSE IF not onboarded AND not demo → /onboarding
ELSE → allow dashboard access
```

---

## 🔑 Key Features

✅ **Mandatory Onboarding** - New non-demo users must complete profile  
✅ **Demo Bypass** - Demo accounts skip onboarding for testing  
✅ **Single Source of Truth** - `isOnboarded` flag in database  
✅ **Seamless Redirects** - Automatic routing based on user state  
✅ **Production Ready** - Fully tested and compiled  

---

## 👤 User Flows by Type

### New Regular User
```
signup → email verify → /onboarding → complete profile → /dashboard
```

### Demo User
```
signin → /dashboard (direct access, no onboarding)
```

### Returning User (Already Onboarded)
```
signin → /dashboard (direct access, skips onboarding)
```

### Unauthenticated Visitor
```
/dashboard (direct link) → /auth/signin
```

---

## 🧪 Quick Test Commands

```bash
# Build the project
npm run build

# Check for TypeScript errors
npm run typecheck

# Run with dev server
npm run dev
```

---

## 🛠️ Configuration

### Add/Remove Demo Users
Edit `src/lib/demo.ts`:
```typescript
export const DEMO_EMAILS = new Set([
  'teacher.demo@iitd.ac.in',
  'student.demo@iitd.ac.in',
  // Add more demo emails here
]);
```

### Customize Onboarding Requirements
Edit `src/app/onboarding/page.tsx`:
```typescript
// Look for this section to change required fields:
const requiredProfileErrors = (() => {
  const errors: string[] = [];
  if (!form.name.trim()) errors.push('Full name is required');
  // ... modify requirements here
});
```

---

## 🚨 Troubleshooting

### Issue: User stuck in onboarding loop
**Solution:** Check if `isOnboarded` is being set to true after profile submission in backend

### Issue: Demo user not bypassing onboarding
**Solution:** Verify email matches exactly (case-sensitive): `teacher.demo@iitd.ac.in`

### Issue: Non-demo user goes to dashboard without onboarding
**Solution:** Check database - `isOnboarded` flag might be incorrectly set to true

### Issue: Dashboard shows loading spinner forever
**Solution:** Check auth token validity, may need to logout and login again

---

## 📋 Files Modified

1. ✅ **Created**: `apps/web/src/lib/demo.ts`
2. ✅ **Updated**: `apps/web/src/app/auth/signin/page.tsx`
3. ✅ **Updated**: `apps/web/src/app/dashboard/layout.tsx`
4. ℹ️ **No changes**: Backend already supports onboarding

---

## 🎯 Next Steps

1. **Deploy to production**
2. **Monitor user onboarding completion rates**
3. **Gather user feedback on profile form**
4. **Optimize required fields based on feedback**
5. **Add analytics to track onboarding dropoff**

---

## 📞 Support

For issues or questions about the onboarding pipeline:
- Check the full test report: [ONBOARDING_PIPELINE_TEST_REPORT.md](ONBOARDING_PIPELINE_TEST_REPORT.md)
- Review implementation files mentioned above
- Verify database has `isOnboarded` field in User table

---

**Status:** ✅ PRODUCTION READY  
**Last Updated:** June 16, 2026  
**Build Status:** ✅ PASSING
