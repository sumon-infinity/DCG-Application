#!/bin/bash

# Flutter Web Deployment Script for GitHub Pages
# This script builds your Flutter app for web and deploys it to GitHub Pages

set -e

echo "🚀 Starting Flutter Web deployment to GitHub Pages..."

# Check if gh-pages branch exists
if git show-ref --verify --quiet refs/heads/gh-pages; then
    echo "✅ gh-pages branch exists"
else
    echo "📝 Creating gh-pages branch..."
    git checkout --orphan gh-pages
    git reset --hard
    git commit --allow-empty -m "Initial gh-pages commit"
    git checkout flutter
fi

# Build the Flutter web app
echo "🔨 Building Flutter web app..."
flutter build web --release

# Switch to gh-pages branch
echo "🔄 Switching to gh-pages branch..."
git checkout gh-pages

# Remove existing files (except .git)
echo "🗑️  Cleaning old files..."
find . -maxdepth 1 ! -name '.git' ! -name '.' ! -name '..' -exec rm -rf {} +

# Copy built files
echo "📁 Copying new build files..."
cp -r build/web/* .

# Add CNAME file if you have a custom domain (uncomment and modify if needed)
# echo "yourdomain.com" > CNAME

# Commit and push
echo "📝 Committing changes..."
git add .
git commit -m "Deploy Flutter web app - $(date)"

echo "⬆️  Pushing to GitHub..."
git push origin gh-pages

# Switch back to main branch
echo "🔙 Switching back to flutter branch..."
git checkout flutter

echo "✅ Deployment complete!"
echo "🌐 Your app will be available at: https://sumon-infinity.github.io/DCG-Application/"
echo "⏰ It may take a few minutes for GitHub Pages to update."
