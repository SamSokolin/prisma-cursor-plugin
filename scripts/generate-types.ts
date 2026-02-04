#!/usr/bin/env tsx
/**
 * Generate TypeScript types after schema changes
 */

import { execSync } from 'child_process';
import * as path from 'path';

async function generateTypes() {
  const schemaPath = process.argv[2] || 'prisma/schema.prisma';
  
  try {
    console.log('🔄 Generating Prisma Client types...');
    
    execSync(`npx prisma generate --schema=${schemaPath}`, {
      stdio: 'inherit'
    });
    
    console.log('✅ Types generated successfully');
  } catch (error) {
    console.error('❌ Failed to generate types:', error);
    process.exit(1);
  }
}

generateTypes();
