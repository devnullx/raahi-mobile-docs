# Raahi Mobile App Architecture

**Version:** 1.0
**Date:** January 2025
**Platform:** React Native (iOS + Android)
**Philosophy:** Driver's AI-powered cockpit, offline-first, minimal manual input

---

## Overview

Raahi is the driver-facing mobile application for the DevNullX fleet management platform. It serves as:

1. **AI Copilot** - Natural language assistant for driver needs
2. **Work Manager** - Assignments, loading, unloading, PoD, documents
3. **Financial Hub** - Earnings, expenses (auto-captured), disputes
4. **Safety Interface** - Alerts from Aghraan, break reminders
5. **Communication** - Chat with dispatch/fleet manager

**Core Principle:** Aghraan (edge device) handles automation. Raahi handles human interaction.

---

## Tech Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| **Framework** | React Native 0.73+ | Cross-platform, large ecosystem |
| **Language** | TypeScript | Type safety, better DX |
| **State** | Zustand | Lightweight, simple, works offline |
| **Navigation** | React Navigation 6 | Industry standard |
| **Offline DB** | SQLite (expo-sqlite) | Reliable, performant |
| **Networking** | Axios + React Query | Caching, retry, offline support |
| **Real-time** | MQTT.js | AWS IoT Core compatibility |
| **Push** | FCM (Firebase) | Cross-platform notifications |
| **Auth** | AWS Amplify Auth | Cognito integration |
| **Storage** | expo-secure-store | Tokens, sensitive data |
| **Maps** | react-native-maps | Google Maps / MapMyIndia |
| **Camera** | expo-camera | Document scanning, photos |
| **Voice** | expo-speech + Whisper API | Voice commands, TTS |

---

## Folder Structure

