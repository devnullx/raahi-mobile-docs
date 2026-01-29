# Raahi Mobile App - Project Task Sheet

**Export this to Google Sheets/Excel for tracking**

---

## Team Allocation

| Code | Role | Name | Rate/Month |
|------|------|------|------------|
| TL | Tech Lead | ___________ | ₹1,30,000 |
| M1 | Mid Dev 1 | ___________ | ₹70,000 |
| M2 | Mid Dev 2 | ___________ | ₹70,000 |
| JR | Junior Dev | ___________ | ₹45,000 |
| DS | Designer | ___________ | ₹60,000 (0.5) |
| QA | QA Engineer | ___________ | ₹45,000 (0.5) |
| PM | Project Manager | ___________ | ₹70,000 (0.5) |

---

## Master Task List

```
ID          | TASK                                    | OWNER | START    | END      | DAYS | STATUS
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
            │                                         │       │          │          │      │
═══════════ │ SPRINT 1: FOUNDATION (W1-W4)            │       │ Week 1   │ Week 4   │ 20   │
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
1.0         │ PROJECT SETUP                           │ TL    │ W1D1     │ W1D3     │ 3    │ ☐
  1.1       │   Initialize RN project (Expo)          │ TL    │ W1D1     │ W1D1     │ 1    │ ☐
  1.2       │   Folder structure setup                │ TL    │ W1D2     │ W1D2     │ 1    │ ☐
  1.3       │   ESLint + Prettier config              │ TL    │ W1D2     │ W1D2     │ 0.5  │ ☐
  1.4       │   CI/CD pipeline (GitHub Actions)       │ TL    │ W1D3     │ W1D3     │ 1    │ ☐
  1.5       │   Environment variables                 │ TL    │ W1D3     │ W1D3     │ 0.5  │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
2.0         │ DESIGN SYSTEM                           │ DS    │ W1D1     │ W1D5     │ 5    │ ☐
  2.1       │   Color palette & typography            │ DS    │ W1D1     │ W1D2     │ 2    │ ☐
  2.2       │   Base component specs                  │ DS    │ W1D2     │ W1D4     │ 2    │ ☐
  2.3       │   Icon library selection                │ DS    │ W1D4     │ W1D5     │ 1    │ ☐
  2.4       │   Screen wireframes (12 screens)        │ DS    │ W2D1     │ W3D5     │ 10   │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
3.0         │ BASE UI COMPONENTS                      │ M1    │ W1D2     │ W2D3     │ 7    │ ☐
  3.1       │   Button (primary, secondary, ghost)    │ M1    │ W1D2     │ W1D3     │ 1    │ ☐
  3.2       │   Input (text, phone, OTP)              │ M1    │ W1D3     │ W1D4     │ 1    │ ☐
  3.3       │   Card (base, trip, earnings)           │ M1    │ W1D4     │ W1D5     │ 1    │ ☐
  3.4       │   Modal (bottom sheet, alert)           │ M1    │ W2D1     │ W2D2     │ 1    │ ☐
  3.5       │   Toast/Snackbar                        │ M1    │ W2D2     │ W2D3     │ 1    │ ☐
  3.6       │   Loading/Skeleton                      │ M1    │ W2D3     │ W2D3     │ 0.5  │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
4.0         │ AUTHENTICATION FLOW                     │ M2    │ W1D3     │ W2D5     │ 8    │ ☐
  4.1       │   AWS Amplify Auth setup                │ M2    │ W1D3     │ W1D4     │ 1    │ ☐
  4.2       │   Login screen UI                       │ M2    │ W1D4     │ W1D5     │ 1    │ ☐
  4.3       │   OTP screen UI                         │ M2    │ W2D1     │ W2D2     │ 1    │ ☐
  4.4       │   Request OTP API integration           │ M2    │ W2D2     │ W2D3     │ 1    │ ☐
  4.5       │   Verify OTP API integration            │ M2    │ W2D3     │ W2D4     │ 1    │ ☐
  4.6       │   Secure token storage                  │ M2    │ W2D4     │ W2D4     │ 0.5  │ ☐
  4.7       │   Token refresh interceptor             │ M2    │ W2D4     │ W2D5     │ 1    │ ☐
  4.8       │   Auth Zustand store                    │ M2    │ W2D5     │ W2D5     │ 0.5  │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
5.0         │ NAVIGATION SETUP                        │ TL    │ W2D1     │ W2D5     │ 5    │ ☐
  5.1       │   Expo Router installation              │ TL    │ W2D1     │ W2D1     │ 0.5  │ ☐
  5.2       │   Auth flow navigation                  │ TL    │ W2D1     │ W2D2     │ 1    │ ☐
  5.3       │   Main tab navigator (5 tabs)           │ TL    │ W2D2     │ W2D3     │ 1    │ ☐
  5.4       │   Stack navigators (trip, settings)     │ TL    │ W2D3     │ W2D4     │ 1    │ ☐
  5.5       │   Deep linking configuration            │ TL    │ W2D4     │ W2D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
6.0         │ SQLITE DATABASE                         │ TL    │ W3D1     │ W3D5     │ 5    │ ☐
  6.1       │   expo-sqlite installation              │ TL    │ W3D1     │ W3D1     │ 0.5  │ ☐
  6.2       │   Schema creation (all tables)          │ TL    │ W3D1     │ W3D2     │ 1.5  │ ☐
  6.3       │   Migration system                      │ TL    │ W3D2     │ W3D3     │ 1    │ ☐
  6.4       │   Query helper functions                │ TL    │ W3D3     │ W3D4     │ 1    │ ☐
  6.5       │   Sync queue table                      │ TL    │ W3D4     │ W3D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
7.0         │ DASHBOARD SCREEN                        │ M1    │ W3D1     │ W4D3     │ 8    │ ☐
  7.1       │   Dashboard layout                      │ M1    │ W3D1     │ W3D2     │ 1    │ ☐
  7.2       │   Shift card (clock in/out)             │ M1    │ W3D2     │ W3D3     │ 1    │ ☐
  7.3       │   Active trip card                      │ M1    │ W3D3     │ W3D4     │ 1    │ ☐
  7.4       │   Earnings summary card                 │ M1    │ W3D4     │ W3D5     │ 1    │ ☐
  7.5       │   Pending tasks card                    │ M1    │ W4D1     │ W4D2     │ 1    │ ☐
  7.6       │   Pull to refresh                       │ M1    │ W4D2     │ W4D3     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
8.0         │ API CLIENT SETUP                        │ M2    │ W3D1     │ W3D5     │ 5    │ ☐
  8.1       │   Axios instance config                 │ M2    │ W3D1     │ W3D1     │ 0.5  │ ☐
  8.2       │   Auth interceptor                      │ M2    │ W3D1     │ W3D2     │ 0.5  │ ☐
  8.3       │   Error interceptor (401 handling)      │ M2    │ W3D2     │ W3D3     │ 1    │ ☐
  8.4       │   React Query setup                     │ M2    │ W3D3     │ W3D4     │ 1    │ ☐
  8.5       │   Offline queue integration             │ M2    │ W3D4     │ W3D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
9.0         │ DRIVER PROFILE                          │ JR    │ W3D3     │ W4D5     │ 8    │ ☐
  9.1       │   Profile API integration               │ JR    │ W3D3     │ W3D4     │ 1    │ ☐
  9.2       │   Driver Zustand store                  │ JR    │ W3D4     │ W3D5     │ 1    │ ☐
  9.3       │   Clock in API                          │ JR    │ W4D1     │ W4D2     │ 1    │ ☐
  9.4       │   Clock out API                         │ JR    │ W4D2     │ W4D3     │ 1    │ ☐
  9.5       │   Settings screen UI                    │ JR    │ W4D3     │ W4D5     │ 2    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
            │                                         │       │          │          │      │
═══════════ │ SPRINT 2: CORE TRIP (W5-W8)             │       │ Week 5   │ Week 8   │ 20   │
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
10.0        │ TRIP ASSIGNMENT                         │ M1    │ W5D1     │ W5D5     │ 5    │ ☐
  10.1      │   Assignment screen UI                  │ M1    │ W5D1     │ W5D2     │ 2    │ ☐
  10.2      │   Accept trip API                       │ M1    │ W5D2     │ W5D3     │ 1    │ ☐
  10.3      │   Trip Zustand store                    │ M1    │ W5D3     │ W5D4     │ 1    │ ☐
  10.4      │   Assignment push notification          │ M1    │ W5D4     │ W5D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
11.0        │ LOADING PROCESS                         │ M2    │ W5D1     │ W6D3     │ 8    │ ☐
  11.1      │   Loading screen UI                     │ M2    │ W5D1     │ W5D3     │ 2    │ ☐
  11.2      │   Start loading API                     │ M2    │ W5D3     │ W5D4     │ 1    │ ☐
  11.3      │   Update count API                      │ M2    │ W5D4     │ W5D5     │ 1    │ ☐
  11.4      │   Photo capture modal                   │ M2    │ W6D1     │ W6D2     │ 1    │ ☐
  11.5      │   Complete loading API                  │ M2    │ W6D2     │ W6D3     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
12.0        │ DOCUMENT CAPTURE                        │ JR    │ W5D3     │ W6D5     │ 8    │ ☐
  12.1      │   Camera component                      │ JR    │ W5D3     │ W5D5     │ 2    │ ☐
  12.2      │   E-way bill OCR scanner                │ JR    │ W6D1     │ W6D3     │ 2    │ ☐
  12.3      │   Signature pad component               │ JR    │ W6D3     │ W6D5     │ 2    │ ☐
  12.4      │   Local file storage                    │ JR    │ W6D5     │ W6D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
13.0        │ ACTIVE TRIP SCREEN                      │ TL    │ W6D1     │ W7D3     │ 8    │ ☐
  13.1      │   Map integration                       │ TL    │ W6D1     │ W6D3     │ 2    │ ☐
  13.2      │   Trip progress UI                      │ TL    │ W6D3     │ W6D5     │ 2    │ ☐
  13.3      │   Quick actions menu                    │ TL    │ W7D1     │ W7D2     │ 1    │ ☐
  13.4      │   Background location tracking          │ TL    │ W7D2     │ W7D3     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
14.0        │ MQTT CLIENT                             │ TL    │ W6D3     │ W7D5     │ 8    │ ☐
  14.1      │   MQTT library setup                    │ TL    │ W6D3     │ W6D4     │ 1    │ ☐
  14.2      │   Connection management                 │ TL    │ W6D4     │ W6D5     │ 1    │ ☐
  14.3      │   Topic subscriptions                   │ TL    │ W7D1     │ W7D2     │ 1    │ ☐
  14.4      │   Alert message handler                 │ TL    │ W7D2     │ W7D3     │ 1    │ ☐
  14.5      │   Trip update handler                   │ TL    │ W7D3     │ W7D4     │ 1    │ ☐
  14.6      │   Earnings update handler               │ TL    │ W7D4     │ W7D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
15.0        │ ISSUE REPORTING                         │ M1    │ W7D1     │ W7D5     │ 5    │ ☐
  15.1      │   Issue report modal                    │ M1    │ W7D1     │ W7D3     │ 2    │ ☐
  15.2      │   Issue API integration                 │ M1    │ W7D3     │ W7D4     │ 1    │ ☐
  15.3      │   Offline queue for issues              │ M1    │ W7D4     │ W7D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
16.0        │ UNLOADING & POD                         │ M2    │ W7D3     │ W8D5     │ 8    │ ☐
  16.1      │   Unloading screen UI                   │ M2    │ W7D3     │ W7D5     │ 2    │ ☐
  16.2      │   Damage report modal                   │ M2    │ W8D1     │ W8D2     │ 2    │ ☐
  16.3      │   PoD capture (photos + sig)            │ M2    │ W8D2     │ W8D4     │ 2    │ ☐
  16.4      │   Complete trip API                     │ M2    │ W8D4     │ W8D5     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
17.0        │ ALERTS SCREEN                           │ JR    │ W7D1     │ W8D3     │ 8    │ ☐
  17.1      │   Alerts list UI                        │ JR    │ W7D1     │ W7D3     │ 2    │ ☐
  17.2      │   Alert detail view                     │ JR    │ W7D3     │ W7D5     │ 2    │ ☐
  17.3      │   Acknowledge API                       │ JR    │ W8D1     │ W8D2     │ 1    │ ☐
  17.4      │   Critical alert full screen            │ JR    │ W8D2     │ W8D3     │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
            │                                         │       │          │          │      │
═══════════ │ SPRINT 3: FEATURES (W9-W12)             │       │ Week 9   │ Week 12  │ 20   │
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
18.0        │ EARNINGS MODULE                         │ M1    │ W9D1     │ W10D3    │ 8    │ ☐
  18.1      │   Earnings screen UI                    │ M1    │ W9D1     │ W9D3     │ 2    │ ☐
  18.2      │   Period selector (day/week/month)      │ M1    │ W9D3     │ W9D4     │ 1    │ ☐
  18.3      │   Earnings API integration              │ M1    │ W9D4     │ W9D5     │ 1    │ ☐
  18.4      │   Earnings history list                 │ M1    │ W10D1    │ W10D2    │ 1    │ ☐
  18.5      │   Dispute creation flow                 │ M1    │ W10D2    │ W10D3    │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
19.0        │ EXPENSES MODULE                         │ M2    │ W9D1     │ W10D3    │ 8    │ ☐
  19.1      │   Expense entry modal                   │ M2    │ W9D1     │ W9D3     │ 2    │ ☐
  19.2      │   Expense list screen                   │ M2    │ W9D3     │ W9D5     │ 2    │ ☐
  19.3      │   Create expense API                    │ M2    │ W10D1    │ W10D2    │ 1    │ ☐
  19.4      │   Offline expense queue                 │ M2    │ W10D2    │ W10D3    │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
20.0        │ DOCUMENTS MODULE                        │ JR    │ W9D3     │ W11D3    │ 8    │ ☐
  20.1      │   Documents list UI                     │ JR    │ W9D3     │ W9D5     │ 2    │ ☐
  20.2      │   Document upload flow                  │ JR    │ W10D1    │ W10D3    │ 2    │ ☐
  20.3      │   DigiLocker OAuth flow                 │ JR    │ W10D3    │ W11D1    │ 2    │ ☐
  20.4      │   DigiLocker document fetch             │ JR    │ W11D1    │ W11D3    │ 2    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
21.0        │ AI COPILOT                              │ TL    │ W10D3    │ W12D3    │ 8    │ ☐
  21.1      │   Chat UI (message bubbles)             │ TL    │ W10D3    │ W11D1    │ 2    │ ☐
  21.2      │   Chat API integration                  │ TL    │ W11D1    │ W11D3    │ 2    │ ☐
  21.3      │   Quick action chips                    │ TL    │ W11D3    │ W11D5    │ 2    │ ☐
  21.4      │   Voice input (STT)                     │ TL    │ W12D1    │ W12D2    │ 1    │ ☐
  21.5      │   Voice output (TTS)                    │ TL    │ W12D2    │ W12D3    │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
22.0        │ OFFLINE SYNC                            │ TL    │ W11D1    │ W12D5    │ 8    │ ☐
  22.1      │   Sync queue processor                  │ TL    │ W11D1    │ W11D3    │ 2    │ ☐
  22.2      │   Conflict resolution logic             │ TL    │ W11D3    │ W11D5    │ 2    │ ☐
  22.3      │   Photo upload queue (S3)               │ TL    │ W12D1    │ W12D3    │ 2    │ ☐
  22.4      │   Sync status indicator UI              │ TL    │ W12D3    │ W12D5    │ 2    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
23.0        │ TRIP HISTORY                            │ M1    │ W11D1    │ W11D5    │ 5    │ ☐
  23.1      │   History list UI                       │ M1    │ W11D1    │ W11D3    │ 2    │ ☐
  23.2      │   Trip detail view                      │ M1    │ W11D3    │ W11D5    │ 2    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
24.0        │ NOTIFICATIONS                           │ M2    │ W11D3    │ W12D5    │ 8    │ ☐
  24.1      │   FCM setup (Android + iOS)             │ M2    │ W11D3    │ W12D1    │ 2    │ ☐
  24.2      │   Notification handlers                 │ M2    │ W12D1    │ W12D3    │ 2    │ ☐
  24.3      │   Deep linking                          │ M2    │ W12D3    │ W12D4    │ 1    │ ☐
  24.4      │   Local notifications                   │ M2    │ W12D4    │ W12D5    │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
            │                                         │       │          │          │      │
═══════════ │ SPRINT 4: POLISH (W13-W16)              │       │ Week 13  │ Week 16  │ 20   │
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
25.0        │ TESTING                                 │ QA    │ W13D1    │ W14D5    │ 10   │ ☐
  25.1      │   Unit tests                            │ ALL   │ W13D1    │ W13D5    │ 5    │ ☐
  25.2      │   Integration tests                     │ QA    │ W13D1    │ W13D5    │ 5    │ ☐
  25.3      │   Device testing (10+ devices)          │ QA    │ W14D1    │ W14D5    │ 5    │ ☐
  25.4      │   Offline scenario testing              │ QA    │ W14D1    │ W14D3    │ 3    │ ☐
  25.5      │   Performance profiling                 │ TL    │ W14D3    │ W14D5    │ 2    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
26.0        │ BUG FIXES                               │ ALL   │ W14D1    │ W15D5    │ 10   │ ☐
  26.1      │   Critical bugs (P0)                    │ ALL   │ W14D1    │ W14D5    │ 5    │ ☐
  26.2      │   Major bugs (P1)                       │ ALL   │ W15D1    │ W15D3    │ 3    │ ☐
  26.3      │   Minor bugs (P2)                       │ JR    │ W15D3    │ W15D5    │ 2    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
27.0        │ OPTIMIZATION                            │ TL    │ W15D1    │ W15D5    │ 5    │ ☐
  27.1      │   Bundle size reduction                 │ TL    │ W15D1    │ W15D2    │ 2    │ ☐
  27.2      │   Startup time optimization             │ TL    │ W15D2    │ W15D3    │ 1    │ ☐
  27.3      │   Memory leak fixes                     │ TL    │ W15D3    │ W15D4    │ 1    │ ☐
  27.4      │   Battery optimization                  │ TL    │ W15D4    │ W15D5    │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
28.0        │ INTERNATIONALIZATION                    │ M1    │ W13D1    │ W14D3    │ 8    │ ☐
  28.1      │   i18n library setup                    │ M1    │ W13D1    │ W13D2    │ 1    │ ☐
  28.2      │   English string extraction             │ M1    │ W13D2    │ W13D3    │ 1    │ ☐
  28.3      │   Hindi translation                     │ M1    │ W13D3    │ W14D1    │ 3    │ ☐
  28.4      │   Tamil, Telugu, Marathi                │ M1    │ W14D1    │ W14D3    │ 2    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
29.0        │ APP STORE PREP                          │ DS/PM │ W15D3    │ W16D3    │ 5    │ ☐
  29.1      │   App icons (all sizes)                 │ DS    │ W15D3    │ W15D4    │ 1    │ ☐
  29.2      │   Splash screens                        │ DS    │ W15D4    │ W15D5    │ 1    │ ☐
  29.3      │   Store screenshots                     │ DS    │ W16D1    │ W16D2    │ 1    │ ☐
  29.4      │   Store descriptions                    │ PM    │ W16D1    │ W16D2    │ 1    │ ☐
  29.5      │   Privacy policy                        │ PM    │ W16D2    │ W16D3    │ 1    │ ☐
────────────┼─────────────────────────────────────────┼───────┼──────────┼──────────┼──────┼────────
30.0        │ DEPLOYMENT                              │ TL    │ W16D3    │ W16D5    │ 3    │ ☐
  30.1      │   Production Android build              │ TL    │ W16D3    │ W16D4    │ 1    │ ☐
  30.2      │   Production iOS build                  │ TL    │ W16D3    │ W16D4    │ 1    │ ☐
  30.3      │   Play Store submission                 │ TL    │ W16D4    │ W16D5    │ 1    │ ☐
  30.4      │   App Store submission                  │ TL    │ W16D4    │ W16D5    │ 1    │ ☐
────────────┴─────────────────────────────────────────┴───────┴──────────┴──────────┴──────┴────────
```

