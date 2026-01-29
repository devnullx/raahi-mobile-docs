# Fuel Pump API Integration - Strategic Notes

**Date:** January 2025
**Status:** Research / Partnership Opportunity
**Priority:** High - Eliminates major driver friction

---

## The Problem

Current flow:
```
Driver fuels up → Gets paper receipt → Takes photo → Uploads to app →
Fleet manager reviews → Approves reimbursement → Payment processed
```

**Pain points:**
- Driver fumbles with phone at pump
- Receipt photos often blurry, unreadable
- Manual data entry errors
- Fraud potential (fake receipts)
- Delayed reimbursements
- Fleet manager time wasted on verification

---

## The Insight

**All fuel pumps already have digital systems.**

Every OMC (Oil Marketing Company) in India has:
- POS terminals at every pump
- Digital transaction records
- Fleet card programs
- Existing B2B APIs

Why are we asking drivers to photograph receipts when the data already exists digitally at source?

---

## India Fuel Market - Key Players

### Public Sector (90%+ market share)

| Company | Outlets | Fleet Card Program | API Potential |
|---------|---------|-------------------|---------------|
| **IOCL** (Indian Oil) | 35,000+ | XTRAPOWER Fleet Card | High - largest, most digital |
| **BPCL** (Bharat Petroleum) | 20,000+ | SmartFleet Card | High - aggressive digitization |
| **HPCL** (Hindustan Petroleum) | 21,000+ | HP Pay, DriveTrack Plus | Medium-High |

### Private Sector

| Company | Outlets | Fleet Card Program | API Potential |
|---------|---------|-------------------|---------------|
| **Reliance BP** | 1,500+ | Jio-BP partnership | High - tech-forward |
| **Nayara Energy** | 6,000+ | Nayara Fleet Card | Medium |
| **Shell** | 300+ | Shell Fleet Solutions | High - global APIs exist |

---

## Integration Approaches

### Option 1: Fleet Card Partnership (Recommended for MVP)

**How it works:**
1. DevNullX partners with IOCL/BPCL/HPCL
2. Issue co-branded fleet cards to drivers
3. Every transaction auto-syncs to our platform via API
4. Zero manual entry, zero receipt photos

**Benefits:**
- Real-time fuel data
- Automatic expense logging
- Fuel theft prevention (geofence matching)
- Volume discounts (2-5% on fuel)
- Credit terms (15-30 days)

**API Data Available:**
```json
{
  "transaction_id": "TXN-2025-XXXXX",
  "timestamp": "2025-01-30T14:32:00+05:30",
  "pump_id": "IOCL-KNP-0045",
  "pump_location": {
    "lat": 26.4499,
    "lng": 80.3319,
    "address": "NH-19, Kanpur"
  },
  "fuel_type": "HSD",
  "quantity_liters": 120.5,
  "rate_per_liter": 96.40,
  "total_amount": 11616.20,
  "vehicle_number": "MH-12-AB-1234",
  "odometer_reading": 145230,
  "driver_id": "DRV-790"
}
```

**Challenges:**
- Partnership negotiations (3-6 months)
- Card issuance logistics
- Driver training
- Not all pumps may accept all cards

---

### Option 2: Payment Gateway Integration

**How it works:**
1. Integrate with UPI/payment rails
2. Create "Fuel Payment" flow in app
3. Driver scans pump QR, pays via app
4. Transaction data captured automatically

**Partners to explore:**
- Paytm for Business (fuel vertical exists)
- PhonePe (BPCL partnership)
- GPay (IOCL integration)
- FASTag wallet (already used for tolls)

**Benefits:**
- Works at any pump
- No card issuance needed
- Faster rollout

**Challenges:**
- Driver may prefer cash/existing UPI
- Need pump-level integration for quantity data
- Payment != fuel data (just amount, not liters)

---

### Option 3: Receipt OCR + Verification (Fallback)

**When needed:**
- Pumps without digital integration
- Cash payments
- Transition period