```
raahi-mobile/
├── app/                          # App entry, navigation
│   ├── _layout.tsx               # Root layout (Expo Router)
│   ├── (auth)/                   # Auth flow screens
│   │   ├── login.tsx
│   │   ├── otp-verify.tsx
│   │   └── onboarding.tsx
│   ├── (main)/                   # Main app screens
│   │   ├── _layout.tsx           # Tab navigator
│   │   ├── index.tsx             # Dashboard/Home
│   │   ├── trip/
│   │   │   ├── [id].tsx          # Active trip details
│   │   │   ├── loading.tsx       # Loading process
│   │   │   ├── unloading.tsx     # Unloading + PoD
│   │   │   └── history.tsx       # Past trips
│   │   ├── ai-chat.tsx           # AI Copilot
│   │   ├── earnings.tsx          # Earnings breakdown
│   │   ├── expenses.tsx          # Expense logging
│   │   ├── documents.tsx         # Document wallet
│   │   ├── alerts.tsx            # Safety alerts/incidents
│   │   └── settings.tsx          # Preferences
│   └── (modals)/                 # Modal screens
│       ├── camera.tsx            # Photo capture
│       ├── signature.tsx         # Signature pad
│       ├── damage-report.tsx     # Damage documentation
│       └── issue-report.tsx      # Operational issues
│
├── components/                   # Reusable UI components
│   ├── ui/                       # Base components
│   │   ├── Button.tsx
│   │   ├── Card.tsx
│   │   ├── Input.tsx
│   │   ├── Modal.tsx
│   │   └── Toast.tsx
│   ├── trip/                     # Trip-specific
│   │   ├── TripCard.tsx
│   │   ├── LoadingProgress.tsx
│   │   ├── CargoChecklist.tsx
│   │   └── PoDCapture.tsx
│   ├── earnings/                 # Earnings-specific
│   │   ├── EarningsCard.tsx
│   │   ├── DeductionItem.tsx
│   │   └── DisputeForm.tsx
│   ├── documents/                # Document-specific
│   │   ├── DocumentCard.tsx
│   │   ├── EwayBillScanner.tsx
│   │   └── DigiLockerLink.tsx
│   └── common/                   # Shared components
│       ├── Header.tsx
│       ├── BottomSheet.tsx
│       ├── VoiceButton.tsx
│       └── OfflineIndicator.tsx
│
├── services/                     # API & external services
│   ├── api/                      # REST API clients
│   │   ├── client.ts             # Axios instance, interceptors
│   │   ├── auth.ts               # Auth endpoints
│   │   ├── trips.ts              # Trip endpoints
│   │   ├── earnings.ts           # Earnings endpoints
│   │   ├── expenses.ts           # Expenses endpoints
│   │   ├── documents.ts          # Documents endpoints
│   │   ├── alerts.ts             # Alerts endpoints
│   │   └── chat.ts               # Chat endpoints
│   ├── mqtt/                     # MQTT client
│   │   ├── client.ts             # Connection management
│   │   ├── topics.ts             # Topic definitions
│   │   └── handlers.ts           # Message handlers
│   ├── ai/                       # AI Copilot
│   │   ├── assistant.ts          # LLM API integration
│   │   ├── voice.ts              # Speech-to-text, TTS
│   │   └── suggestions.ts        # Context-aware suggestions
│   ├── location/                 # Location services
│   │   ├── tracker.ts            # Background location
│   │   ├── geofence.ts           # Geofence triggers
│   │   └── navigation.ts         # Turn-by-turn
│   └── notifications/            # Push notifications
│       ├── fcm.ts                # FCM setup
│       ├── handlers.ts           # Notification handlers
│       └── local.ts              # Local notifications
│
├── stores/                       # Zustand stores
│   ├── authStore.ts              # Auth state, tokens
│   ├── tripStore.ts              # Active trip state
│   ├── earningsStore.ts          # Earnings cache
│   ├── expensesStore.ts          # Expenses (pending sync)
│   ├── documentsStore.ts         # Documents cache
│   ├── alertsStore.ts            # Alerts state
│   ├── chatStore.ts              # AI chat history
│   ├── syncStore.ts              # Sync queue state
│   └── settingsStore.ts          # User preferences
│
├── db/                           # SQLite database
│   ├── schema.ts                 # Table definitions
│   ├── migrations.ts             # Schema migrations
│   ├── queries/                  # Query functions
│   │   ├── trips.ts
│   │   ├── expenses.ts
│   │   ├── documents.ts
│   │   └── sync.ts
│   └── sync/                     # Sync logic
│       ├── queue.ts              # Sync queue management
│       ├── conflicts.ts          # Conflict resolution
│       └── background.ts         # Background sync
│
├── hooks/                        # Custom hooks
│   ├── useAuth.ts
│   ├── useTrip.ts
│   ├── useOffline.ts
│   ├── useMqtt.ts
│   ├── useLocation.ts
│   ├── useVoice.ts
│   └── useSync.ts
│
├── utils/                        # Utilities
│   ├── constants.ts              # App constants
│   ├── formatters.ts             # Date, currency, distance
│   ├── validators.ts             # Input validation
│   ├── ocr.ts                    # Receipt/document OCR
│   ├── crypto.ts                 # Encryption helpers
│   └── logger.ts                 # Logging
│
├── types/                        # TypeScript types
│   ├── api.ts                    # API response types
│   ├── models.ts                 # Domain models
│   ├── navigation.ts             # Navigation types
│   └── mqtt.ts                   # MQTT message types
│
├── assets/                       # Static assets
│   ├── images/
│   ├── icons/
│   ├── fonts/
│   └── sounds/                   # Alert sounds
│
├── locales/                      # i18n translations
│   ├── en.json
│   ├── hi.json                   # Hindi
│   ├── ta.json                   # Tamil
│   ├── te.json                   # Telugu
│   └── mr.json                   # Marathi
│
├── app.json                      # Expo config
├── eas.json                      # EAS Build config
├── tsconfig.json
├── package.json
└── README.md
```

---

## State Management (Zustand)

### Why Zustand over Redux/Context?

| Criteria | Zustand | Redux | Context |
|----------|---------|-------|---------|
| Boilerplate | Minimal | Heavy | Medium |
| Bundle size | 1KB | 10KB+ | 0 |
| Offline persistence | Easy | Middleware | Manual |
| Learning curve | Low | High | Low |
| DevTools | Yes | Yes | Limited |

### Store Structure

```typescript
// stores/tripStore.ts
import { create } from 'zustand';
import { persist, createJSONStorage } from 'zustand/middleware';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface TripState {
  activeTrip: Trip | null;
  tripHistory: Trip[];
  loadingProgress: LoadingProgress | null;

  // Actions
  setActiveTrip: (trip: Trip) => void;
  updateLoadingCount: (count: number) => void;
  completeTrip: (pod: ProofOfDelivery) => void;
  clearActiveTrip: () => void;
}

export const useTripStore = create<TripState>()(
  persist(
    (set, get) => ({
      activeTrip: null,
      tripHistory: [],
      loadingProgress: null,

      setActiveTrip: (trip) => set({ activeTrip: trip }),

      updateLoadingCount: (count) => set((state) => ({
        loadingProgress: state.loadingProgress
          ? { ...state.loadingProgress, loadedCount: count }
          : null
      })),

      completeTrip: (pod) => {
        const { activeTrip } = get();
        if (activeTrip) {
          set((state) => ({
            activeTrip: null,
            tripHistory: [
              { ...activeTrip, status: 'completed', pod },
              ...state.tripHistory
            ]
          }));
        }
      },

      clearActiveTrip: () => set({ activeTrip: null })
    }),
    {
      name: 'trip-storage',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
);
```