---

## Status Legend

| Symbol | Status |
|--------|--------|
| ☐ | Not Started |
| ◐ | In Progress |
| ☑ | Complete |
| ⚠ | Blocked |
| ✗ | Cancelled |

---

## Weekly Milestones

| Week | Milestone | Deliverable |
|------|-----------|-------------|
| W1 | Project kickoff | Repo setup, design system started |
| W2 | Auth complete | Login/OTP working |
| W3 | Foundation done | SQLite, API client, navigation |
| W4 | Dashboard live | Dashboard with cached data |
| W5 | Trip start | Assignment, loading screens |
| W6 | Trip middle | Active trip, document capture |
| W7 | MQTT live | Real-time alerts working |
| W8 | Trip end | PoD, completion flow |
| W9 | Money | Earnings, expenses started |
| W10 | Documents | Document wallet, DigiLocker |
| W11 | AI | Copilot chat working |
| W12 | Sync complete | Full offline sync |
| W13 | Testing | All tests passing |
| W14 | Bug bash | Critical bugs fixed |
| W15 | Polish | Optimized, i18n complete |
| W16 | Launch | Store submissions |

---

## CSV Export Format

Copy below for spreadsheet import:

```csv
ID,Task,Subtasks,Owner,Start,End,Days,Status,Notes
1.0,PROJECT SETUP,,TL,W1D1,W1D3,3,,
1.1,Initialize RN project,Expo setup,TL,W1D1,W1D1,1,,
1.2,Folder structure,,TL,W1D2,W1D2,1,,
1.3,ESLint + Prettier,,TL,W1D2,W1D2,0.5,,
1.4,CI/CD pipeline,GitHub Actions,TL,W1D3,W1D3,1,,
1.5,Environment variables,,TL,W1D3,W1D3,0.5,,
2.0,DESIGN SYSTEM,,DS,W1D1,W1D5,5,,
2.1,Color palette & typography,,DS,W1D1,W1D2,2,,
2.2,Base component specs,,DS,W1D2,W1D4,2,,
2.3,Icon library selection,,DS,W1D4,W1D5,1,,
```

*(Continue pattern for all tasks)*

---

**Last Updated:** January 2025
