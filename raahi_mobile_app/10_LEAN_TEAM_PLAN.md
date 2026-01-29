# Raahi Mobile App - Lean Team Planning

**Model:** Toyota Production System (TPS) / Lean Startup
**Principle:** Right people, right time, zero waste

---

## Toyota Lean Principles Applied

| TPS Principle | Our Application |
|---------------|-----------------|
| **Just-in-Time (JIT)** | Add team members only when needed, not before |
| **Jidoka (Built-in quality)** | Senior devs first, juniors learn from them |
| **Heijunka (Level loading)** | Balance work across sprints, no crunch |
| **Kaizen (Continuous improvement)** | Weekly retros, adapt team as needed |
| **Muda (Eliminate waste)** | No idle people, no context switching |
| **Pull System** | Work pulls people, not push people to work |

---

## Phase-Based Team Scaling

```
TEAM SIZE OVER TIME (Lean Model)

People
  6 ─┤                                    ████████████
    │                          ████████████████████████
  5 ─┤                    ██████████████████████████████
    │              ████████████████████████████████████
  4 ─┤        ██████████████████████████████████████████
    │    ████████████████████████████████████████████████
  3 ─┤████████████████████████████████████████████████████
    │████████████████████████████████████████████████████
  2 ─┤████████████████████████████████████████████████████
    │████████████████████████████████████████████████████
  1 ─┤████████████████████████████████████████████████████
    └─────────────────────────────────────────────────────
     W1-2   W3-4   W5-6   W7-8   W9-10  W11-12 W13-14 W15-16

     Phase 1    Phase 2       Phase 3          Phase 4
     Seed       Growth        Full Team        Taper
```

---

## Phase 1: SEED (Weeks 1-4)

**Goal:** Foundation with minimum viable team

### Team (3 people)

| Role | Who | Why |
|------|-----|-----|
| **Tech Lead** | 1 FTE | Architecture, critical decisions, unblocks everyone |
| **Mid Dev** | 1 FTE | Core development, learns codebase |
| **Designer** | 0.5 FTE (contract) | Design system, wireframes |

### Cost: ₹2.3L/month

```
Tech Lead:     ₹1,30,000
Mid Dev:       ₹70,000
Designer:      ₹30,000 (half time)
──────────────────────────
Total:         ₹2,30,000/month
```

### Work Allocation

| Person | Sprint 1 Work |
|--------|---------------|
| Tech Lead | Project setup, SQLite, navigation, auth architecture |
| Mid Dev | UI components, auth screens, dashboard |
| Designer | Design system, all screen mockups |

### Why This Works

- **Tech Lead sets patterns** - Everything built on solid foundation
- **Mid Dev learns** - Gets mentored, productive fast
- **Designer frontloads** - All designs ready before dev needs them
- **No idle time** - Everyone at 100% utilization

---

## Phase 2: GROWTH (Weeks 5-8)

**Goal:** Add capacity for parallel development

### Team (4.5 people)

| Role | Who | Change |
|------|-----|--------|
| Tech Lead | 1 FTE | Same |
| Mid Dev 1 | 1 FTE | Same (now experienced) |
| **Mid Dev 2** | **1 FTE** | **ADD in Week 5** |
| Designer | 0.5 FTE | Same (reducing to 25% by W7) |
| **Junior Dev** | **0.5 → 1 FTE** | **ADD in Week 5 (part-time), full in W6** |

### Cost: ₹3.6L/month

```
Tech Lead:     ₹1,30,000
Mid Dev 1:     ₹70,000
Mid Dev 2:     ₹70,000 (NEW)
Junior Dev:    ₹45,000 (NEW)
Designer:      ₹30,000 (reducing)
──────────────────────────
Total:         ₹3,45,000/month
```

### Why Add Now?

| New Person | Trigger | Justification |
|------------|---------|---------------|
| Mid Dev 2 | Trip flow starts | Parallel workstreams: Trip (M1) + Loading/Unload (M2) |
| Junior Dev | Document capture | Lower complexity work available, mentoring capacity exists |

### Work Allocation

| Person | Sprint 2 Work |
|--------|---------------|
| Tech Lead | MQTT (complex), Active Trip Screen, Map integration |
| Mid Dev 1 | Trip assignment, Issue reporting |
| Mid Dev 2 | Loading process, Unloading/PoD |
| Junior Dev | Document capture, Camera, Signature pad |
| Designer | Final screen polishes (tapering off) |

---

## Phase 3: FULL TEAM (Weeks 9-12)

**Goal:** Maximum parallel capacity for features

### Team (5.5 people)

