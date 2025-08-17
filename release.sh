#!/bin/bash

# DCG Application Release Script
# This script helps you create version tags to trigger automatic builds and releases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 DCG Application Release Script${NC}"
echo "=================================="

# Check if we're on the flutter branch
current_branch=$(git branch --show-current)
if [ "$current_branch" != "flutter" ]; then
    echo -e "${YELLOW}⚠️  Warning: You're not on the 'flutter' branch (currently on '$current_branch')${NC}"
    echo -e "Do you want to continue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
fi

# Check if working directory is clean
if ! git diff-index --quiet HEAD --; then
    echo -e "${RED}❌ Working directory is not clean. Please commit your changes first.${NC}"
    git status --porcelain
    exit 1
fi

# Get current version from pubspec.yaml
current_version=$(grep "^version:" pubspec.yaml | sed 's/version: //' | sed 's/+.*//')
echo -e "${BLUE}📋 Current version in pubspec.yaml: ${current_version}${NC}"

# Get latest git tag
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "No tags found")
echo -e "${BLUE}📋 Latest git tag: ${latest_tag}${NC}"

# Prompt for new version
echo ""
echo -e "${YELLOW}📝 Enter new version (e.g., 1.0.0):${NC}"
read -r new_version

# Validate version format
if ! [[ $new_version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${RED}❌ Invalid version format. Please use semantic versioning (e.g., 1.0.0)${NC}"
    exit 1
fi

# Update pubspec.yaml version
echo -e "${BLUE}📝 Updating pubspec.yaml version...${NC}"
build_number=$(date +%s)
sed -i "s/^version:.*/version: ${new_version}+${build_number}/" pubspec.yaml

echo -e "${BLUE}📝 Updated version to: ${new_version}+${build_number}${NC}"

# Commit version change
echo -e "${BLUE}💾 Committing version update...${NC}"
git add pubspec.yaml
git commit -m "Bump version to ${new_version}"

# Create and push tag
tag_name="v${new_version}"
echo -e "${BLUE}🏷️  Creating tag: ${tag_name}${NC}"
git tag -a "$tag_name" -m "Release version ${new_version}"

# Push changes and tag
echo -e "${BLUE}⬆️  Pushing to GitHub...${NC}"
git push origin flutter
git push origin "$tag_name"

echo ""
echo -e "${GREEN}✅ Release process initiated!${NC}"
echo -e "${GREEN}📦 Tag '${tag_name}' has been created and pushed${NC}"
echo -e "${GREEN}🤖 GitHub Actions will now build APK and web versions${NC}"
echo ""
echo -e "${BLUE}🔗 Monitor the build progress at:${NC}"
echo -e "${BLUE}https://github.com/sumon-infinity/DCG-Application/actions${NC}"
echo ""
echo -e "${BLUE}📱 Once complete, the release will be available at:${NC}"
echo -e "${BLUE}https://github.com/sumon-infinity/DCG-Application/releases${NC}"
echo ""
echo -e "${BLUE}🌐 Web version will be deployed to:${NC}"
echo -e "${BLUE}https://sumon-infinity.github.io/DCG-Application/${NC}"
