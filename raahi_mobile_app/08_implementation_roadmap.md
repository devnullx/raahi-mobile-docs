# Raahi Mobile App - Implementation Roadmap & Project Plan

**Version:** 1.0
**Date:** January 2025
**Duration:** 16 Weeks (4 Sprints × 4 Weeks)
**Team Size:** 5-6 Engineers

---

## Executive Summary

| Metric | Value |
|--------|-------|
| **Total Duration** | 16 weeks |
| **Team Size** | 5-6 people |
| **Estimated Cost** | ₹18-22 Lakhs |
| **Deliverable** | Production-ready React Native app (iOS + Android) |

---

## Team Structure

```
┌─────────────────────────────────────────────────────────────────┐
│                    RAAHI MOBILE TEAM                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  👨‍💼 PRODUCT/PROJECT MANAGER (0.5 FTE)                          │
│     • Sprint planning, stakeholder sync                        │
│     • Can be shared with backend team                          │
│                                                                 │
│  👨‍💻 TECH LEAD / SENIOR RN DEVELOPER (1 FTE)                    │
│     • Architecture decisions                                   │
│     • Code reviews                                              │
│     • Complex features (MQTT, offline sync)                    │
│     • ₹1.2-1.5L/month                                          │
│                                                                 │
│  👨‍💻 MID-LEVEL RN DEVELOPERS (2 FTE)                            │
│     • Feature development                                      │
│     • UI implementation                                        │
│     • API integration                                          │
│     • ₹60-80K/month each                                       │
│                                                                 │
│  👨‍💻 JUNIOR RN DEVELOPER (1 FTE)                                │
│     • UI components                                            │
│     • Bug fixes                                                 │
│     • Testing                                                  │
│     • ₹35-50K/month                                            │
│                                                                 │
│  🎨 UI/UX DESIGNER (0.5 FTE)                                   │
│     • Screen designs                                           │
│     • Design system                                            │
│     • Can be shared/contract                                   │
│     • ₹50-70K/month                                            │
│                                                                 │
│  🧪 QA ENGINEER (0.5 FTE)                                      │
│     • Test cases                                               │
│     • Device testing                                           │
│     • Can be shared                                            │
│     • ₹40-50K/month                                            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

TOTAL: 5-6 FTE (with some shared roles)
MONTHLY BURN: ₹4-5.5L/month
```

---

## Gantt Chart (Visual Timeline)

```
WEEK    1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16
        ─────────────────────────────────────────────────────────────
        │ SPRINT 1    │ SPRINT 2    │ SPRINT 3    │ SPRINT 4    │
        │ Foundation  │ Core Trip   │ Features    │ Polish      │
        ─────────────────────────────────────────────────────────────

SETUP & AUTH
████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
W1-2: Project setup, Auth flow

NAVIGATION & SHELL
    ████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    W2-4: Navigation, Dashboard shell

SQLITE & OFFLINE
        ████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        W3-5: SQLite schema, offline architecture

TRIP LIFECYCLE
            ████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
            W4-7: Trip assignment, loading, active trip, completion

MQTT INTEGRATION
                    ████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
                    W6-8: MQTT client, alerts, real-time updates

EARNINGS & EXPENSES
                            ████████████░░░░░░░░░░░░░░░░░░░░░░░░
                            W8-10: Earnings screens, expense logging

DOCUMENTS
                                    ████████░░░░░░░░░░░░░░░░░░░░
                                    W10-11: Document wallet, DigiLocker

AI COPILOT
                                        ████████████░░░░░░░░░░░░
                                        W11-13: Chat interface, voice

NOTIFICATIONS
                                                ████████░░░░░░░░
                                                W13-14: FCM, deep links

TESTING & POLISH
                                                    ████████████
                                                    W14-16: Bug fixes, optimization

DEPLOYMENT
                                                            ████
                                                            W16: Store submission
```

---

## Detailed Task Breakdown (Spreadsheet Format)

### SPRINT 1: Foundation (Weeks 1-4)

