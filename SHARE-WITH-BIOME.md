# How to Share This Reproduction with Biome Team

This reproduction case is ready to share with the Biome maintainers on GitHub.

## Option 1: Upload to GitHub (Recommended)

```bash
# 1. Create a new GitHub repository
gh repo create biome-stack-overflow-repro --public --source=. --remote=origin

# 2. Commit all files
git add .
git commit -m "Minimal reproduction for Biome noMisusedPromises stack overflow"

# 3. Push to GitHub
git push -u origin main

# 4. Share the repository URL in GitHub issue #6777
# https://github.com/biomejs/biome/issues/6777
```

## Option 2: Create a Tarball

```bash
# 1. Create tarball (excludes node_modules and .git)
tar -czf biome-bug-repro.tar.gz \
  --exclude=node_modules \
  --exclude=.git \
  biome.json \
  package.json \
  package-lock.json \
  .gitignore \
  runtimeTransform.ts \
  README.md \
  REPRODUCTION-CHECKLIST.md \
  test-scenarios.sh \
  SHARE-WITH-BIOME.md

# 2. Upload to GitHub issue as attachment or to file sharing service
# File size should be ~3-4KB
```

## Option 3: Inline in Issue Comment

Copy and paste the following into a GitHub comment:

---

### Minimal Reproduction Case

I've created a minimal reproduction case for this issue in Biome 2.3.11.

**Quick test:**
```bash
mkdir biome-bug-test && cd biome-bug-test
# Copy files from: [attach tarball or link to repo]
git init
npm install
npm run reproduce
# Result: stack overflow
```

**Key files:**
- `biome.json` - Only `noMisusedPromises` rule enabled
- `runtimeTransform.ts` - The problematic file (209 lines)
- `test-scenarios.sh` - Tests 4 scenarios to isolate the bug

**Findings:**
- ✅ Crashes with git + noMisusedPromises
- ✅ Works without git repo
- ✅ Works with other nursery rules
- ✅ Works without the rule

The bug requires all three: git repository, noMisusedPromises rule, and this specific file.

---

## What to Include in Your Comment

When posting to GitHub issue #6777, include:

1. **Link to reproduction** (GitHub repo or tarball)
2. **Your environment details:**
   - Biome version: 2.3.11
   - Platform: macOS/Linux/Windows
   - Node version: v20+
3. **Confirmation that you can reproduce it**
4. **Any additional observations**

## Example Comment Template

```markdown
## Updated Reproduction for v2.3.11

This issue is still present in Biome 2.3.11. I've created a minimal reproduction case:

**Repository:** [link to your GitHub repo or attachment]

**Reproduction steps:**
1. `git init` (required)
2. `npm install`
3. `npm run reproduce`

**Result:** Stack overflow crash on `noMisusedPromises` rule

**Key finding:** The bug requires git VCS integration to be enabled. Without git, the file lints fine.

**Environment:**
- Biome: 2.3.11
- Platform: macOS Darwin 25.1.0
- Node: v20.x

The reproduction includes test scenarios that verify:
- It crashes with git + noMisusedPromises ❌
- It works without git ✅
- It works with other nursery rules ✅

Let me know if you need any additional information!
```

## Current Status

The bug has already been reported on GitHub issue #6777:
https://github.com/biomejs/biome/issues/6777

You can either:
1. Add a new comment with this reproduction case
2. Reference it if you file a new issue
3. Share it with anyone who needs to reproduce the bug