| Role | Who | Change |
|------|-----|--------|
| Tech Lead | 1 FTE | Same |
| Mid Dev 1 | 1 FTE | Same |
| Mid Dev 2 | 1 FTE | Same |
| Junior Dev | 1 FTE | Now full time |
| Designer | 0.25 FTE | Reduced (only UI tweaks) |
| **QA** | **0.5 FTE** | **ADD in Week 9** |

### Cost: ₹4.1L/month

```
Tech Lead:     ₹1,30,000
Mid Dev 1:     ₹70,000
Mid Dev 2:     ₹70,000
Junior Dev:    ₹45,000
Designer:      ₹15,000 (quarter time)
QA:            ₹22,500 (NEW, half time)
──────────────────────────
Total:         ₹3,52,500/month
```

### Why Add QA Now?

- Features exist to test
- Junior Dev work needs review
- Test cases being written
- Integration testing starts

### Work Allocation

| Person | Sprint 3 Work |
|--------|---------------|
| Tech Lead | AI Copilot, Offline Sync (complex) |
| Mid Dev 1 | Earnings, Trip History |
| Mid Dev 2 | Expenses, Notifications |
| Junior Dev | Documents, DigiLocker |
| QA | Test case writing, Manual testing |
| Designer | UI bug fixes only |

---

## Phase 4: QUALITY FOCUS (Weeks 13-16)

**Goal:** Bug fixes, optimization, launch

### Team (5 people)

| Role | Who | Change |
|------|-----|--------|
| Tech Lead | 1 FTE | Same |
| Mid Dev 1 | 1 FTE | Same |
| Mid Dev 2 | 1 FTE | Same |
| Junior Dev | 0.5 FTE | **REDUCE** - less new work |
| Designer | 0.5 FTE | **INCREASE** - App store assets |
| QA | 1 FTE | **INCREASE** - Full testing |
| **PM** | **0.5 FTE** | **ADD** - Launch coordination |

### Cost: ₹4.3L/month

```
Tech Lead:     ₹1,30,000
Mid Dev 1:     ₹70,000
Mid Dev 2:     ₹70,000
Junior Dev:    ₹22,500 (half time)
Designer:      ₹30,000 (back to half)
QA:            ₹45,000 (full time)
PM:            ₹35,000 (NEW, half time)
──────────────────────────
Total:         ₹4,02,500/month
```

### Why Changes?

| Change | Reason |
|--------|--------|
| Junior Dev ↓ | No new features, just bug fixes |
| Designer ↑ | App store screenshots, icons, marketing |
| QA ↑ | Full regression, device testing |
| PM joins | Store submission, launch coordination |

### Work Allocation

| Person | Sprint 4 Work |
|--------|---------------|
| Tech Lead | Optimization, critical bugs, deployment |
| Mid Dev 1 | i18n, bug fixes |
| Mid Dev 2 | Bug fixes, notification polish |
| Junior Dev | Minor bugs (part time) |
| Designer | App icons, screenshots, marketing |
| QA | Full regression, 10+ devices |
| PM | Store submission, launch checklist |

---

## Team Summary by Week

```csv
Week,TL,M1,M2,JR,DS,QA,PM,Total_FTE,Monthly_Cost
W1,1,1,0,0,0.5,0,0,2.5,230000
W2,1,1,0,0,0.5,0,0,2.5,230000
W3,1,1,0,0,0.5,0,0,2.5,230000
W4,1,1,0,0,0.5,0,0,2.5,230000
W5,1,1,1,0.5,0.5,0,0,4,315000
W6,1,1,1,1,0.5,0,0,4.5,345000
W7,1,1,1,1,0.25,0,0,4.25,330000
W8,1,1,1,1,0.25,0,0,4.25,330000
W9,1,1,1,1,0.25,0.5,0,4.75,352500
W10,1,1,1,1,0.25,0.5,0,4.75,352500
W11,1,1,1,1,0.25,0.5,0,4.75,352500
W12,1,1,1,1,0.25,0.5,0,4.75,352500
W13,1,1,1,0.5,0.5,1,0.5,5.5,402500
W14,1,1,1,0.5,0.5,1,0.5,5.5,402500
W15,1,1,1,0.5,0.5,1,0.5,5.5,402500
W16,1,1,1,0.5,0.5,1,0.5,5.5,402500
```

---

## Hiring Timeline