| ID | Task | Subtasks | Owner | Start | End | Days | Status |
|----|------|----------|-------|-------|-----|------|--------|
| **1.0** | **Project Setup** | | Tech Lead | W1D1 | W1D3 | 3 | |
| 1.1 | Initialize React Native project | Expo setup, TypeScript config | Tech Lead | W1D1 | W1D1 | 1 | |
| 1.2 | Setup folder structure | As per architecture doc | Tech Lead | W1D2 | W1D2 | 1 | |
| 1.3 | Configure ESLint, Prettier | Code quality tools | Tech Lead | W1D2 | W1D2 | 0.5 | |
| 1.4 | Setup CI/CD pipeline | GitHub Actions, EAS Build | Tech Lead | W1D3 | W1D3 | 1 | |
| 1.5 | Configure environment variables | Dev, staging, prod | Tech Lead | W1D3 | W1D3 | 0.5 | |
| **2.0** | **Design System** | | Designer | W1D1 | W1D5 | 5 | |
| 2.1 | Color palette & typography | Brand colors, fonts | Designer | W1D1 | W1D2 | 2 | |
| 2.2 | Base components design | Button, Input, Card specs | Designer | W1D2 | W1D4 | 2 | |
| 2.3 | Icon set selection | Consistent icon library | Designer | W1D4 | W1D5 | 1 | |
| **3.0** | **Base UI Components** | | Mid Dev 1 | W1D2 | W2D3 | 7 | |
| 3.1 | Button component | Primary, secondary, disabled | Mid Dev 1 | W1D2 | W1D3 | 1 | |
| 3.2 | Input component | Text, phone, OTP | Mid Dev 1 | W1D3 | W1D4 | 1 | |
| 3.3 | Card component | Basic card, trip card | Mid Dev 1 | W1D4 | W1D5 | 1 | |
| 3.4 | Modal component | Bottom sheet, alert | Mid Dev 1 | W2D1 | W2D2 | 1 | |
| 3.5 | Toast/Snackbar | Success, error, info | Mid Dev 1 | W2D2 | W2D3 | 1 | |
| **4.0** | **Authentication Flow** | | Mid Dev 2 | W1D3 | W2D5 | 8 | |
| 4.1 | Cognito SDK setup | AWS Amplify Auth config | Mid Dev 2 | W1D3 | W1D4 | 1 | |
| 4.2 | Login screen UI | Phone input, validation | Mid Dev 2 | W1D4 | W1D5 | 1 | |
| 4.3 | OTP screen UI | 6-digit input, timer | Mid Dev 2 | W2D1 | W2D2 | 1 | |
| 4.4 | OTP request API | Request OTP endpoint | Mid Dev 2 | W2D2 | W2D3 | 1 | |
| 4.5 | OTP verify API | Verify + get tokens | Mid Dev 2 | W2D3 | W2D4 | 1 | |
| 4.6 | Token storage | SecureStore implementation | Mid Dev 2 | W2D4 | W2D4 | 0.5 | |
| 4.7 | Token refresh logic | Auto-refresh interceptor | Mid Dev 2 | W2D4 | W2D5 | 1 | |
| 4.8 | Auth state management | Zustand auth store | Mid Dev 2 | W2D5 | W2D5 | 0.5 | |
| **5.0** | **Navigation Setup** | | Tech Lead | W2D1 | W2D5 | 5 | |
| 5.1 | Install React Navigation | Expo Router setup | Tech Lead | W2D1 | W2D1 | 0.5 | |
| 5.2 | Auth flow navigation | Login → OTP → Main | Tech Lead | W2D1 | W2D2 | 1 | |
| 5.3 | Main tab navigator | 5 tabs with icons | Tech Lead | W2D2 | W2D3 | 1 | |
| 5.4 | Stack navigators | Trip flow, settings | Tech Lead | W2D3 | W2D4 | 1 | |
| 5.5 | Deep linking setup | URL scheme config | Tech Lead | W2D4 | W2D5 | 1 | |
| **6.0** | **SQLite Setup** | | Tech Lead | W3D1 | W3D5 | 5 | |
| 6.1 | Install expo-sqlite | Database setup | Tech Lead | W3D1 | W3D1 | 0.5 | |
| 6.2 | Create schema | All tables from spec | Tech Lead | W3D1 | W3D2 | 1.5 | |
| 6.3 | Migration system | Version tracking | Tech Lead | W3D2 | W3D3 | 1 | |
| 6.4 | Query helpers | CRUD operations | Tech Lead | W3D3 | W3D4 | 1 | |
| 6.5 | Sync queue table | Offline sync foundation | Tech Lead | W3D4 | W3D5 | 1 | |
| **7.0** | **Dashboard Screen** | | Mid Dev 1 | W3D1 | W4D3 | 8 | |
| 7.1 | Dashboard layout | Header, sections | Mid Dev 1 | W3D1 | W3D2 | 1 | |
| 7.2 | Shift card | Clock in/out, hours | Mid Dev 1 | W3D2 | W3D3 | 1 | |
| 7.3 | Active trip card | Status, progress | Mid Dev 1 | W3D3 | W3D4 | 1 | |
| 7.4 | Earnings summary card | Today's earnings | Mid Dev 1 | W3D4 | W3D5 | 1 | |
| 7.5 | Pending tasks card | Actionable items | Mid Dev 1 | W4D1 | W4D2 | 1 | |
| 7.6 | Pull to refresh | Data refresh logic | Mid Dev 1 | W4D2 | W4D3 | 1 | |
| **8.0** | **API Client Setup** | | Mid Dev 2 | W3D1 | W3D5 | 5 | |
| 8.1 | Axios instance | Base URL, headers | Mid Dev 2 | W3D1 | W3D1 | 0.5 | |
| 8.2 | Auth interceptor | Token injection | Mid Dev 2 | W3D1 | W3D2 | 0.5 | |
| 8.3 | Error interceptor | 401 handling | Mid Dev 2 | W3D2 | W3D3 | 1 | |
| 8.4 | React Query setup | Caching, refetch | Mid Dev 2 | W3D3 | W3D4 | 1 | |
| 8.5 | Offline queue integration | Failed request queue | Mid Dev 2 | W3D4 | W3D5 | 1 | |
| **9.0** | **Driver Profile** | | Junior Dev | W3D3 | W4D5 | 8 | |
| 9.1 | Profile API integration | GET /drivers/me | Junior Dev | W3D3 | W3D4 | 1 | |
| 9.2 | Profile store | Zustand driver store | Junior Dev | W3D4 | W3D5 | 1 | |
| 9.3 | Clock in API | POST clock-in | Junior Dev | W4D1 | W4D2 | 1 | |
| 9.4 | Clock out API | POST clock-out | Junior Dev | W4D2 | W4D3 | 1 | |
| 9.5 | Settings screen UI | Basic preferences | Junior Dev | W4D3 | W4D5 | 2 | |

