# API Contracts - Raahi Mobile App

**Version:** 1.0
**Date:** January 2025
**Base URL:** `https://api.devnullx.com/v1`
**Auth:** Bearer JWT (AWS Cognito)

---

## Overview

All endpoints require authentication unless marked `[Public]`. Responses follow standard format:

```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "timestamp": "2025-01-30T10:30:00Z",
    "request_id": "req_abc123"
  }
}
```

Error responses:

```json
{
  "success": false,
  "error": {
    "code": "TRIP_NOT_FOUND",
    "message": "Trip with ID 'TRP-123' not found",
    "details": { ... }
  },
  "meta": { ... }
}
```

---

## 1. Authentication (auth-service:8001)

### POST /auth/request-otp `[Public]`

Request OTP for phone number.

**Request:**
```json
{
  "phone": "+919876543210",
  "country_code": "IN"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "session_id": "sess_abc123",
    "expires_in": 300,
    "retry_after": 60
  }
}
```

**Errors:**
- `400 INVALID_PHONE` - Invalid phone format
- `429 RATE_LIMITED` - Too many OTP requests

---

### POST /auth/verify-otp `[Public]`

Verify OTP and get tokens.

**Request:**
```json
{
  "session_id": "sess_abc123",
  "otp": "123456",
  "device_info": {
    "device_id": "device_xyz",
    "platform": "android",
    "app_version": "1.2.0",
    "fcm_token": "fcm_xxx"
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbG...",
    "refresh_token": "eyJhbG...",
    "expires_in": 3600,
    "driver": {
      "id": "DRV-790",
      "name": "Ramesh Kumar",
      "phone": "+919876543210",
      "profile_photo_url": "https://...",
      "company_id": "CMP-001",
      "company_name": "ABC Logistics",
      "status": "active"
    }
  }
}
```

**Errors:**
- `400 INVALID_OTP` - Wrong OTP
- `400 OTP_EXPIRED` - OTP expired
- `404 DRIVER_NOT_FOUND` - Phone not registered

---

### POST /auth/refresh-token

Refresh access token.

**Request:**
```json
{
  "refresh_token": "eyJhbG..."
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbG...",
    "expires_in": 3600
  }
}
```

**Errors:**
- `401 TOKEN_EXPIRED` - Refresh token expired
- `401 TOKEN_REVOKED` - Token revoked (logout elsewhere)

---

### POST /auth/logout

Logout and revoke tokens.

**Request:**
```json
{
  "device_id": "device_xyz"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "message": "Logged out successfully"
  }
}
```

---

## 2. Driver Profile (driver-service:8002)

### GET /drivers/me

