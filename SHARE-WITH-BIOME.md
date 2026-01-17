# How to Share This Reproduction with Biome Team

This reproduction case is ready to share with the Biome maintainers on GitHub.

## Repository URL

**GitHub Repository:** https://github.com/JustinBeckwith/biome-stack-overflow-repro

Share this URL on GitHub issue #6777: https://github.com/biomejs/biome/issues/6777

## Quick Reproduction Steps for Maintainers

```bash
git clone https://github.com/JustinBeckwith/biome-stack-overflow-repro.git
cd biome-stack-overflow-repro
npm install
npm run reproduce
# Result: stack overflow crash
```

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

**Repository:** https://github.com/JustinBeckwith/biome-stack-overflow-repro

**Reproduction steps:**
```bash
git clone https://github.com/JustinBeckwith/biome-stack-overflow-repro.git
cd biome-stack-overflow-repro
npm install
npm run reproduce
```

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
