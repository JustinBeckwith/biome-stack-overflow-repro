#!/bin/bash
set -e

echo "=== Biome Stack Overflow Bug - Test Scenarios ==="
echo

# Scenario 1: With git + noMisusedPromises (should crash)
echo "1. Testing with git repo + noMisusedPromises rule..."
if npx @biomejs/biome lint runtimeTransform.ts 2>&1 | grep -q "stack overflow"; then
  echo "   ❌ CRASHED (as expected)"
else
  echo "   ✅ No crash (unexpected)"
fi
echo

# Scenario 2: Without git repo (should work)
echo "2. Testing without git repo..."
mv .git .git.backup
if npx @biomejs/biome lint runtimeTransform.ts >/dev/null 2>&1; then
  echo "   ✅ No crash (as expected)"
else
  echo "   ❌ CRASHED (unexpected)"
fi
mv .git.backup .git
echo

# Scenario 3: With different nursery rule (should work)
echo "3. Testing with noFloatingPromises instead..."
cat > biome.test.json << 'EOF'
{
  "$schema": "https://biomejs.dev/schemas/2.3.11/schema.json",
  "vcs": {
    "enabled": true,
    "clientKind": "git",
    "useIgnoreFile": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "nursery": {
        "noFloatingPromises": "error"
      }
    }
  }
}
EOF
if npx @biomejs/biome lint --config-path=biome.test.json runtimeTransform.ts >/dev/null 2>&1; then
  echo "   ✅ No crash (as expected)"
else
  echo "   ❌ CRASHED (unexpected)"
fi
rm biome.test.json
echo

# Scenario 4: Without the rule (should work)
echo "4. Testing without noMisusedPromises rule..."
cat > biome.test.json << 'EOF'
{
  "$schema": "https://biomejs.dev/schemas/2.3.11/schema.json",
  "vcs": {
    "enabled": true,
    "clientKind": "git",
    "useIgnoreFile": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true
    }
  }
}
EOF
if npx @biomejs/biome lint --config-path=biome.test.json runtimeTransform.ts >/dev/null 2>&1; then
  echo "   ✅ No crash (as expected)"
else
  echo "   ❌ CRASHED (unexpected)"
fi
rm biome.test.json
echo

echo "=== Summary ==="
echo "The bug only occurs with:"
echo "  - Git repository initialized"
echo "  - noMisusedPromises rule enabled"
echo "  - This specific file (runtimeTransform.ts)"
