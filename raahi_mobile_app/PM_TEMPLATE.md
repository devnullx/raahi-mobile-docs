# Raahi Mobile App - Project Management Template

**How to use:** Copy the CSV sections into Google Sheets or Excel. Formulas are Google Sheets compatible.

---

## Sheet 1: MASTER TASK TRACKER

### CSV Import (Copy to Sheet)

```csv
ID,Task,Parent,Owner,Priority,Status,Start_Date,End_Date,Est_Days,Actual_Days,Progress_%,Blocked_By,Notes
1.0,PROJECT SETUP,,TL,P0,Not Started,2025-02-03,2025-02-05,3,,,
1.1,Initialize RN project,1.0,TL,P0,Not Started,2025-02-03,2025-02-03,1,,,
1.2,Folder structure,1.0,TL,P0,Not Started,2025-02-04,2025-02-04,1,,,
1.3,ESLint + Prettier,1.0,TL,P1,Not Started,2025-02-04,2025-02-04,0.5,,,
1.4,CI/CD pipeline,1.0,TL,P0,Not Started,2025-02-05,2025-02-05,1,,,
1.5,Environment variables,1.0,TL,P1,Not Started,2025-02-05,2025-02-05,0.5,,,
2.0,DESIGN SYSTEM,,DS,P0,Not Started,2025-02-03,2025-02-07,5,,,
2.1,Color palette & typography,2.0,DS,P0,Not Started,2025-02-03,2025-02-04,2,,,
2.2,Base component specs,2.0,DS,P0,Not Started,2025-02-04,2025-02-06,2,,,
2.3,Icon library selection,2.0,DS,P1,Not Started,2025-02-06,2025-02-07,1,,,
3.0,BASE UI COMPONENTS,,M1,P0,Not Started,2025-02-04,2025-02-12,7,,,
3.1,Button component,3.0,M1,P0,Not Started,2025-02-04,2025-02-05,1,,,
3.2,Input component,3.0,M1,P0,Not Started,2025-02-05,2025-02-06,1,,,
3.3,Card component,3.0,M1,P0,Not Started,2025-02-06,2025-02-07,1,,,
3.4,Modal component,3.0,M1,P1,Not Started,2025-02-10,2025-02-11,1,,,
3.5,Toast/Snackbar,3.0,M1,P1,Not Started,2025-02-11,2025-02-12,1,,,
4.0,AUTHENTICATION FLOW,,M2,P0,Not Started,2025-02-05,2025-02-14,8,,,
4.1,AWS Amplify Auth setup,4.0,M2,P0,Not Started,2025-02-05,2025-02-06,1,,,
4.2,Login screen UI,4.0,M2,P0,Not Started,2025-02-06,2025-02-07,1,,,
4.3,OTP screen UI,4.0,M2,P0,Not Started,2025-02-10,2025-02-11,1,,,
4.4,Request OTP API,4.0,M2,P0,Not Started,2025-02-11,2025-02-12,1,,,
4.5,Verify OTP API,4.0,M2,P0,Not Started,2025-02-12,2025-02-13,1,,,
4.6,Token storage,4.0,M2,P1,Not Started,2025-02-13,2025-02-13,0.5,,,
4.7,Token refresh logic,4.0,M2,P0,Not Started,2025-02-13,2025-02-14,1,,,
4.8,Auth state management,4.0,M2,P1,Not Started,2025-02-14,2025-02-14,0.5,,,
```

### Formulas for Task Tracker

| Column | Formula | Purpose |
|--------|---------|---------|
| **Days Remaining** | `=IF(K2="Complete",0,MAX(0,H2-TODAY()))` | Days until deadline |
| **Is Overdue** | `=IF(AND(K2<>"Complete",H2<TODAY()),"OVERDUE","OK")` | Flag overdue tasks |
| **Variance** | `=J2-I2` | Actual vs Estimated days |
| **Sprint** | `=IF(G2<DATE(2025,3,3),"Sprint 1",IF(G2<DATE(2025,3,31),"Sprint 2",IF(G2<DATE(2025,4,28),"Sprint 3","Sprint 4")))` | Auto-assign sprint |
| **Week Number** | `=WEEKNUM(G2)-WEEKNUM(DATE(2025,2,3))+1` | Project week |
| **Parent Progress** | `=AVERAGEIF(C:C,A2,K:K)` | Avg progress of children |

