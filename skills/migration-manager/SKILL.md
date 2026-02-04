---
name: migration-manager
description: Manage Prisma migrations safely and efficiently. Use when creating, modifying, or deploying database migrations.
---

# Prisma Migration Manager Skill

## When to Use

- Creating new migrations
- Modifying existing migrations
- Deploying migrations to production
- Resolving migration conflicts
- Rolling back migrations

## Instructions

### 1. Creating Migrations

Development workflow:
```bash
# Create and apply migration
prisma migrate dev --name add_user_email_index

# Create migration without applying (for custom SQL)
prisma migrate dev --create-only --name custom_migration
```

### 2. Reviewing Migrations

Before applying, always review:
- Generated SQL in the migration file
- Impact on existing data
- Performance implications
- Rollback strategy

### 3. Production Deployment

```bash
# Deploy migrations to production
prisma migrate deploy

# Check migration status
prisma migrate status

# Resolve migration issues
prisma migrate resolve --applied <migration_name>
```

### 4. Custom SQL Migrations

For complex operations:
```sql
-- Create migration with custom SQL
-- 001_custom_operation.sql

-- Add custom logic
CREATE INDEX CONCURRENTLY idx_users_email ON "User"(email);

-- Add data transformations
UPDATE "Post" SET "publishedAt" = "createdAt" WHERE "publishedAt" IS NULL;
```

### 5. Handling Breaking Changes

When making breaking changes:
1. Create a new field alongside the old one
2. Migrate data to new field
3. Update application code
4. Remove old field in subsequent migration

## Common Scenarios

### Adding a Required Field

```prisma
// Step 1: Add optional field
model User {
  email String?
}

// Step 2: Populate data
// Step 3: Make required
model User {
  email String @unique
}
```

### Renaming a Field

Use raw SQL for renaming to preserve data:
```sql
ALTER TABLE "User" RENAME COLUMN "name" TO "fullName";
```

### Changing Field Types

Use multi-step migrations:
1. Add new field with new type
2. Migrate data
3. Remove old field

## Migration Commands Reference

```bash
# Development
prisma migrate dev              # Create and apply migration
prisma migrate reset            # Reset database and reapply all migrations
prisma db push                  # Sync schema without migration (dev only)

# Production
prisma migrate deploy           # Apply pending migrations
prisma migrate status           # Check migration status
prisma migrate resolve          # Mark migration as applied/rolled back

# Utilities
prisma migrate diff             # Compare schema states
prisma db pull                  # Introspect database to schema
prisma db execute               # Execute raw SQL
```

## Best Practices

1. **Always review** generated SQL before applying
2. **Test migrations** in staging environment first
3. **Use transactions** for data migrations when possible
4. **Backup database** before major migrations
5. **Monitor performance** during and after deployment
6. **Keep migrations small** and focused
7. **Document complex migrations** with comments
8. **Version control** all migration files