Get current driver profile.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "DRV-790",
    "name": "Ramesh Kumar",
    "phone": "+919876543210",
    "email": "ramesh@email.com",
    "profile_photo_url": "https://...",
    "date_of_birth": "1985-03-15",
    "license": {
      "number": "MH-1234567890",
      "type": "HMV",
      "valid_until": "2027-03-14",
      "verified": true
    },
    "company": {
      "id": "CMP-001",
      "name": "ABC Logistics",
      "logo_url": "https://..."
    },
    "assigned_vehicle": {
      "id": "VEH-456",
      "registration": "MH-12-AB-1234",
      "type": "trailer",
      "make": "Tata Prima"
    },
    "stats": {
      "total_trips": 234,
      "total_distance_km": 45670,
      "safety_score": 94,
      "rating": 4.7
    },
    "preferences": {
      "language": "hi",
      "notifications_enabled": true,
      "voice_enabled": true
    },
    "created_at": "2023-06-15T10:00:00Z"
  }
}
```

---

### PATCH /drivers/me

Update driver profile.

**Request:**
```json
{
  "email": "ramesh.new@email.com",
  "preferences": {
    "language": "en",
    "voice_enabled": false
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "DRV-790",
    "email": "ramesh.new@email.com",
    "preferences": {
      "language": "en",
      "notifications_enabled": true,
      "voice_enabled": false
    },
    "updated_at": "2025-01-30T10:30:00Z"
  }
}
```

---

### POST /drivers/me/clock-in

Clock in for shift.

**Request:**
```json
{
  "location": {
    "lat": 26.4499,
    "lng": 80.3319
  },
  "timestamp": "2025-01-30T05:15:00+05:30"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "shift_id": "SFT-2025-0130-001",
    "clocked_in_at": "2025-01-30T05:15:00+05:30",
    "expected_end": "2025-01-30T17:15:00+05:30",
    "depot": {
      "name": "Kanpur Depot",
      "address": "...",
      "bay": "Bay 3"
    }
  }
}
```

**Errors:**
- `400 ALREADY_CLOCKED_IN` - Already in active shift
- `400 OUTSIDE_GEOFENCE` - Not at depot location

---

### POST /drivers/me/clock-out

Clock out from shift.

**Request:**
```json
{
  "location": {
    "lat": 26.4499,
    "lng": 80.3319
  },
  "timestamp": "2025-01-30T18:20:00+05:30"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "shift_id": "SFT-2025-0130-001",
    "clocked_out_at": "2025-01-30T18:20:00+05:30",
    "total_hours": 13.08,
    "trips_completed": 1,
    "earnings_today": 1794
  }
}
```

---

## 3. Trips (trip-service:8005)

### GET /trips/active

Get currently active trip.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "TRP-2025-00456",
    "status": "in_transit",
    "assigned_at": "2025-01-30T06:00:00+05:30",
    "started_at": "2025-01-30T08:12:00+05:30",
    "origin": {
      "name": "Kanpur Depot",
      "address": "NH-19, Kanpur, UP",
      "lat": 26.4499,
      "lng": 80.3319
    },
    "destination": {
      "name": "Mayapuri Warehouse",
      "address": "Mayapuri Industrial Area, Delhi",
      "lat": 28.6315,
      "lng": 77.1167
    },
    "distance_km": 412,
    "eta": "2025-01-30T16:30:00+05:30",
    "cargo": {
      "type": "Electronics",
      "description": "200 boxes",
      "weight_kg": 12000,
      "value_inr": 850000,
      "eway_bill": "EWB-123456789"
    },
    "consignee": {
      "name": "XYZ Electronics",
      "contact": "+91-9876543210",
      "address": "..."
    },
    "vehicle": {
      "id": "VEH-456",
      "registration": "MH-12-AB-1234"
    },
    "seal_number": "SL-4521",
    "current_progress": {
      "distance_covered_km": 180,
      "percentage": 44,
      "current_location": {
        "lat": 27.1234,
        "lng": 79.5678
      },
      "last_update": "2025-01-30T12:30:00+05:30"
    },
    "loading": {
      "started_at": "2025-01-30T06:32:00+05:30",
      "completed_at": "2025-01-30T07:50:00+05:30",
      "items_count": 200,
      "photos": ["https://...", "https://..."]
    }
  }
}
```

**Response (200) - No active trip:**
```json
{
  "success": true,
  "data": null
}
```

---

### POST /trips/{trip_id}/accept

