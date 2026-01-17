# Biome Stack Overflow Bug - noMisusedPromises Rule

Minimal reproduction case for a stack overflow crash in Biome 2.3.11 when linting a specific TypeScript file with the `noMisusedPromises` rule enabled.

## Bug Summary

**Issue:** Biome crashes with stack overflow when the `noMisusedPromises` nursery rule lints `runtimeTransform.ts`

**Biome Version:** 2.3.11

**Related Issue:** https://github.com/biomejs/biome/issues/6777 (originally reported in v2.1.0, still occurring in v2.3.11)

## Reproduction Steps

```bash
# 1. Clone or download this repository
cd biome-stack-overflow-repro

# 2. Initialize git repository (REQUIRED - bug doesn't occur without git)
git init

# 3. Install dependencies
npm install

# 4. Reproduce the crash
npm run reproduce
# OR
npx @biomejs/biome lint runtimeTransform.ts
```

## Expected Behavior

The file should lint successfully (with or without errors).

## Actual Behavior

```
thread 'biome::workspace_worker_0' has overflowed its stack
fatal runtime error: stack overflow, aborting
```

## Key Findings

✅ **Bug reproduces with minimal config** - only `noMisusedPromises` rule enabled
✅ **File lints successfully when rule is disabled**
✅ **File lints successfully with other nursery rules** (e.g., `noFloatingPromises`)
✅ **Requires git repository** - doesn't crash without `git init`
✅ **File is normal TypeScript** - 209 lines, standard async/await patterns
✅ **No circular dependencies** - verified with madge

## File Details

- **File:** `runtimeTransform.ts` (209 lines)
- **Content:** Runtime transform utility for applying strategy transforms
- **Patterns:** Standard TypeScript with async functions, Promise handling, type imports
- **Nothing unusual:** No complex patterns, regex, or edge cases

## Isolation Testing

```bash
# ✅ Works: Without the rule
npx @biomejs/biome lint runtimeTransform.ts --config-path=<config without noMisusedPromises>

# ❌ Crashes: With the rule
npx @biomejs/biome lint runtimeTransform.ts  # Uses biome.json with noMisusedPromises

# ✅ Works: Without git repository
rm -rf .git
npx @biomejs/biome lint runtimeTransform.ts  # No crash!
git init
npx @biomejs/biome lint runtimeTransform.ts  # Crashes again

# ✅ Works: With different nursery rule
# Edit biome.json to use "noFloatingPromises" instead
npx @biomejs/biome lint runtimeTransform.ts  # No crash
```

## Environment

- **Biome Version:** 2.3.11
- **Platform:** macOS Darwin 25.1.0 (also reproduced on Linux)
- **Node:** v20+
- **TypeScript:** Standard .ts file, no special config needed

## Workaround

Exclude the file in `biome.json`:

```json
{
  "files": {
    "includes": [
      "**/*.ts",
      "!!src/redteam/shared/runtimeTransform.ts"
    ]
  }
}
```

## Notes for Maintainers

- The file itself has no `noMisusedPromises` violations
- Other files in our codebase lint fine with this rule
- This appears to be a specific interaction between:
  1. The file structure/content of `runtimeTransform.ts`
  2. The `noMisusedPromises` analysis algorithm
  3. The presence of git VCS integration

The stack overflow suggests infinite recursion during type analysis or control flow analysis in the `noMisusedPromises` rule implementation.

## Contact

Original report: @JustinBeckwith on GitHub issue #6777

Feel free to reach out if you need any additional information or testing!