**Sprint 1 Deliverables:**
- ✅ Working auth flow (login, OTP, logout)
- ✅ Dashboard with cached data
- ✅ Clock in/out functionality
- ✅ SQLite database operational
- ✅ Offline-capable architecture

---

### SPRINT 2: Core Trip Flow (Weeks 5-8)

| ID | Task | Subtasks | Owner | Start | End | Days | Status |
|----|------|----------|-------|-------|-----|------|--------|
| **10.0** | **Trip Assignment** | | Mid Dev 1 | W5D1 | W5D5 | 5 | |
| 10.1 | Assignment screen UI | Trip details, accept/decline | Mid Dev 1 | W5D1 | W5D2 | 2 | |
| 10.2 | Accept trip API | POST /trips/{id}/accept | Mid Dev 1 | W5D2 | W5D3 | 1 | |
| 10.3 | Trip store setup | Active trip state | Mid Dev 1 | W5D3 | W5D4 | 1 | |
| 10.4 | Assignment notification | Push notification handling | Mid Dev 1 | W5D4 | W5D5 | 1 | |
| **11.0** | **Loading Process** | | Mid Dev 2 | W5D1 | W6D3 | 8 | |
| 11.1 | Loading screen UI | Progress, checklist | Mid Dev 2 | W5D1 | W5D3 | 2 | |
| 11.2 | Start loading API | POST /trips/{id}/loading/start | Mid Dev 2 | W5D3 | W5D4 | 1 | |
| 11.3 | Update count API | PATCH loading progress | Mid Dev 2 | W5D4 | W5D5 | 1 | |
| 11.4 | Photo capture modal | Camera integration | Mid Dev 2 | W6D1 | W6D2 | 1 | |
| 11.5 | Complete loading API | Documents, signature | Mid Dev 2 | W6D2 | W6D3 | 1 | |
| **12.0** | **Document Capture** | | Junior Dev | W5D3 | W6D5 | 8 | |
| 12.1 | Camera component | Photo capture | Junior Dev | W5D3 | W5D5 | 2 | |
| 12.2 | E-way bill scanner | OCR integration | Junior Dev | W6D1 | W6D3 | 2 | |
| 12.3 | Signature pad | Touch signature | Junior Dev | W6D3 | W6D5 | 2 | |
| 12.4 | Local file storage | Save photos locally | Junior Dev | W6D5 | W6D5 | 1 | |
| **13.0** | **Active Trip Screen** | | Tech Lead | W6D1 | W7D3 | 8 | |
| 13.1 | Map integration | react-native-maps | Tech Lead | W6D1 | W6D3 | 2 | |
| 13.2 | Trip progress UI | Distance, ETA, status | Tech Lead | W6D3 | W6D5 | 2 | |
| 13.3 | Quick actions menu | Break, issue, expense | Tech Lead | W7D1 | W7D2 | 1 | |
| 13.4 | Location tracking | Background GPS | Tech Lead | W7D2 | W7D3 | 1 | |
| **14.0** | **MQTT Client** | | Tech Lead | W6D3 | W7D5 | 8 | |
| 14.1 | MQTT library setup | Paho/MQTT.js | Tech Lead | W6D3 | W6D4 | 1 | |
| 14.2 | Connection management | Connect, reconnect | Tech Lead | W6D4 | W6D5 | 1 | |
| 14.3 | Topic subscriptions | All driver topics | Tech Lead | W7D1 | W7D2 | 1 | |
| 14.4 | Alert handler | Store, notify | Tech Lead | W7D2 | W7D3 | 1 | |
| 14.5 | Trip update handler | Real-time updates | Tech Lead | W7D3 | W7D4 | 1 | |
| 14.6 | Earnings handler | Live earnings | Tech Lead | W7D4 | W7D5 | 1 | |
| **15.0** | **Issue Reporting** | | Mid Dev 1 | W7D1 | W7D5 | 5 | |
| 15.1 | Issue report modal | Type selection, photo | Mid Dev 1 | W7D1 | W7D3 | 2 | |
| 15.2 | Issue API | POST /trips/{id}/issues | Mid Dev 1 | W7D3 | W7D4 | 1 | |
| 15.3 | Offline queue | Store issue locally | Mid Dev 1 | W7D4 | W7D5 | 1 | |
| **16.0** | **Unloading & PoD** | | Mid Dev 2 | W7D3 | W8D5 | 8 | |
| 16.1 | Unloading screen UI | Checklist, count | Mid Dev 2 | W7D3 | W7D5 | 2 | |
| 16.2 | Damage report modal | Multi-photo, type | Mid Dev 2 | W8D1 | W8D2 | 2 | |
| 16.3 | PoD capture | Photos, signature | Mid Dev 2 | W8D2 | W8D4 | 2 | |
| 16.4 | Complete trip API | POST /trips/{id}/complete | Mid Dev 2 | W8D4 | W8D5 | 1 | |
| **17.0** | **Alerts Screen** | | Junior Dev | W7D1 | W8D3 | 8 | |
| 17.1 | Alerts list UI | Severity, timeline | Junior Dev | W7D1 | W7D3 | 2 | |
| 17.2 | Alert detail view | Evidence, video | Junior Dev | W7D3 | W7D5 | 2 | |
| 17.3 | Acknowledge API | Action taken | Junior Dev | W8D1 | W8D2 | 1 | |
| 17.4 | Alert notification | Full screen critical | Junior Dev | W8D2 | W8D3 | 1 | |