Accept trip assignment.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "TRP-2025-00456",
    "status": "accepted",
    "accepted_at": "2025-01-30T06:05:00+05:30"
  }
}
```

**Errors:**
- `400 ALREADY_ACCEPTED` - Trip already accepted
- `400 TRIP_EXPIRED` - Assignment expired
- `409 ACTIVE_TRIP_EXISTS` - Already have an active trip

---

### POST /trips/{trip_id}/loading/start

Start loading process.

**Request:**
```json
{
  "bay_number": "Bay 3",
  "timestamp": "2025-01-30T06:32:00+05:30"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "loading_id": "LOAD-2025-00456",
    "started_at": "2025-01-30T06:32:00+05:30",
    "expected_items": 200
  }
}
```

---

### PATCH /trips/{trip_id}/loading/progress

Update loading progress.

**Request:**
```json
{
  "items_loaded": 87,
  "photo_url": "https://s3.../loading_progress_1.jpg",
  "notes": "All items intact so far"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "items_loaded": 87,
    "items_total": 200,
    "percentage": 43,
    "estimated_completion": "2025-01-30T07:45:00+05:30"
  }
}
```

---

### POST /trips/{trip_id}/loading/complete

Complete loading with documents.

**Request:**
```json
{
  "items_loaded": 200,
  "documents": {
    "eway_bill": {
      "number": "EWB-123456789",
      "photo_url": "https://s3.../eway_bill.jpg",
      "valid_until": "2025-01-30T23:59:00+05:30"
    },
    "loading_receipt": {
      "number": "LR-2025-00456",
      "photo_url": "https://s3.../loading_receipt.jpg"
    },
    "invoice": {
      "number": "INV-2025-789",
      "photo_url": "https://s3.../invoice.jpg"
    }
  },
  "supervisor_signature": "https://s3.../supervisor_sig.png",
  "cargo_photos": [
    "https://s3.../cargo_1.jpg",
    "https://s3.../cargo_2.jpg"
  ],
  "timestamp": "2025-01-30T07:50:00+05:30"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "loading_id": "LOAD-2025-00456",
    "completed_at": "2025-01-30T07:50:00+05:30",
    "items_loaded": 200,
    "ready_for_departure": true
  }
}
```

---

### POST /trips/{trip_id}/start

Start trip (after pre-trip inspection).

**Request:**
```json
{
  "weighbridge": {
    "gvw_kg": 24500,
    "ticket_photo_url": "https://s3.../weighbridge.jpg"
  },
  "gate_pass_verified": true,
  "seal_number": "SL-4521",
  "timestamp": "2025-01-30T08:12:00+05:30",
  "odometer_reading": 145230
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "TRP-2025-00456",
    "status": "in_transit",
    "started_at": "2025-01-30T08:12:00+05:30",
    "eta": "2025-01-30T16:30:00+05:30",
    "route": {
      "waypoints": [...],
      "total_distance_km": 412
    }
  }
}
```

---

### POST /trips/{trip_id}/issues

Report operational issue.

**Request:**
```json
{
  "type": "traffic_jam",
  "location": {
    "lat": 27.1234,
    "lng": 79.5678,
    "description": "NH-19, km 45"
  },
  "expected_delay_minutes": 45,
  "photo_url": "https://s3.../traffic.jpg",
  "notes": "Heavy traffic due to accident ahead",
  "timestamp": "2025-01-30T09:30:00+05:30"
}
```

**Issue Types:**
- `traffic_jam`
- `vehicle_breakdown`
- `road_closure`
- `police_check`
- `accident`
- `customer_issue`
- `weather`
- `other`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "issue_id": "ISS-2025-00789",
    "status": "reported",
    "new_eta": "2025-01-30T17:15:00+05:30",
    "dispatcher_notified": true,
    "customer_notified": true
  }
}
```

---

### PATCH /trips/{trip_id}/destination

Update delivery destination (with approval).

**Request:**
```json
{
  "new_destination": {
    "name": "Naraina Industrial Area",
    "address": "Plot 45, Naraina, Delhi",
    "lat": 28.6234,
    "lng": 77.1345,
    "contact": "+91-9876543211"
  },
  "reason": "customer_request",
  "notes": "Customer warehouse full, redirected to secondary location"
}
```

**Response (202):**
```json
{
  "success": true,
  "data": {
    "change_request_id": "CHG-2025-00123",
    "status": "pending_approval",
    "additional_distance_km": 12,
    "additional_fare_inr": 120
  }
}
```

---

### POST /trips/{trip_id}/unloading/start

Start unloading process.

**Request:**
```json
{
  "arrived_at": "2025-01-30T16:47:00+05:30",
  "location": {
    "lat": 28.6315,
    "lng": 77.1167
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "unloading_id": "UNLD-2025-00456",
    "started_at": "2025-01-30T16:50:00+05:30"
  }
}
```

---

### POST /trips/{trip_id}/damage

Report cargo damage.

