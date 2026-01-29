# Offline Sync Strategy - Raahi Mobile App

**Version:** 1.0
**Date:** January 2025
**Principle:** SQLite is truth. Server is backup.

---

## Quick Reference

| Operation | Works Offline | Sync Priority |
|-----------|--------------|---------------|
| View dashboard | ✅ Full | - |
| View active trip | ✅ Full | - |
| Update loading count | ✅ Queued | 2 |
| Log expense | ✅ Queued | 2 |
| Take photos | ✅ Local | 3 |
| Complete trip/PoD | ✅ Queued | 1 |
| Damage report | ✅ Queued | 1 |
| View earnings | ⚠️ Cached | - |
| AI Chat | ❌ No | - |
| Receive alerts | ❌ No | - |
| Accept new trip | ❌ No | - |

---

## Sync Queue

### Priority Levels

| Priority | Examples | Retry Delay | Max Retries |
|----------|----------|-------------|-------------|
| 1 (Critical) | PoD, damage report, trip complete | 30s, 1m, 2m, 5m | 10 |
| 2 (Normal) | Expenses, loading updates, issues | 1m, 5m, 15m | 5 |
| 3 (Low) | Photos, preferences, analytics | 5m, 15m, 1h | 3 |

### Queue Processing

```typescript
async function processSyncQueue() {
  const items = await db.syncQueue.getPending();

  // Sort by priority, then by created_at
  items.sort((a, b) => {
    if (a.priority !== b.priority) return a.priority - b.priority;
    return a.created_at - b.created_at;
  });

  for (const item of items) {
    try {
      await syncItem(item);
      await db.syncQueue.markCompleted(item.id);
    } catch (error) {
      await db.syncQueue.incrementRetry(item.id, error.message);

      if (item.retry_count >= item.max_retries) {
        await db.syncQueue.markFailed(item.id);
        notifyUser('Sync failed', item);
      }
    }
  }
}
```

---

## Conflict Resolution

**Rule:** Server wins (except for draft data)

| Scenario | Resolution |
|----------|------------|
| Trip updated on both | Server version wins, merge earnings |
| Expense exists on server | Skip, mark local as synced |
| Trip completed offline, server says cancelled | Alert user, keep local data |
| Document expired on server | Update local, notify user |

---

## Background Sync Triggers

1. **App foreground** - Immediate sync
2. **Network restored** - Immediate sync
3. **Every 5 minutes** - When app active
4. **Push notification** - Sync specific entity

---

**Last Updated:** January 2025