**Sprint 2 Deliverables:**
- ✅ Complete trip lifecycle (assign → load → drive → unload → complete)
- ✅ Real-time MQTT alerts
- ✅ Document capture (photos, signatures, e-way bill)
- ✅ Issue reporting
- ✅ PoD capture

---

### SPRINT 3: Features (Weeks 9-12)

| ID | Task | Subtasks | Owner | Start | End | Days | Status |
|----|------|----------|-------|-------|-----|------|--------|
| **18.0** | **Earnings Module** | | Mid Dev 1 | W9D1 | W10D3 | 8 | |
| 18.1 | Earnings screen UI | Summary, breakdown | Mid Dev 1 | W9D1 | W9D3 | 2 | |
| 18.2 | Period selector | Today, week, month | Mid Dev 1 | W9D3 | W9D4 | 1 | |
| 18.3 | Earnings API | GET /earnings/summary | Mid Dev 1 | W9D4 | W9D5 | 1 | |
| 18.4 | History list | Daily breakdown | Mid Dev 1 | W10D1 | W10D2 | 1 | |
| 18.5 | Dispute flow | Create dispute UI | Mid Dev 1 | W10D2 | W10D3 | 1 | |
| **19.0** | **Expenses Module** | | Mid Dev 2 | W9D1 | W10D3 | 8 | |
| 19.1 | Expense entry modal | Type, amount, photo | Mid Dev 2 | W9D1 | W9D3 | 2 | |
| 19.2 | Expense list screen | Filter, status | Mid Dev 2 | W9D3 | W9D5 | 2 | |
| 19.3 | Create expense API | POST /expenses | Mid Dev 2 | W10D1 | W10D2 | 1 | |
| 19.4 | Offline expense queue | Store locally | Mid Dev 2 | W10D2 | W10D3 | 1 | |
| **20.0** | **Documents Module** | | Junior Dev | W9D3 | W11D3 | 8 | |
| 20.1 | Documents list UI | Verified, pending | Junior Dev | W9D3 | W9D5 | 2 | |
| 20.2 | Document upload | Camera, gallery | Junior Dev | W10D1 | W10D3 | 2 | |
| 20.3 | DigiLocker OAuth | Auth flow | Junior Dev | W10D3 | W11D1 | 2 | |
| 20.4 | DigiLocker fetch | Get documents | Junior Dev | W11D1 | W11D3 | 2 | |
| **21.0** | **AI Copilot** | | Tech Lead | W10D3 | W12D3 | 8 | |
| 21.1 | Chat UI | Message bubbles | Tech Lead | W10D3 | W11D1 | 2 | |
| 21.2 | Chat API | POST /chat/message | Tech Lead | W11D1 | W11D3 | 2 | |
| 21.3 | Quick action chips | Food, fuel, rest | Tech Lead | W11D3 | W11D5 | 2 | |
| 21.4 | Voice input | Speech-to-text | Tech Lead | W12D1 | W12D2 | 1 | |
| 21.5 | Voice output | Text-to-speech | Tech Lead | W12D2 | W12D3 | 1 | |
| **22.0** | **Offline Sync** | | Tech Lead | W11D1 | W12D5 | 8 | |
| 22.1 | Sync queue processor | Background sync | Tech Lead | W11D1 | W11D3 | 2 | |
| 22.2 | Conflict resolution | Server wins logic | Tech Lead | W11D3 | W11D5 | 2 | |
| 22.3 | Photo upload queue | S3 presigned URLs | Tech Lead | W12D1 | W12D3 | 2 | |
| 22.4 | Sync status UI | Pending indicator | Tech Lead | W12D3 | W12D5 | 2 | |
| **23.0** | **Trip History** | | Mid Dev 1 | W11D1 | W11D5 | 5 | |
| 23.1 | History list UI | Past trips | Mid Dev 1 | W11D1 | W11D3 | 2 | |
| 23.2 | Trip detail view | Full trip data | Mid Dev 1 | W11D3 | W11D5 | 2 | |
| **24.0** | **Notifications** | | Mid Dev 2 | W11D3 | W12D5 | 8 | |
| 24.1 | FCM setup | Android + iOS | Mid Dev 2 | W11D3 | W12D1 | 2 | |
| 24.2 | Notification handlers | Foreground, background | Mid Dev 2 | W12D1 | W12D3 | 2 | |
| 24.3 | Deep linking | Navigate on tap | Mid Dev 2 | W12D3 | W12D4 | 1 | |
| 24.4 | Local notifications | Break reminders | Mid Dev 2 | W12D4 | W12D5 | 1 | |