**Enhancement over current:**
```
Photo → OCR extraction → Auto-verify against:
  - GPS location (was driver near this pump?)
  - Time (does timestamp match trip?)
  - Vehicle (does registration match?)
  - Price (is rate consistent with market?)
```

**Flag suspicious:**
- Receipt from pump 50km from route
- Fuel quantity > tank capacity
- Rate significantly off market price
- Duplicate receipt numbers

---

## Strategic Recommendation

### Phase 1: MVP (Month 1-3)
- Implement smart OCR with verification
- Flag anomalies, don't block
- Collect data on fuel patterns

### Phase 2: Pilot Partnership (Month 4-6)
- Approach IOCL (largest network)
- Pilot with 1 depot, 50 trucks
- Prove value: fraud reduction, time savings

### Phase 3: Scale (Month 7+)
- Roll out fleet cards across fleet
- Add BPCL, HPCL as secondary options
- Negotiate volume discounts

---

## Business Case for OMCs

**Why would IOCL/BPCL partner with us?**

1. **Guaranteed volume** - Fleet commits to X liters/month
2. **Reduced fraud** - Our GPS verifies legitimate purchases
3. **Data insights** - We share anonymized route/consumption data
4. **Digital push** - Aligns with govt digitization goals
5. **Loyalty** - Fleet locked into their network

**Our ask:**
- API access to transaction data
- Co-branded cards (no cost to us)
- 2-3% volume discount (pass to fleet owner)

**Their gain:**
- Sticky fleet customers
- Reduced cash handling
- Better demand forecasting

---

## Technical Integration Notes

### IOCL XTRAPOWER API (Research needed)

Likely endpoints:
```
POST /api/v1/cards/issue
GET  /api/v1/transactions?card_id=XXX&from=DATE&to=DATE
GET  /api/v1/cards/{card_id}/balance
POST /api/v1/cards/{card_id}/limit
```

Authentication: OAuth2 or API Key (TBD)

### Data Sync Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  OMC API    │────▶│  Lambda      │────▶│  PostgreSQL │
│  (Webhook)  │     │  (Processor) │     │  (expenses) │
└─────────────┘     └──────────────┘     └─────────────┘
                           │
                           ▼
                    ┌──────────────┐
                    │  Raahi App   │
                    │  (Real-time) │
                    └──────────────┘
```

- Webhook preferred (real-time)
- Polling fallback (every 15 min)
- Idempotent writes (handle duplicates)

---

## Toll Integration - Same Principle

**FASTag already solves this for tolls.**

Current state:
- FASTag auto-deducts at toll
- Transaction data available via NPCI/NETC APIs
- Banks provide fleet FASTag management portals

**Action:**
- Integrate with fleet's FASTag provider
- Auto-log toll expenses from API
- Match with trip route for verification

---

## Summary

| Expense Type | Current | Target State |
|--------------|---------|--------------|
| **Fuel** | Photo receipt | Fleet card API |
| **Tolls** | Photo/manual | FASTag API auto-sync |
| **Parking** | Manual entry | Geofence + estimate |
| **Food** | Photo receipt | Keep manual (low value) |
| **Repairs** | Photo receipt | Keep manual (rare) |

**Goal:** 80% of expenses auto-captured. Driver only handles edge cases.

---

## Next Steps

1. [ ] Research IOCL XTRAPOWER API documentation
2. [ ] Identify IOCL/BPCL business development contacts
3. [ ] Draft partnership proposal
4. [ ] Build OCR fallback with smart verification
5. [ ] Integrate FASTag API for tolls

---

## References

- IOCL Fleet Solutions: https://iocl.com/xtrapower-fleet-card
- BPCL SmartFleet: https://www.bharatpetroleum.in/our-businesses/smartfleet.aspx
- HPCL DriveTrack: https://www.hindustanpetroleum.com/drivetrackplus
- NPCI FASTag: https://www.npci.org.in/what-we-do/netc-fastag

---

**Author:** Strategic Notes
**Last Updated:** January 2025