---

## Sheet 2: TEAM WORKLOAD

### CSV Import

```csv
Team_Member,Role,Rate_Monthly,Sprint_1_Days,Sprint_2_Days,Sprint_3_Days,Sprint_4_Days,Total_Days,Total_Cost
TL,Tech Lead,130000,20,20,20,20,80,
M1,Mid Developer 1,70000,20,20,20,20,80,
M2,Mid Developer 2,70000,20,20,20,20,80,
JR,Junior Developer,45000,20,20,20,20,80,
DS,Designer (0.5),30000,10,10,10,10,40,
QA,QA Engineer (0.5),22500,5,5,10,20,40,
PM,Project Manager (0.5),35000,10,10,10,10,40,
```

### Formulas for Team Workload

| Column | Formula | Purpose |
|--------|---------|---------|
| **Total Days** | `=SUM(D2:G2)` | Sum all sprint days |
| **Total Cost** | `=C2*4` | 4 months salary |
| **Daily Rate** | `=C2/22` | Monthly / 22 working days |
| **Sprint Cost** | `=D2*(C2/22)` | Days × daily rate |
| **Utilization %** | `=H2/80*100` | Actual vs available (80 days in 4 months) |

### Team Summary Formulas

```
Total Team Cost:     =SUM(I2:I8)
Avg Utilization:     =AVERAGE(J2:J8)
Total Person Days:   =SUM(H2:H8)
```

---

## Sheet 3: SPRINT TRACKER

### CSV Import

```csv
Sprint,Start_Date,End_Date,Total_Tasks,Completed,In_Progress,Blocked,Not_Started,Progress_%,Velocity,Planned_Points,Actual_Points
Sprint 1,2025-02-03,2025-02-28,45,0,0,0,45,0,0,45,0
Sprint 2,2025-03-03,2025-03-28,52,0,0,0,52,0,0,52,0
Sprint 3,2025-03-31,2025-04-25,48,0,0,0,48,0,0,48,0
Sprint 4,2025-04-28,2025-05-23,35,0,0,0,35,0,0,35,0
```

### Formulas for Sprint Tracker

| Column | Formula | Purpose |
|--------|---------|---------|
| **Total Tasks** | `=COUNTIF(TaskTracker!$Sprint,$A2)` | Count tasks in sprint |
| **Completed** | `=COUNTIFS(TaskTracker!$Sprint,$A2,TaskTracker!$Status,"Complete")` | Completed tasks |
| **In Progress** | `=COUNTIFS(TaskTracker!$Sprint,$A2,TaskTracker!$Status,"In Progress")` | Active tasks |
| **Blocked** | `=COUNTIFS(TaskTracker!$Sprint,$A2,TaskTracker!$Status,"Blocked")` | Blocked tasks |
| **Not Started** | `=D2-E2-F2-G2` | Remaining |
| **Progress %** | `=ROUND(E2/D2*100,1)` | Completion percentage |
| **Velocity** | `=E2/MAX(1,NETWORKDAYS(B2,MIN(C2,TODAY())))` | Tasks/day rate |
| **Burndown** | `=D2-E2` | Tasks remaining |

---

## Sheet 4: BUDGET TRACKER

### CSV Import