### Store Responsibilities

| Store | Data | Persisted? |
|-------|------|------------|
| `authStore` | Tokens, user profile | Yes (secure) |
| `tripStore` | Active trip, history | Yes |
| `earningsStore` | Earnings cache | Yes |
| `expensesStore` | Pending expenses | Yes |
| `documentsStore` | Document metadata | Yes |
| `alertsStore` | Recent alerts | Yes |
| `chatStore` | AI conversation | Yes |
| `syncStore` | Sync queue status | Yes |
| `settingsStore` | Preferences | Yes |

---

## Offline-First Strategy

### Principles

1. **SQLite is source of truth** - All data stored locally first
2. **Optimistic UI** - Show changes immediately, sync later
3. **Sync queue** - Failed operations queued for retry
4. **Conflict resolution** - Server wins for most cases

### What Works Offline

| Feature | Offline Capability |
|---------|-------------------|
| View dashboard | Full (cached data) |
| View active trip | Full |
| Update loading count | Full (queued) |
| Log expense | Full (queued) |
| Take photos | Full (stored locally) |
| View earnings | Cached (last sync) |
| View documents | Cached |
| AI Chat | Limited (cached responses) |
| Receive alerts | No (needs MQTT) |
| Start new trip | No (needs assignment) |

### Sync Queue Implementation

```typescript
// db/sync/queue.ts
interface SyncQueueItem {
  id: string;
  operation: 'CREATE' | 'UPDATE' | 'DELETE';
  entity: 'expense' | 'trip_update' | 'document' | 'damage_report';
  payload: any;
  priority: 1 | 2 | 3;  // 1 = critical, 3 = low
  retryCount: number;
  maxRetries: number;
  createdAt: number;
  lastAttempt: number | null;
  error: string | null;
}

// Priority examples:
// 1 (Critical): Trip completion, PoD, damage reports
// 2 (Normal): Expense logging, status updates
// 3 (Low): Preference changes, analytics events
```

---

## MQTT Integration

### Connection Management

```typescript
// services/mqtt/client.ts
import { Client } from 'paho-mqtt';

class MqttService {
  private client: Client;
  private isConnected: boolean = false;

  async connect(driverId: string, authToken: string) {
    const endpoint = Config.AWS_IOT_ENDPOINT;
    const clientId = `raahi-${driverId}-${Date.now()}`;

    this.client = new Client(endpoint, clientId);

    this.client.onConnectionLost = this.handleDisconnect;
    this.client.onMessageArrived = this.handleMessage;

    await this.client.connect({
      useSSL: true,
      timeout: 10,
      mqttVersion: 4,
      userName: 'unused',  // Cognito handles auth
      password: authToken,
    });

    this.subscribeToTopics(driverId);
  }

  private subscribeToTopics(driverId: string) {
    const topics = [
      `raahi/drivers/${driverId}/alerts`,
      `raahi/drivers/${driverId}/trips`,
      `raahi/drivers/${driverId}/chat`,
      `raahi/drivers/${driverId}/earnings`,
    ];

    topics.forEach(topic => {
      this.client.subscribe(topic, { qos: 1 });
    });
  }
}
```

### Message Handlers

```typescript
// services/mqtt/handlers.ts
const messageHandlers: Record<string, (payload: any) => void> = {
  'alerts': (payload) => {
    useAlertsStore.getState().addAlert(payload);
    showLocalNotification('Safety Alert', payload.message);
    playAlertSound(payload.severity);
  },

  'trips': (payload) => {
    if (payload.type === 'assignment') {
      useTripStore.getState().setActiveTrip(payload.trip);
      showLocalNotification('New Trip', payload.trip.summary);
    }
  },

  'earnings': (payload) => {
    useEarningsStore.getState().updateEarnings(payload);
  },

  'chat': (payload) => {
    useChatStore.getState().addMessage(payload);
  }
};
```

---

## API Integration Layer

### Axios Client Setup