```
HIRING DECISIONS

Week -2:  Post job for Tech Lead (critical, hire first)
Week -1:  Post job for Mid Dev 1
Week 1:   Tech Lead starts
          Mid Dev 1 starts
          Designer contracted (0.5)

Week 4:   Post job for Mid Dev 2 + Junior Dev
          (2 weeks to hire, start W5-6)

Week 5:   Mid Dev 2 starts
          Junior Dev starts (part-time)

Week 6:   Junior Dev goes full-time
          Designer reducing

Week 8:   Post for QA (half-time)

Week 9:   QA starts

Week 12:  Post for PM (half-time for launch)
          QA increasing to full-time

Week 13:  PM starts
          Junior Dev reducing
          Designer back up for assets
```

---

## Cost Comparison: Lean vs Traditional

### Traditional Approach (Full team from Day 1)

```
Week 1-16: 6 people × 4 months
Tech Lead:     ₹5,20,000
Mid Dev 1:     ₹2,80,000
Mid Dev 2:     ₹2,80,000
Junior Dev:    ₹1,80,000
Designer:      ₹1,20,000
QA:            ₹90,000
PM:            ₹1,40,000
──────────────────────────
Total:         ₹14,10,000

Problems:
- QA idle for weeks 1-8
- PM idle for weeks 1-12
- Junior Dev idle weeks 1-4
- Designer overkill after week 8
```

### Lean Approach (Scale as needed)

```
Phase 1 (W1-4):   ₹2,30,000 × 1 = ₹2,30,000
Phase 2 (W5-8):   ₹3,45,000 × 1 = ₹3,45,000
Phase 3 (W9-12):  ₹3,52,500 × 1 = ₹3,52,500
Phase 4 (W13-16): ₹4,02,500 × 1 = ₹4,02,500
──────────────────────────────────────────
Total:                          ₹13,30,000

Savings: ₹80,000 (6%)
+ Better utilization
+ Less coordination overhead
+ Natural team building
```

---

## Risk Mitigation

### What if hiring takes too long?

| Role | Backup Plan |
|------|-------------|
| Mid Dev 2 | M1 + TL absorb, delay 1-2 features |
| Junior Dev | M1/M2 do simpler tasks, delay non-critical |
| QA | Devs do own testing, hire later |
| Designer | Use Figma templates, contract hourly |

### What if someone leaves?

| Role | Impact | Mitigation |
|------|--------|------------|
| Tech Lead | CRITICAL | 2-week knowledge transfer minimum, document everything |
| Mid Dev | HIGH | Cross-train from week 1, code reviews |
| Junior | LOW | Work is well-defined, replaceable |
| Designer | LOW | Contract basis anyway |

---

## Key Metrics to Track

| Metric | Target | Action if Off |
|--------|--------|---------------|
| Velocity per person | 4-5 tasks/week | Review process, reduce blockers |
| Utilization | >85% | Redistribute work |
| Code review time | <24 hours | Add reviewer, async reviews |
| Bug escape rate | <5% | Add QA earlier |
| Team happiness | Green | 1:1s, address concerns |

---

## Interview Timeline

### Tech Lead (Hire by Week -1)

**Criteria:**
- 5+ years React Native
- Led team of 3+
- Offline-first experience
- AWS experience
- Good communicator

**Interview:**
1. Technical screen (1 hr)
2. System design: "Design offline sync for expense app" (1 hr)
3. Culture fit + leadership (30 min)

### Mid Developers (Hire by Week -1 and Week 5)

**Criteria:**
- 2-3 years React Native
- TypeScript proficiency
- REST API integration
- Self-directed

**Interview:**
1. Coding: Build a screen (1 hr take-home)
2. Technical discussion (45 min)
3. Culture fit (30 min)

### Junior Developer (Hire by Week 5)

**Criteria:**
- 1+ year React/RN
- Eager to learn
- Good fundamentals
- Coachable

**Interview:**
1. Basic coding (45 min)
2. Culture fit (30 min)

---

## Summary

```
┌─────────────────────────────────────────────────────────────┐
│                    LEAN TEAM SUMMARY                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  START SMALL        →  SCALE UP         →  QUALITY FOCUS   │
│  (W1-4)                (W5-12)              (W13-16)        │
│                                                             │
│  3 people              4-5 people           5-6 people      │
│  ₹2.3L/mo              ₹3.5L/mo             ₹4L/mo          │
│                                                             │
│  Foundation first      Parallel work        Testing+Launch  │
│  Patterns set          Features ship        Quality focus   │
│  No waste              Right-sized          Clean handoff   │
│                                                             │
└─────────────────────────────────────────────────────────────┘

Total Project Cost: ~₹13.3L (vs ₹14.1L traditional)
Peak Team Size: 5.5 FTE
Average Team Size: 4.1 FTE
```

---

**Last Updated:** January 2025
