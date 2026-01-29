# Raahi Mobile App - Planning Documentation

**Project:** Raahi Driver App
**Platform:** React Native (iOS + Android)
**Duration:** 16 Weeks
**Team:** 5-6 Engineers

---

## Quick Links

| Document | Description |
|----------|-------------|
| [01. Mobile App Architecture](./01_mobile_app_architecture.md) | Tech stack, folder structure, state management |
| [02. API Contracts](./02_api_contracts.md) | REST endpoints, request/response schemas |
| [03. SQLite Schema](./03_sqlite_schema.sql) | Offline database tables, indexes |
| [04. MQTT Topics](./04_mqtt_topics.md) | Real-time messaging structure |
| [05. Screen Specifications](./05_screen_specifications.md) | UI layouts, data sources, actions |
| [06. Offline Sync Strategy](./06_offline_sync_strategy.md) | Sync queue, conflict resolution |
| [07. Notification Strategy](./07_notification_strategy.md) | FCM, deep linking, local notifications |
| [08. Implementation Roadmap](./08_implementation_roadmap.md) | Sprints, team, budget, Gantt |
| [09. Project Task Sheet](./09_project_task_sheet.md) | Spreadsheet-ready task list |

---

## Project Summary

```
┌─────────────────────────────────────────────────────────────┐
│                     RAAHI = DRIVER'S COCKPIT                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🤖 AI Copilot     → Natural language assistant            │
│  📦 Work Manager   → Trips, loading, PoD, documents        │
│  💰 Financial Hub  → Earnings, expenses (auto-captured)    │
│  🚨 Safety         → Alerts from Aghraan edge device       │
│  💬 Communication  → Chat with dispatch                    │
│                                                             │
│  PHILOSOPHY: Automate everything. AI handles the rest.     │
│              Manual entry only for edge cases.              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Team Required

| Role | FTE | Monthly |
|------|-----|---------|
| Tech Lead | 1.0 | ₹1.3L |
| Mid Dev × 2 | 2.0 | ₹1.4L |
| Junior Dev | 1.0 | ₹45K |
| Designer | 0.5 | ₹30K |
| QA | 0.5 | ₹22K |
| PM | 0.5 | ₹35K |
| **Total** | **5.5** | **₹4.6L/month** |

---

## Timeline

```
WEEK  1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16
      ├───────────┼───────────┼───────────┼───────────┤
      │ SPRINT 1  │ SPRINT 2  │ SPRINT 3  │ SPRINT 4  │
      │ Foundation│ Core Trip │ Features  │ Polish    │
      └───────────┴───────────┴───────────┴───────────┘

Sprint 1: Auth, navigation, SQLite, dashboard
Sprint 2: Trip lifecycle, MQTT, alerts, PoD
Sprint 3: Earnings, expenses, documents, AI copilot
Sprint 4: Testing, bugs, optimization, deployment
```

---

## Budget

| Item | Amount |
|------|--------|
| Team (4 months) | ₹16.1L |
| Contingency (15%) | ₹2.4L |
| **Total** | **₹18.5L** |

---

## Related Documentation

- [Fuel Pump API Integration](../rough_thoughts_of_ichigo/fuel_pump_api_integration.md) - Strategic notes on auto-capturing fuel expenses
- [Architecture Decisions](../rough_thoughts_of_ichigo/architecture_decisions.md) - Backend decisions
- [Microservices Overview](../04_services/00_overview.md) - Backend services this app integrates with

---

**Last Updated:** January 2025