**Request:**
```json
{
  "items": [
    {
      "description": "Box #45 - Laptop damaged",
      "photo_urls": ["https://s3.../damage_1.jpg"],
      "damage_type": "broken"
    },
    {
      "description": "Box #78 - Water damage",
      "photo_urls": ["https://s3.../damage_2.jpg"],
      "damage_type": "water_damage"
    }
  ],
  "customer_remarks": "2 laptops damaged",
  "customer_signature": "https://s3.../customer_sig.png",
  "supervisor_signature": "https://s3.../supervisor_sig.png",
  "timestamp": "2025-01-30T17:00:00+05:30"
}
```

**Damage Types:**
- `crushed`
- `water_damage`
- `torn_packaging`
- `missing`
- `broken`
- `other`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "damage_report_id": "DMG-2025-0089",
    "status": "submitted",
    "parties_notified": [
      "fleet_manager",
      "insurance_team",
      "loading_depot"
    ],
    "estimated_deduction_inr": 200
  }
}
```

---

### POST /trips/{trip_id}/complete

Complete trip with PoD.

**Request:**
```json
{
  "items_delivered": 200,
  "items_damaged": 2,
  "pod": {
    "consignee_name": "Vijay Sharma",
    "consignee_phone": "+91-9876543210",
    "signature": "https://s3.../consignee_sig.png",
    "photos": [
      "https://s3.../unloaded_cargo.jpg",
      "https://s3.../empty_truck.jpg",
      "https://s3.../warehouse_gate.jpg"
    ],
    "notes": "Keep invoice copy"
  },
  "odometer_reading": 145642,
  "timestamp": "2025-01-30T17:52:00+05:30"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "TRP-2025-00456",
    "status": "completed",
    "completed_at": "2025-01-30T17:52:00+05:30",
    "summary": {
      "distance_km": 412,
      "duration_hours": 9.67,
      "on_time": true,
      "early_by_minutes": 18
    },
    "earnings": {
      "base_pay": 1200,
      "distance_bonus": 424,
      "on_time_bonus": 100,
      "route_change_bonus": 120,
      "safety_bonus": 150,
      "subtotal": 1994,
      "deductions": {
        "damaged_cargo": -200,
        "status": "under_review"
      },
      "net_earnings": 1794
    }
  }
}
```

---

### GET /trips/history

Get trip history.

**Query Parameters:**
- `page` (default: 1)
- `limit` (default: 20, max: 100)
- `from_date` (ISO date)
- `to_date` (ISO date)
- `status` (completed, cancelled)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "trips": [
      {
        "id": "TRP-2025-00456",
        "date": "2025-01-30",
        "origin": "Kanpur",
        "destination": "Delhi",
        "distance_km": 412,
        "earnings_inr": 1794,
        "status": "completed",
        "safety_score": 94
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 234,
      "has_more": true
    }
  }
}
```

---

## 4. Inspections (alert-service:8006)

### GET /inspections/latest

Get latest pre-trip inspection result (from Aghraan).

**Response (200):**
```json
{
  "success": true,
  "data": {
    "inspection_id": "INS-2025-00456",
    "trip_id": "TRP-2025-00456",
    "timestamp": "2025-01-30T08:00:00+05:30",
    "status": "passed",
    "checks": [
      {
        "component": "tires",
        "camera": "side_left",
        "status": "ok",
        "confidence": 0.95
      },
      {
        "component": "lights_front",
        "camera": "road_front",
        "status": "ok",
        "confidence": 0.92
      },
      {
        "component": "mirrors",
        "camera": "driver_frontal",
        "status": "ok",
        "confidence": 0.89
      }
    ],
    "overall_score": 98,
    "issues": [],
    "photos": {
      "front": "https://...",
      "rear": "https://...",
      "sides": ["https://...", "https://..."]
    }
  }
}
```

---

### POST /inspections/{inspection_id}/override

Override inspection failure (with reason).

**Request:**
```json
{
  "override_reason": "False positive - tire is new, replaced yesterday",
  "photo_url": "https://s3.../tire_closeup.jpg",
  "supervisor_approval": {
    "id": "SUP-123",
    "name": "Rajesh Kumar",
    "signature": "https://s3.../supervisor_sig.png"
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "inspection_id": "INS-2025-00456",
    "status": "passed_with_override",
    "override_logged": true,
    "can_proceed": true
  }
}
```

