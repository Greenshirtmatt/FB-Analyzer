#!/bin/bash

# Script to deploy the Facebook Data Analyzer to GitHub Pages

# Display initial message
echo "📦 Preparing to deploy Facebook Data Analyzer to GitHub Pages..."

# Check if repository exists
if [ ! -d ".git" ]; then
  echo "❌ No git repository found. Initializing repository..."
  git init
  
  # Prompt for repository URL
  echo "Enter your GitHub repository URL (e.g., https://github.com/yourusername/facebook-data-analyzer.git):"
  read repo_url
  
  git remote add origin $repo_url
else
  echo "✅ Git repository found."
fi

# Update package.json with correct homepage URL
echo "Enter your GitHub username:"
read github_username

echo "Enter your repository name (default: facebook-data-analyzer):"
read repo_name
repo_name=${repo_name:-facebook-data-analyzer}

# Use sed to update the homepage field in package.json
sed -i '' "s|\"homepage\": \"https://yourusername.github.io/facebook-data-analyzer\"|\"homepage\": \"https://$github_username.github.io/$repo_name\"|g" package.json

echo "✅ Updated package.json with correct homepage URL"

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
  echo "📚 Installing dependencies..."
  npm install
else
  echo "✅ Dependencies already installed."
fi

# Install gh-pages package if not already installed
if ! grep -q "\"gh-pages\":" package.json; then
  echo "📚 Installing gh-pages package..."
  npm install --save-dev gh-pages
else
  echo "✅ gh-pages package already installed."
fi

# Build and deploy
echo "🏗️ Building and deploying the app..."
npm run deploy

echo "🎉 Deployment complete! Your app should be available at https://$github_username.github.io/$repo_name"
echo "⏱️ Note: It might take a few minutes for GitHub Pages to update."
echo ""
echo "💡 Don't forget to configure GitHub Pages in your repository settings:"
echo "   1. Go to your repository on GitHub"
echo "   2. Click on 'Settings'"
echo "   3. Scroll down to the 'GitHub Pages' section"
echo "   4. Under 'Source', select the 'gh-pages' branch and click 'Save'"