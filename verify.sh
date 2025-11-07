#!/bin/bash
# Verification script for Homebrew tap before publishing

set -e

echo "🔍 Verifying Homebrew tap setup..."
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check 1: Formula exists
echo -n "✓ Checking Formula/mental-note.rb exists... "
if [ -f "Formula/mental-note.rb" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAIL${NC}"
    exit 1
fi

# Check 2: Distribution file exists
echo -n "✓ Checking distribution file exists... "
if [ -f "releases/mental-note-v1.0.0-darwin-arm64.tar.gz" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAIL${NC}"
    exit 1
fi

# Check 3: SHA256 file exists
echo -n "✓ Checking SHA256 checksum file exists... "
if [ -f "releases/mental-note-v1.0.0-darwin-arm64.tar.gz.sha256" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAIL${NC}"
    exit 1
fi

# Check 4: SHA256 matches
echo -n "✓ Verifying SHA256 checksum matches... "
CALCULATED=$(shasum -a 256 releases/mental-note-v1.0.0-darwin-arm64.tar.gz | awk '{print $1}')
STORED=$(cat releases/mental-note-v1.0.0-darwin-arm64.tar.gz.sha256 | awk '{print $1}')

if [ "$CALCULATED" = "$STORED" ]; then
    echo -e "${GREEN}OK${NC}"
    echo "  Checksum: $CALCULATED"
else
    echo -e "${RED}FAIL${NC}"
    echo "  Expected: $STORED"
    echo "  Got:      $CALCULATED"
    exit 1
fi

# Check 5: Formula SHA256 matches
echo -n "✓ Checking formula contains correct SHA256... "
FORMULA_SHA=$(grep 'sha256' Formula/mental-note.rb | sed 's/.*sha256 "\(.*\)".*/\1/')

if [ "$FORMULA_SHA" = "$STORED" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAIL${NC}"
    echo "  Formula has: $FORMULA_SHA"
    echo "  File has:    $STORED"
    echo "  ${YELLOW}Update line 13 in Formula/mental-note.rb${NC}"
    exit 1
fi

# Check 6: Formula syntax (requires Ruby)
echo -n "✓ Validating formula syntax (Ruby)... "
if ruby -c Formula/mental-note.rb > /dev/null 2>&1; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAIL${NC}"
    echo "  Ruby syntax error in Formula/mental-note.rb"
    ruby -c Formula/mental-note.rb
    exit 1
fi

# Check 7: Documentation exists
echo -n "✓ Checking documentation files... "
MISSING=""
[ ! -f "README.md" ] && MISSING="$MISSING README.md"
[ ! -f "SETUP.md" ] && MISSING="$MISSING SETUP.md"
[ ! -f "HOMEBREW-DISTRIBUTION.md" ] && MISSING="$MISSING HOMEBREW-DISTRIBUTION.md"
[ ! -f "LICENSE" ] && MISSING="$MISSING LICENSE"

if [ -z "$MISSING" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAIL${NC}"
    echo "  Missing: $MISSING"
    exit 1
fi

# Check 8: Git initialized
echo -n "✓ Checking if git repository initialized... "
if [ -d ".git" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${YELLOW}NOT YET${NC}"
    echo "  Run: git init"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✓ All checks passed!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo "  1. Create GitHub repository: homebrew-mental-note"
echo "  2. git init && git add . && git commit -m 'Initial commit'"
echo "  3. git remote add origin https://github.com/USERNAME/homebrew-mental-note.git"
echo "  4. git push -u origin main"
echo ""
echo "Then test with:"
echo "  brew tap USERNAME/mental-note"
echo "  brew install mental-note"
echo ""