---

## 5. Documents (driver-service:8002)

### GET /documents

Get all driver documents.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "documents": [
      {
        "id": "DOC-001",
        "type": "driving_license",
        "name": "Driving License",
        "number": "MH-1234567890",
        "issued_by": "RTO Maharashtra",
        "valid_from": "2020-03-15",
        "valid_until": "2027-03-14",
        "status": "verified",
        "source": "digilocker",
        "thumbnail_url": "https://...",
        "document_url": "https://..."
      },
      {
        "id": "DOC-002",
        "type": "aadhar",
        "name": "Aadhaar Card",
        "number": "XXXX-XXXX-1234",
        "status": "verified",
        "source": "digilocker"
      },
      {
        "id": "DOC-003",
        "type": "pan",
        "name": "PAN Card",
        "number": "ABCDE1234F",
        "status": "verified",
        "source": "manual"
      }
    ],
    "pending_uploads": [
      {
        "type": "medical_certificate",
        "name": "Medical Fitness Certificate",
        "required_by": "2025-02-15",
        "reason": "License renewal"
      }
    ]
  }
}
```

---

### POST /documents/upload

Upload document.

**Request (multipart/form-data):**
```
type: "medical_certificate"
file: <binary>
valid_from: "2025-01-30"
valid_until: "2026-01-29"
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "DOC-004",
    "type": "medical_certificate",
    "status": "pending_verification",
    "uploaded_at": "2025-01-30T10:00:00Z"
  }
}
```

---

### GET /documents/digilocker/auth-url

Get DigiLocker OAuth URL.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "auth_url": "https://digilocker.meripehchaan.gov.in/...",
    "state": "state_xyz",
    "expires_in": 300
  }
}
```

---

### POST /documents/digilocker/callback

Handle DigiLocker OAuth callback.

**Request:**
```json
{
  "code": "auth_code_xyz",
  "state": "state_xyz"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "documents_fetched": 3,
    "documents": [
      {
        "type": "driving_license",
        "status": "verified"
      },
      {
        "type": "aadhar",
        "status": "verified"
      },
      {
        "type": "vehicle_rc",
        "status": "verified"
      }
    ]
  }
}
```

---

## 6. Earnings (analytics-service:8008)

### GET /earnings/summary

Get earnings summary.

**Query Parameters:**
- `period`: `today`, `week`, `month`, `custom`
- `from_date`: (for custom)
- `to_date`: (for custom)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "period": {
      "from": "2025-01-01",
      "to": "2025-01-30"
    },
    "summary": {
      "gross_earnings": 52450,
      "deductions": 1200,
      "net_earnings": 51250,
      "pending_approval": 400
    },
    "breakdown": {
      "base_pay": 36000,
      "distance_bonus": 8240,
      "on_time_bonus": 4500,
      "safety_bonus": 3710
    },
    "comparison": {
      "vs_last_period": {
        "percentage": 12.5,
        "direction": "up"
      }
    },
    "trips": {
      "completed": 30,
      "total_distance_km": 8240
    }
  }
}
```

---

### GET /earnings/history

Get earnings history with daily breakdown.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "days": [
      {
        "date": "2025-01-30",
        "trips": 1,
        "gross": 1994,
        "deductions": 200,
        "net": 1794,
        "status": "pending"
      },
      {
        "date": "2025-01-29",
        "trips": 2,
        "gross": 3200,
        "deductions": 0,
        "net": 3200,
        "status": "paid"
      }
    ],
    "pagination": {
      "page": 1,
      "total": 30,
      "has_more": true
    }
  }
}
```

---

### GET /earnings/disputes

