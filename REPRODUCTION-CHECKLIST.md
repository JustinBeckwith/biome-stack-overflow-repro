# Reproduction Checklist

Use this checklist when reporting or verifying the bug.

## Prerequisites
- [ ] Node.js v20+ installed
- [ ] Git installed

## Steps to Reproduce
1. [ ] Clone/download this repository
2. [ ] Navigate to the directory: `cd biome-bug-repro`
3. [ ] Initialize git: `git init`
4. [ ] Install dependencies: `npm install`
5. [ ] Run reproduction: `npm run reproduce`

## Expected Result
✅ File lints successfully

## Actual Result
❌ Stack overflow crash:
```
thread 'biome::workspace_worker_0' has overflowed its stack
fatal runtime error: stack overflow, aborting
```

## Verification Tests
Run `./test-scenarios.sh` to verify all scenarios:
- [ ] Crashes with git + noMisusedPromises (bug present)
- [ ] Works without git repo (confirms git dependency)
- [ ] Works with different nursery rule (isolates to noMisusedPromises)
- [ ] Works without the rule (confirms rule is the trigger)

## Environment Details
- **Biome Version:** 2.3.11
- **Platform:** ___________
- **Node Version:** ___________
- **Git Version:** ___________

## Files in This Repo
- `runtimeTransform.ts` - The file that triggers the bug (209 lines)
- `biome.json` - Minimal config with only noMisusedPromises enabled
- `package.json` - Project config with Biome 2.3.11
- `test-scenarios.sh` - Script to test all scenarios
- `README.md` - Full bug description and context
