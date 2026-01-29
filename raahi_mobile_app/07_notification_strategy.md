# Notification Strategy - Raahi Mobile App

**Version:** 1.0
**Date:** January 2025

---

## Notification Types

| Type | Channel | Priority | Sound |
|------|---------|----------|-------|
| Safety Alert (Critical) | Push + Local | High | Alarm |
| Safety Alert (Warning) | Push | Default | Chime |
| Trip Assignment | Push | High | Notification |
| Earnings Update | Push | Default | Coin |
| Break Reminder | Local | Default | Gentle |
| Document Expiry | Push | Low | None |

---

## FCM Setup

```typescript
// Android: google-services.json
// iOS: GoogleService-Info.plist + APNs certificate

async function initFCM() {
  const token = await messaging().getToken();
  await api.post('/auth/fcm-token', { token });

  messaging().onMessage(handleForeground);
  messaging().setBackgroundMessageHandler(handleBackground);
}
```

---

## Deep Linking

| Notification | Deep Link |
|--------------|-----------|
| Trip Assignment | `raahi://trip/{trip_id}` |
| Safety Alert | `raahi://alerts/{alert_id}` |
| Earnings | `raahi://earnings` |
| Document Expiry | `raahi://documents/{doc_id}` |

---

## Local Notifications

```typescript
// Break reminder (every 4 hours of driving)
scheduleNotification({
  title: 'Time for a break',
  body: 'You have been driving for 4 hours',
  trigger: { type: 'interval', hours: 4 }
});
```

---

**Last Updated:** January 2025