Get earnings disputes.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "disputes": [
      {
        "id": "DSP-001",
        "trip_id": "TRP-2025-00456",
        "type": "damage_deduction",
        "amount_disputed": 200,
        "reason": "Damage was pre-existing at loading",
        "evidence_urls": ["https://..."],
        "status": "under_review",
        "created_at": "2025-01-30T18:00:00Z"
      }
    ]
  }
}
```

---

### POST /earnings/disputes

Create earnings dispute.

**Request:**
```json
{
  "trip_id": "TRP-2025-00456",
  "type": "damage_deduction",
  "amount_disputed": 200,
  "reason": "Damage was pre-existing at loading. See photos from loading bay.",
  "evidence_urls": [
    "https://s3.../loading_photo_1.jpg",
    "https://s3.../loading_photo_2.jpg"
  ]
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": "DSP-001",
    "status": "submitted",
    "expected_resolution_by": "2025-02-03"
  }
}
```

---

## 7. Expenses (trip-service:8005)

### GET /expenses

Get expenses list.

**Query Parameters:**
- `status`: `pending`, `approved`, `rejected`
- `from_date`, `to_date`
- `type`: `fuel`, `toll`, `food`, `parking`, `repair`, `other`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "expenses": [
      {
        "id": "EXP-001",
        "type": "fuel",
        "amount": 2400,
        "trip_id": "TRP-2025-00456",
        "location": "HP Pump, NH-19",
        "timestamp": "2025-01-30T12:30:00+05:30",
        "receipt_url": "https://...",
        "status": "approved",
        "source": "manual"
      },
      {
        "id": "EXP-002",
        "type": "toll",
        "amount": 165,
        "trip_id": "TRP-2025-00456",
        "location": "NH-19 Toll Plaza",
        "timestamp": "2025-01-30T11:00:00+05:30",
        "status": "auto_approved",
        "source": "fastag"
      }
    ],
    "summary": {
      "total": 2685,
      "pending": 120,
      "approved": 2565
    }
  }
}
```

---

### POST /expenses

Create expense.

**Request:**
```json
{
  "type": "fuel",
  "amount": 2400,
  "trip_id": "TRP-2025-00456",
  "location": {
    "name": "HP Pump, NH-19",
    "lat": 27.1234,
    "lng": 79.5678
  },
  "receipt_photo_url": "https://s3.../fuel_receipt.jpg",
  "notes": "Filled 25 liters",
  "timestamp": "2025-01-30T12:30:00+05:30"
}
```

**Response (201):**
```json
{
  "success": true,
  "data": {
    "id": "EXP-001",
    "status": "pending",
    "verification": {
      "location_match": true,
      "time_match": true,
      "amount_reasonable": true
    }
  }
}
```

---

### POST /expenses/bulk-sync

Sync multiple offline expenses.

**Request:**
```json
{
  "expenses": [
    {
      "local_id": "local_exp_001",
      "type": "food",
      "amount": 120,
      "timestamp": "2025-01-30T12:45:00+05:30",
      "location": {...}
    },
    {
      "local_id": "local_exp_002",
      "type": "parking",
      "amount": 50,
      "timestamp": "2025-01-30T15:00:00+05:30",
      "location": {...}
    }
  ]
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "synced": 2,
    "failed": 0,
    "results": [
      {
        "local_id": "local_exp_001",
        "server_id": "EXP-003",
        "status": "created"
      },
      {
        "local_id": "local_exp_002",
        "server_id": "EXP-004",
        "status": "created"
      }
    ]
  }
}
```

---

## 8. Alerts (alert-service:8006)

### GET /alerts

Get alerts history.