**Sprint 3 Deliverables:**
- ✅ Earnings with disputes
- ✅ Expense logging (offline-capable)
- ✅ Document wallet + DigiLocker
- ✅ AI Copilot with voice
- ✅ Push notifications
- ✅ Full offline sync

---

### SPRINT 4: Polish & Launch (Weeks 13-16)

| ID | Task | Subtasks | Owner | Start | End | Days | Status |
|----|------|----------|-------|-------|-----|------|--------|
| **25.0** | **Testing** | | QA + All | W13D1 | W14D5 | 10 | |
| 25.1 | Unit tests | Core functions | All Devs | W13D1 | W13D5 | 5 | |
| 25.2 | Integration tests | API flows | QA | W13D1 | W13D5 | 5 | |
| 25.3 | Device testing | 10+ devices | QA | W14D1 | W14D5 | 5 | |
| 25.4 | Offline testing | Network scenarios | QA | W14D1 | W14D3 | 3 | |
| 25.5 | Performance testing | Memory, CPU | Tech Lead | W14D3 | W14D5 | 2 | |
| **26.0** | **Bug Fixes** | | All Devs | W14D1 | W15D5 | 10 | |
| 26.1 | Critical bugs | P0 issues | All Devs | W14D1 | W14D5 | 5 | |
| 26.2 | Major bugs | P1 issues | All Devs | W15D1 | W15D3 | 3 | |
| 26.3 | Minor bugs | P2 issues | Junior Dev | W15D3 | W15D5 | 2 | |
| **27.0** | **Optimization** | | Tech Lead | W15D1 | W15D5 | 5 | |
| 27.1 | Bundle size | Code splitting | Tech Lead | W15D1 | W15D2 | 2 | |
| 27.2 | Startup time | Lazy loading | Tech Lead | W15D2 | W15D3 | 1 | |
| 27.3 | Memory leaks | Profiling | Tech Lead | W15D3 | W15D4 | 1 | |
| 27.4 | Battery usage | Background tasks | Tech Lead | W15D4 | W15D5 | 1 | |
| **28.0** | **i18n** | | Mid Dev 1 | W13D1 | W14D3 | 8 | |
| 28.1 | i18n setup | react-i18next | Mid Dev 1 | W13D1 | W13D2 | 1 | |
| 28.2 | English strings | Extract all text | Mid Dev 1 | W13D2 | W13D3 | 1 | |
| 28.3 | Hindi translation | Professional translation | Mid Dev 1 | W13D3 | W14D1 | 3 | |
| 28.4 | Regional languages | Tamil, Telugu, Marathi | Mid Dev 1 | W14D1 | W14D3 | 2 | |
| **29.0** | **App Store Prep** | | Tech Lead | W15D3 | W16D3 | 5 | |
| 29.1 | App icons | All sizes | Designer | W15D3 | W15D4 | 1 | |
| 29.2 | Splash screens | All sizes | Designer | W15D4 | W15D5 | 1 | |
| 29.3 | Screenshots | Store listings | Designer | W16D1 | W16D2 | 1 | |
| 29.4 | Store descriptions | Copy writing | PM | W16D1 | W16D2 | 1 | |
| 29.5 | Privacy policy | Legal review | PM | W16D2 | W16D3 | 1 | |
| **30.0** | **Deployment** | | Tech Lead | W16D3 | W16D5 | 3 | |
| 30.1 | Android build | EAS production build | Tech Lead | W16D3 | W16D4 | 1 | |
| 30.2 | iOS build | EAS production build | Tech Lead | W16D3 | W16D4 | 1 | |
| 30.3 | Play Store submit | Internal testing | Tech Lead | W16D4 | W16D5 | 1 | |
| 30.4 | App Store submit | TestFlight | Tech Lead | W16D4 | W16D5 | 1 | |