```csv
Category,Item,Budgeted,Actual,Variance,Status,Notes
Personnel,Tech Lead (4 months),520000,0,520000,On Track,
Personnel,Mid Dev 1 (4 months),280000,0,280000,On Track,
Personnel,Mid Dev 2 (4 months),280000,0,280000,On Track,
Personnel,Junior Dev (4 months),180000,0,180000,On Track,
Personnel,Designer (4 months),120000,0,120000,On Track,
Personnel,QA (4 months),90000,0,90000,On Track,
Personnel,PM (4 months),140000,0,140000,On Track,
Infrastructure,AWS (4 months),20000,0,20000,On Track,Estimated
Infrastructure,Apple Developer,8500,0,8500,On Track,Annual fee
Infrastructure,Google Play,2100,0,2100,On Track,One time
Tools,Figma (4 months),8000,0,8000,On Track,Team plan
Tools,GitHub (4 months),0,0,0,On Track,Free tier
Contingency,Buffer (15%),241500,0,241500,Reserve,
```

### Formulas for Budget Tracker

| Column | Formula | Purpose |
|--------|---------|---------|
| **Variance** | `=C2-D2` | Budget - Actual |
| **Status** | `=IF(D2>C2,"Over Budget",IF(D2>C2*0.9,"Warning","On Track"))` | Auto status |
| **% Used** | `=D2/C2*100` | Percentage spent |
| **Remaining** | `=C2-D2` | Amount left |

### Budget Summary Formulas

```
Total Budget:        =SUM(C2:C13)
Total Spent:         =SUM(D2:D13)
Total Variance:      =SUM(E2:E13)
Budget Health:       =IF(SUM(D:D)>SUM(C:C)*0.9,"AT RISK","HEALTHY")
Burn Rate/Month:     =SUM(D:D)/MONTH(TODAY())-1
Projected Total:     =Burn_Rate*4
```

---

## Sheet 5: RISK REGISTER

### CSV Import

```csv
Risk_ID,Risk_Description,Category,Probability,Impact,Risk_Score,Mitigation,Owner,Status,Last_Updated
R001,Backend API delays,Technical,Medium,High,6,Mock APIs parallel development,TL,Open,2025-02-03
R002,Device fragmentation issues,Technical,Medium,Medium,4,Early device testing Firebase Test Lab,QA,Open,2025-02-03
R003,DigiLocker integration failure,Integration,Low,Medium,2,Manual upload fallback,M2,Open,2025-02-03
R004,MQTT complexity underestimated,Technical,Medium,High,6,Tech Lead owns use proven library,TL,Open,2025-02-03
R005,App Store rejection,Deployment,Low,High,3,Follow guidelines pre-review,TL,Open,2025-02-03
R006,Key person leaves,Resource,Low,High,3,Knowledge sharing documentation,PM,Open,2025-02-03
R007,Scope creep,Management,High,Medium,6,Strict change control,PM,Open,2025-02-03
R008,Performance issues on low-end devices,Technical,Medium,Medium,4,Performance testing from Sprint 2,TL,Open,2025-02-03
```

### Formulas for Risk Register

| Column | Formula | Purpose |
|--------|---------|---------|
| **Probability Score** | `=IF(D2="High",3,IF(D2="Medium",2,1))` | Convert to number |
| **Impact Score** | `=IF(E2="High",3,IF(E2="Medium",2,1))` | Convert to number |
| **Risk Score** | `=Prob_Score*Impact_Score` | P × I matrix |
| **Risk Level** | `=IF(F2>=6,"Critical",IF(F2>=4,"High",IF(F2>=2,"Medium","Low")))` | Risk category |
| **Days Since Update** | `=TODAY()-I2` | Staleness check |

---

## Sheet 6: WEEKLY STATUS

### CSV Import

```csv
Week,Start_Date,End_Date,Planned_Tasks,Completed_Tasks,Completion_%,Blockers,Highlights,Action_Items,Status
Week 1,2025-02-03,2025-02-07,12,0,0,None,Project kickoff,Setup repo complete auth screens,On Track
Week 2,2025-02-10,2025-02-14,15,0,0,,,,
Week 3,2025-02-17,2025-02-21,14,0,0,,,,
Week 4,2025-02-24,2025-02-28,13,0,0,,,,
```

### Formulas for Weekly Status