**Query Parameters:**
- `severity`: `info`, `warning`, `alert`, `critical`
- `acknowledged`: `true`, `false`
- `from_date`, `to_date`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "alerts": [
      {
        "id": "ALT-001",
        "type": "drowsiness",
        "severity": "warning",
        "message": "Signs of fatigue detected. Consider taking a break.",
        "timestamp": "2025-01-30T14:30:00+05:30",
        "trip_id": "TRP-2025-00456",
        "location": {
          "lat": 27.5678,
          "lng": 78.1234
        },
        "evidence": {
          "eye_closure_duration_ms": 1200,
          "yawn_count": 3,
          "video_clip_url": "https://..."
        },
        "acknowledged": false,
        "resolved_at": null
      }
    ],
    "summary": {
      "today": {
        "critical": 0,
        "alert": 1,
        "warning": 2,
        "info": 5
      }
    }
  }
}
```

---

### POST /alerts/{alert_id}/acknowledge

Acknowledge alert.

**Request:**
```json
{
  "action_taken": "took_break",
  "notes": "Stopped for 15 min tea break",
  "timestamp": "2025-01-30T14:45:00+05:30"
}
```

**Actions:**
- `took_break`
- `false_positive`
- `acknowledged`
- `will_stop_soon`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "ALT-001",
    "acknowledged": true,
    "acknowledged_at": "2025-01-30T14:45:00+05:30"
  }
}
```

---

## 9. Chat (chat-service - AI Copilot)

### POST /chat/message

Send message to AI copilot.

**Request:**
```json
{
  "message": "I'm hungry, where can I eat?",
  "context": {
    "location": {
      "lat": 27.5678,
      "lng": 78.1234
    },
    "trip_id": "TRP-2025-00456",
    "timestamp": "2025-01-30T12:30:00+05:30"
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "message_id": "MSG-001",
    "response": "There's a good dhaba 2km ahead on your left - 'Highway Dhaba'. Rated 4.2 stars, average meal costs ₹80-120. Should I navigate you there?",
    "suggestions": [
      {
        "type": "poi",
        "name": "Highway Dhaba",
        "distance_km": 2,
        "rating": 4.2,
        "price_range": "₹80-120",
        "location": {
          "lat": 27.5789,
          "lng": 78.1345
        }
      }
    ],
    "actions": [
      {
        "label": "Navigate",
        "action": "navigate",
        "payload": {
          "lat": 27.5789,
          "lng": 78.1345
        }
      },
      {
        "label": "Find Others",
        "action": "search",
        "payload": {
          "query": "restaurants nearby"
        }
      }
    ]
  }
}
```

---

### GET /chat/history

Get chat history.

**Response (200):**
```json
{
  "success": true,
  "data": {
    "messages": [
      {
        "id": "MSG-001",
        "role": "user",
        "content": "I'm hungry, where can I eat?",
        "timestamp": "2025-01-30T12:30:00+05:30"
      },
      {
        "id": "MSG-002",
        "role": "assistant",
        "content": "There's a good dhaba 2km ahead...",
        "timestamp": "2025-01-30T12:30:02+05:30"
      }
    ]
  }
}
```

---

## 10. Upload (media-service:8007)

### POST /upload/presigned-url

Get presigned URL for S3 upload.

**Request:**
```json
{
  "file_type": "image/jpeg",
  "purpose": "expense_receipt",
  "file_size_bytes": 245000
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "upload_url": "https://s3.ap-south-1.amazonaws.com/devnullx-uploads/...",
    "file_key": "expenses/2025/01/30/DRV-790/receipt_abc123.jpg",
    "public_url": "https://cdn.devnullx.com/expenses/...",
    "expires_in": 3600
  }
}
```

---

## Error Codes Reference

| Code | HTTP | Description |
|------|------|-------------|
| `INVALID_INPUT` | 400 | Validation failed |
| `UNAUTHORIZED` | 401 | Not authenticated |
| `TOKEN_EXPIRED` | 401 | JWT expired |
| `FORBIDDEN` | 403 | Not authorized for resource |
| `NOT_FOUND` | 404 | Resource not found |
| `CONFLICT` | 409 | Resource state conflict |
| `RATE_LIMITED` | 429 | Too many requests |
| `SERVER_ERROR` | 500 | Internal server error |
| `SERVICE_UNAVAILABLE` | 503 | Service temporarily down |

---

## Rate Limits

| Endpoint Category | Limit |
|-------------------|-------|
| Auth endpoints | 10/min |
| Read endpoints | 100/min |
| Write endpoints | 50/min |
| Upload endpoints | 20/min |
| Chat endpoints | 30/min |

---

**Last Updated:** January 2025