```typescript
// services/api/client.ts
import axios from 'axios';
import { useAuthStore } from '@/stores/authStore';
import { addToSyncQueue } from '@/db/sync/queue';

const api = axios.create({
  baseURL: Config.API_BASE_URL,
  timeout: 30000,
});

// Request interceptor - add auth token
api.interceptors.request.use(async (config) => {
  const token = useAuthStore.getState().accessToken;
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Response interceptor - handle token refresh
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 401) {
      const refreshed = await refreshToken();
      if (refreshed) {
        return api.request(error.config);
      }
      // Logout user
      useAuthStore.getState().logout();
    }

    // Queue for offline retry if network error
    if (!error.response && error.config.method !== 'get') {
      await addToSyncQueue({
        operation: error.config.method.toUpperCase(),
        entity: extractEntity(error.config.url),
        payload: error.config.data,
        priority: 2,
      });
    }

    throw error;
  }
);

export default api;
```

### React Query Integration

```typescript
// hooks/useTrip.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { tripApi } from '@/services/api/trips';
import { useTripStore } from '@/stores/tripStore';

export function useActiveTrip() {
  const { activeTrip, setActiveTrip } = useTripStore();

  return useQuery({
    queryKey: ['activeTrip'],
    queryFn: tripApi.getActiveTrip,
    staleTime: 30000,  // 30 seconds
    initialData: activeTrip,
    onSuccess: (data) => {
      if (data) setActiveTrip(data);
    },
  });
}

export function useCompleteTrip() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: tripApi.completeTrip,
    onSuccess: () => {
      queryClient.invalidateQueries(['activeTrip']);
      queryClient.invalidateQueries(['tripHistory']);
      queryClient.invalidateQueries(['earnings']);
    },
  });
}
```

---

## Navigation Structure

```typescript
// app/_layout.tsx
import { Stack } from 'expo-router';

export default function RootLayout() {
  const { isAuthenticated } = useAuth();

  return (
    <Stack screenOptions={{ headerShown: false }}>
      {!isAuthenticated ? (
        <Stack.Screen name="(auth)" />
      ) : (
        <Stack.Screen name="(main)" />
      )}
      <Stack.Screen
        name="(modals)"
        options={{ presentation: 'modal' }}
      />
    </Stack>
  );
}

// app/(main)/_layout.tsx
import { Tabs } from 'expo-router';

export default function MainLayout() {
  return (
    <Tabs>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Home',
          tabBarIcon: HomeIcon
        }}
      />
      <Tabs.Screen
        name="ai-chat"
        options={{
          title: 'Copilot',
          tabBarIcon: ChatIcon
        }}
      />
      <Tabs.Screen
        name="earnings"
        options={{
          title: 'Earnings',
          tabBarIcon: WalletIcon
        }}
      />
      <Tabs.Screen
        name="documents"
        options={{
          title: 'Documents',
          tabBarIcon: FolderIcon
        }}
      />
      <Tabs.Screen
        name="settings"
        options={{
          title: 'Settings',
          tabBarIcon: SettingsIcon
        }}
      />
    </Tabs>
  );
}
```

---

## Security Considerations

### Token Storage

```typescript
// Secure storage for sensitive data
import * as SecureStore from 'expo-secure-store';

const TOKEN_KEY = 'auth_tokens';

export async function storeTokens(tokens: AuthTokens) {
  await SecureStore.setItemAsync(
    TOKEN_KEY,
    JSON.stringify(tokens),
    { keychainAccessible: SecureStore.WHEN_UNLOCKED }
  );
}
```

### Data Encryption

- SQLite database encrypted at rest (SQLCipher)
- All API calls over HTTPS
- MQTT over TLS
- No sensitive data in logs
- Biometric lock option for app access

### Permissions

| Permission | Purpose | When Requested |
|------------|---------|----------------|
| Location (always) | Trip tracking, geofencing | First trip |
| Camera | Document scanning, photos | First use |
| Microphone | Voice commands | First use |
| Notifications | Alerts, reminders | Onboarding |
| Storage | Offline photos | First use |

---

## Performance Targets

| Metric | Target |
|--------|--------|
| App launch | < 2 seconds |
| Screen transition | < 300ms |
| API response display | < 500ms |
| Offline data access | < 100ms |
| Frame rate | 60 fps |
| Memory usage | < 150 MB |
| Battery impact | < 5% per hour (background) |

---

## Related Documents

- [API Contracts](./02_api_contracts.md)
- [SQLite Schema](./03_sqlite_schema.sql)
- [MQTT Topics](./04_mqtt_topics.md)
- [Screen Specifications](./05_screen_specifications.md)
- [Offline Sync Strategy](./06_offline_sync_strategy.md)
- [Notification Strategy](./07_notification_strategy.md)
- [Implementation Roadmap](./08_implementation_roadmap.md)

---

**Last Updated:** January 2025