| Column | Formula | Purpose |
|--------|---------|---------|
| **Completion %** | `=ROUND(E2/D2*100,0)` | Tasks done percentage |
| **Status** | `=IF(F2>=100,"Complete",IF(F2>=80,"On Track",IF(F2>=50,"At Risk","Behind")))` | Auto status |
| **Velocity** | `=E2/5` | Tasks per day (5 day week) |
| **Cumulative Done** | `=SUM($E$2:E2)` | Running total |
| **Burndown** | `=TotalTasks-Cumulative_Done` | Remaining work |

---

## Sheet 7: GANTT DATA

### CSV Import (for Gantt visualization)

```csv
Task,Owner,Start,End,Duration,Progress,Dependencies
PROJECT SETUP,TL,2025-02-03,2025-02-05,3,0,
DESIGN SYSTEM,DS,2025-02-03,2025-02-07,5,0,
BASE UI COMPONENTS,M1,2025-02-04,2025-02-12,7,0,DESIGN SYSTEM
AUTHENTICATION FLOW,M2,2025-02-05,2025-02-14,8,0,PROJECT SETUP
NAVIGATION SETUP,TL,2025-02-10,2025-02-14,5,0,PROJECT SETUP
SQLITE DATABASE,TL,2025-02-17,2025-02-21,5,0,NAVIGATION SETUP
DASHBOARD SCREEN,M1,2025-02-17,2025-02-26,8,0,BASE UI COMPONENTS
API CLIENT SETUP,M2,2025-02-17,2025-02-21,5,0,AUTHENTICATION FLOW
DRIVER PROFILE,JR,2025-02-19,2025-02-28,8,0,API CLIENT SETUP
TRIP ASSIGNMENT,M1,2025-03-03,2025-03-07,5,0,DASHBOARD SCREEN
LOADING PROCESS,M2,2025-03-03,2025-03-12,8,0,TRIP ASSIGNMENT
DOCUMENT CAPTURE,JR,2025-03-05,2025-03-14,8,0,LOADING PROCESS
ACTIVE TRIP SCREEN,TL,2025-03-10,2025-03-19,8,0,TRIP ASSIGNMENT
MQTT CLIENT,TL,2025-03-12,2025-03-21,8,0,ACTIVE TRIP SCREEN
ISSUE REPORTING,M1,2025-03-17,2025-03-21,5,0,ACTIVE TRIP SCREEN
UNLOADING & POD,M2,2025-03-19,2025-03-28,8,0,DOCUMENT CAPTURE
ALERTS SCREEN,JR,2025-03-17,2025-03-26,8,0,MQTT CLIENT
EARNINGS MODULE,M1,2025-03-31,2025-04-09,8,0,UNLOADING & POD
EXPENSES MODULE,M2,2025-03-31,2025-04-09,8,0,UNLOADING & POD
DOCUMENTS MODULE,JR,2025-04-02,2025-04-14,8,0,DOCUMENT CAPTURE
AI COPILOT,TL,2025-04-09,2025-04-18,8,0,MQTT CLIENT
OFFLINE SYNC,TL,2025-04-14,2025-04-25,8,0,AI COPILOT
TRIP HISTORY,M1,2025-04-14,2025-04-18,5,0,EARNINGS MODULE
NOTIFICATIONS,M2,2025-04-16,2025-04-25,8,0,EARNINGS MODULE
TESTING,QA,2025-04-28,2025-05-09,10,0,OFFLINE SYNC
BUG FIXES,ALL,2025-05-05,2025-05-16,10,0,TESTING
OPTIMIZATION,TL,2025-05-12,2025-05-16,5,0,TESTING
I18N,M1,2025-04-28,2025-05-09,8,0,ALL FEATURES
APP STORE PREP,DS,2025-05-14,2025-05-21,5,0,OPTIMIZATION
DEPLOYMENT,TL,2025-05-21,2025-05-23,3,0,APP STORE PREP
```

### Gantt Formulas

| Column | Formula | Purpose |
|--------|---------|---------|
| **Duration** | `=NETWORKDAYS(C2,D2)` | Working days |
| **Is Active** | `=IF(AND(TODAY()>=C2,TODAY()<=D2),"ACTIVE","")` | Current task |
| **Days Left** | `=MAX(0,NETWORKDAYS(TODAY(),D2))` | Remaining days |
| **Progress Bar** | `=REPT("█",F2/10)&REPT("░",(100-F2)/10)` | Visual progress |