**Sprint 4 Deliverables:**
- ✅ All bugs fixed
- ✅ Performance optimized
- ✅ Multi-language support
- ✅ App Store & Play Store submission
- ✅ Production-ready app

---

## Budget Breakdown

| Role | Monthly Rate | Months | Total |
|------|-------------|--------|-------|
| Tech Lead | ₹1,30,000 | 4 | ₹5,20,000 |
| Mid Dev 1 | ₹70,000 | 4 | ₹2,80,000 |
| Mid Dev 2 | ₹70,000 | 4 | ₹2,80,000 |
| Junior Dev | ₹45,000 | 4 | ₹1,80,000 |
| Designer (0.5) | ₹30,000 | 4 | ₹1,20,000 |
| QA (0.5) | ₹22,500 | 4 | ₹90,000 |
| PM (0.5) | ₹35,000 | 4 | ₹1,40,000 |
| **Subtotal** | | | **₹16,10,000** |
| Contingency (15%) | | | ₹2,41,500 |
| **Total** | | | **₹18,51,500** |

---

## Risk Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| Backend API delays | High | Mock APIs, parallel development |
| Device fragmentation | Medium | Early device testing, Firebase Test Lab |
| DigiLocker integration issues | Medium | Fallback to manual upload |
| MQTT complexity | Medium | Tech Lead owns, library fallbacks |
| Store rejection | Low | Follow guidelines, pre-review |

---

## Success Metrics

| Metric | Target |
|--------|--------|
| App crash rate | < 0.5% |
| Startup time | < 2 seconds |
| Offline operation | 100% of core features |
| User rating | > 4.0 stars |
| Daily active usage | > 80% of drivers |

---

**Last Updated:** January 2025
