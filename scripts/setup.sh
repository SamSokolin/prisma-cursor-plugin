#!/bin/bash
# Setup script for Prisma Cursor plugin

set -e

echo "🚀 Setting up Prisma Cursor Plugin..."

# Check for Node.js
if ! command -v node &> /dev/null; then
  echo "❌ Node.js is required but not installed."
  exit 1
fi

# Check for npm
if ! command -v npm &> /dev/null; then
  echo "❌ npm is required but not installed."
  exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x scripts/pre-commit.sh
chmod +x scripts/format-schema.js
chmod +x scripts/generate-types.ts

# Check for Prisma CLI
if ! command -v prisma &> /dev/null; then
  echo "📥 Installing Prisma CLI globally..."
  npm install -g prisma
fi

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Configure your database connection in .env"
echo "  2. Create your Prisma schema in prisma/schema.prisma"
echo "  3. Run 'npx prisma migrate dev' to create your database"