---

## Sheet 8: METRICS DASHBOARD

### Key Metrics (with formulas)

```
┌─────────────────────────────────────────────────────────────────┐
│                    PROJECT HEALTH DASHBOARD                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  OVERALL PROGRESS                                               │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ =COUNTIF(Status,"Complete")/COUNTA(Status)*100          │   │
│  │ Formula: Completed tasks / Total tasks × 100             │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  SCHEDULE HEALTH                                                │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ =COUNTIF(Is_Overdue,"OVERDUE")                          │   │
│  │ Formula: Count of overdue tasks                          │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  BUDGET HEALTH                                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ =SUM(Actual)/SUM(Budgeted)*100                          │   │
│  │ Formula: Spent / Budget × 100                            │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  VELOCITY (Tasks/Day)                                           │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ =COUNTIF(Status,"Complete")/NETWORKDAYS(Start,TODAY())  │   │
│  │ Formula: Completed / Working days elapsed                │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  PROJECTED COMPLETION                                           │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ =TODAY()+((Total-Completed)/Velocity)                   │   │
│  │ Formula: Today + (Remaining tasks / Velocity)            │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  RISK SCORE                                                     │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ =SUMIF(Risk_Status,"Open",Risk_Score)/COUNT(Risks)      │   │
│  │ Formula: Avg score of open risks                         │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Quick Formula Reference

### Date Calculations

```
Working days between:    =NETWORKDAYS(start, end)
Add working days:        =WORKDAY(start, days)
Week number:             =WEEKNUM(date)
Days until deadline:     =MAX(0, deadline - TODAY())
Is weekend:              =IF(WEEKDAY(date,2)>5, "Weekend", "Workday")
```

### Progress Calculations

```
Percentage complete:     =completed/total*100
Remaining work:          =total-completed
Velocity:                =completed/days_elapsed
ETA:                     =TODAY()+(remaining/velocity)
On track check:          =IF(progress>=expected, "On Track", "Behind")
```

### Budget Calculations

```
Variance:                =budgeted-actual
Percent used:            =actual/budgeted*100
Burn rate:               =actual/months_elapsed
Projected total:         =burn_rate*total_months
Over budget check:       =IF(actual>budgeted, "OVER", "OK")
```

### Conditional Formatting Rules

```
Overdue (Red):           =AND($Status<>"Complete", $End_Date<TODAY())
At Risk (Yellow):        =AND($Status<>"Complete", $End_Date<=TODAY()+7)
Complete (Green):        =$Status="Complete"
Blocked (Orange):        =$Status="Blocked"
```

---

## Google Sheets Setup Instructions

1. **Create new Google Sheet** named "Raahi Mobile - Project Tracker"

2. **Create these sheets (tabs):**
   - Task Tracker
   - Team Workload
   - Sprint Tracker
   - Budget Tracker
   - Risk Register
   - Weekly Status
   - Gantt Data
   - Dashboard

3. **Import CSV data** into each sheet (File → Import → Paste CSV)

4. **Add formulas** from the formula tables above

5. **Apply conditional formatting:**
   - Select Status column → Format → Conditional formatting
   - Add rules for each status color

6. **Create Dashboard charts:**
   - Insert → Chart → Select data range
   - Burndown: Line chart of remaining tasks
   - Progress: Pie chart of status distribution
   - Budget: Bar chart of budgeted vs actual

---

## Sample Conditional Format Rules

### For Task Tracker Status Column

| Condition | Format |
|-----------|--------|
| Text is "Complete" | Green background |
| Text is "In Progress" | Blue background |
| Text is "Blocked" | Orange background |
| Text is "Not Started" | Gray background |
| Custom: `=AND(K2<>"Complete",H2<TODAY())` | Red background (overdue) |

---

**Last Updated:** January 2025
