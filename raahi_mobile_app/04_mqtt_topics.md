# MQTT Topic Structure - Raahi Mobile App

**Version:** 1.0
**Date:** January 2025
**Broker:** AWS IoT Core
**Protocol:** MQTT 3.1.1 over WSS (WebSocket Secure)

---

## Overview

Raahi uses MQTT for real-time communication with the cloud and Aghraan edge device. The app primarily **subscribes** to receive alerts, trip updates, and messages. Publishing is minimal and handled by Aghraan.

### Connection Details

```typescript
const mqttConfig = {
  endpoint: 'wss://xxxxx.iot.ap-south-1.amazonaws.com/mqtt',
  clientId: `raahi-${driverId}-${timestamp}`,
  keepAlive: 60,
  cleanSession: true,
  reconnectPeriod: 5000,
  qos: {
    alerts: 1,      // At least once
    trips: 1,       // At least once
    telemetry: 0,   // At most once (high frequency)
    chat: 1,        // At least once
  }
};
```

---

## Topic Hierarchy

```
raahi/
├── drivers/{driver_id}/
│   ├── alerts              # Safety alerts from Aghraan
│   ├── trips               # Trip assignments, updates
│   ├── earnings            # Earnings updates
│   ├── chat                # AI copilot responses
│   ├── notifications       # General notifications
│   └── commands            # Commands to app
├── vehicles/{vehicle_id}/
│   ├── status              # Vehicle status from Aghraan
│   ├── location            # Real-time GPS (if needed)
│   └── diagnostics         # OBD alerts
└── system/
    └── announcements       # System-wide messages
```

---

## Subscriptions (App Receives)

### 1. Safety Alerts

**Topic:** `raahi/drivers/{driver_id}/alerts`
**QoS:** 1 (At least once)
**Retained:** No

Receives real-time safety alerts from Aghraan IDSS.

**Payload:**
```json
{
  "id": "ALT-2025-00123",
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
    "head_pose_deviation": 15,
    "confidence": 0.89
  },
  "video_clip_url": "https://cdn.devnullx.com/clips/...",
  "requires_acknowledgment": true,
  "auto_escalate_after_seconds": 60
}
```

**Alert Types:**
| Type | Description | Severity |
|------|-------------|----------|
| `drowsiness` | Eye closure, yawning detected | warning/alert/critical |
| `distraction` | Looking away, phone use | warning/alert |
| `speeding` | Speed limit exceeded | warning/alert |
| `harsh_braking` | Sudden deceleration | warning |
| `harsh_acceleration` | Aggressive acceleration | warning |
| `lane_departure` | Drifting out of lane | warning/alert |
| `forward_collision` | Close following distance | alert/critical |
| `no_seatbelt` | Seatbelt not detected | warning |
| `smoking` | Smoking detected | warning |
| `unauthorized_stop` | Unscheduled stop in suspicious area | alert |

**App Handling:**
```typescript
// services/mqtt/handlers.ts
function handleAlert(payload: AlertPayload) {
  // 1. Store in SQLite
  await db.alerts.insert(payload);

  // 2. Update Zustand store
  useAlertsStore.getState().addAlert(payload);

  // 3. Show notification
  if (payload.severity === 'critical') {
    playAlertSound('critical');
    showFullScreenAlert(payload);
  } else {
    showLocalNotification(payload.message);
  }

  // 4. Vibrate for critical
  if (payload.severity === 'critical') {
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Error);
  }
}
```

---

### 2. Trip Updates

**Topic:** `raahi/drivers/{driver_id}/trips`
**QoS:** 1 (At least once)
**Retained:** No

Receives trip assignments, status changes, and updates.

**Payload - New Assignment:**
```json
{
  "type": "assignment",
  "trip": {
    "id": "TRP-2025-00456",
    "origin": {
      "name": "Kanpur Depot",
      "address": "NH-19, Kanpur, UP",
      "lat": 26.4499,
      "lng": 80.3319
    },
    "destination": {
      "name": "Mayapuri Warehouse",
      "address": "Delhi",
      "lat": 28.6315,
      "lng": 77.1167
    },
    "cargo": {
      "type": "Electronics",
      "description": "200 boxes",
      "weight_kg": 12000
    },
    "loading_time": "2025-01-30T06:30:00+05:30",
    "expires_at": "2025-01-30T06:15:00+05:30"
  },
  "timestamp": "2025-01-30T06:00:00+05:30"
}
```

**Payload - Status Update:**
```json
{
  "type": "status_update",
  "trip_id": "TRP-2025-00456",
  "status": "route_changed",
  "data": {
    "new_destination": {
      "name": "Naraina Industrial Area",
      "lat": 28.6234,
      "lng": 77.1345
    },
    "approved_by": "Dispatcher Ramesh",
    "additional_fare": 120
  },
  "timestamp": "2025-01-30T14:30:00+05:30"
}
```

**Payload - ETA Update (from Aghraan):**
```json
{
  "type": "eta_update",
  "trip_id": "TRP-2025-00456",
  "eta": "2025-01-30T16:45:00+05:30",
  "reason": "traffic",
  "delay_minutes": 15,
  "timestamp": "2025-01-30T12:00:00+05:30"
}
```

**Status Update Types:**
- `assignment` - New trip assigned
- `status_update` - Trip status changed
- `eta_update` - ETA recalculated
- `route_changed` - Destination/route modified
- `cancelled` - Trip cancelled
- `customer_update` - Customer info changed

---

### 3. Earnings Updates

**Topic:** `raahi/drivers/{driver_id}/earnings`
**QoS:** 1 (At least once)
**Retained:** No

Real-time earnings notifications.

**Payload - Trip Completed:**
```json
{
  "type": "trip_completed",
  "trip_id": "TRP-2025-00456",
  "earnings": {
    "base_pay": 1200,
    "distance_bonus": 424,
    "on_time_bonus": 100,
    "safety_bonus": 150,
    "gross": 1874,
    "deductions": 0,
    "net": 1874
  },
  "timestamp": "2025-01-30T17:52:00+05:30"
}
```

**Payload - Bonus Earned:**
```json
{
  "type": "bonus",
  "reason": "weekly_safety_bonus",
  "amount": 500,
  "message": "Congratulations! You earned a weekly safety bonus for maintaining 95+ score.",
  "timestamp": "2025-01-30T18:00:00+05:30"
}
```

**Payload - Deduction:**
```json
{
  "type": "deduction",
  "trip_id": "TRP-2025-00456",
  "reason": "damaged_cargo",
  "amount": 200,
  "status": "under_review",
  "can_dispute": true,
  "timestamp": "2025-01-30T18:00:00+05:30"
}
```

---

### 4. AI Chat Responses

**Topic:** `raahi/drivers/{driver_id}/chat`
**QoS:** 1 (At least once)
**Retained:** No

Responses from AI copilot (when processing takes time).

**Payload:**
```json
{
  "message_id": "MSG-2025-00123",
  "in_reply_to": "MSG-2025-00122",
  "response": "There's a good dhaba 2km ahead - Highway Dhaba. Rated 4.2 stars.",
  "suggestions": [
    {
      "type": "poi",
      "name": "Highway Dhaba",
      "distance_km": 2,
      "rating": 4.2,
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
      "payload": { "lat": 27.5789, "lng": 78.1345 }
    }
  ],
  "timestamp": "2025-01-30T12:30:05+05:30"
}
```

---

### 5. General Notifications

**Topic:** `raahi/drivers/{driver_id}/notifications`
**QoS:** 1 (At least once)
**Retained:** No

Non-critical notifications.

**Payload:**
```json
{
  "id": "NOT-2025-00123",
  "type": "document_expiry",
  "title": "License Expiring Soon",
  "body": "Your driving license expires in 30 days. Please renew it.",
  "priority": "medium",
  "action": {
    "type": "navigate",
    "screen": "documents"
  },
  "timestamp": "2025-01-30T09:00:00+05:30"
}
```

**Notification Types:**
- `document_expiry` - Document expiring soon
- `expense_approved` - Expense reimbursement approved
- `expense_rejected` - Expense rejected
- `dispute_resolved` - Earnings dispute resolved
- `shift_reminder` - Shift starting soon
- `break_reminder` - Time for a break
- `weather_alert` - Weather warning on route
- `system_update` - App update available

---

### 6. App Commands

**Topic:** `raahi/drivers/{driver_id}/commands`
**QoS:** 1 (At least once)
**Retained:** No

Commands from fleet manager or system to app.

**Payload - Force Refresh:**
```json
{
  "command": "refresh",
  "target": "trips",
  "reason": "Assignment updated by dispatcher",
  "timestamp": "2025-01-30T10:00:00+05:30"
}
```

**Payload - Emergency Message:**
```json
{
  "command": "emergency_message",
  "title": "Route Alert",
  "message": "Avoid NH-44 near Agra. Accident reported.",
  "priority": "high",
  "show_immediately": true,
  "timestamp": "2025-01-30T11:00:00+05:30"
}
```

**Payload - Force Logout:**
```json
{
  "command": "force_logout",
  "reason": "Session terminated by admin",
  "timestamp": "2025-01-30T12:00:00+05:30"
}
```

**Commands:**
- `refresh` - Refresh specific data
- `emergency_message` - Show important message
- `force_logout` - Logout user
- `request_location` - Request current location
- `start_break` - Mandate break (from IDSS)

---

### 7. Vehicle Status

**Topic:** `raahi/vehicles/{vehicle_id}/status`
**QoS:** 0 (Best effort)
**Retained:** Yes (last known state)

Vehicle status from Aghraan.

**Payload:**
```json
{
  "vehicle_id": "VEH-456",
  "registration": "MH-12-AB-1234",
  "status": "in_transit",
  "engine": "running",
  "speed_kmph": 65,
  "fuel_level_percent": 72,
  "odometer_km": 145420,
  "location": {
    "lat": 27.5678,
    "lng": 78.1234
  },
  "diagnostics": {
    "engine_temp_c": 90,
    "oil_pressure_ok": true,
    "battery_voltage": 13.8,
    "dtc_count": 0
  },
  "aghraan_status": "online",
  "last_update": "2025-01-30T12:30:00+05:30"
}
```

---

### 8. System Announcements

**Topic:** `raahi/system/announcements`
**QoS:** 1 (At least once)
**Retained:** Yes

System-wide announcements for all drivers.

**Payload:**
```json
{
  "id": "ANN-2025-001",
  "title": "Scheduled Maintenance",
  "message": "App will be under maintenance on Feb 1, 2-4 AM IST.",
  "severity": "info",
  "valid_until": "2025-02-01T04:00:00+05:30",
  "timestamp": "2025-01-30T12:00:00+05:30"
}
```

---

## Publications (App Sends)

The app publishes minimally. Most data goes via REST API. MQTT publish is only for:

### 1. Alert Acknowledgment

**Topic:** `raahi/drivers/{driver_id}/alerts/ack`
**QoS:** 1

**Payload:**
```json
{
  "alert_id": "ALT-2025-00123",
  "action_taken": "took_break",
  "notes": "Stopped for tea break",
  "location": {
    "lat": 27.5800,
    "lng": 78.1300
  },
  "timestamp": "2025-01-30T14:45:00+05:30"
}
```

### 2. Heartbeat/Ping

**Topic:** `raahi/drivers/{driver_id}/ping`
**QoS:** 0

**Payload:**
```json
{
  "app_version": "1.2.0",
  "battery_level": 78,
  "network": "4G",
  "location": {
    "lat": 27.5678,
    "lng": 78.1234
  },
  "timestamp": "2025-01-30T12:30:00+05:30"
}
```

**Frequency:** Every 5 minutes when app is active.

---

## QoS Levels

| Topic Pattern | QoS | Rationale |
|---------------|-----|-----------|
| `/alerts` | 1 | Critical - must not be lost |
| `/trips` | 1 | Important - assignments must arrive |
| `/earnings` | 1 | Important for driver trust |
| `/chat` | 1 | User expects responses |
| `/notifications` | 1 | Should not be lost |
| `/commands` | 1 | Must be processed |
| `/status` | 0 | High frequency, loss acceptable |
| `/ping` | 0 | Best effort |

---

## Connection Lifecycle

```typescript
// services/mqtt/client.ts

class MqttClient {
  private client: Paho.Client;
  private reconnectAttempts = 0;
  private maxReconnectAttempts = 10;

  async connect(driverId: string, token: string) {
    // 1. Create client
    this.client = new Paho.Client(
      MQTT_ENDPOINT,
      `raahi-${driverId}-${Date.now()}`
    );

    // 2. Set callbacks
    this.client.onConnectionLost = this.onConnectionLost;
    this.client.onMessageArrived = this.onMessageArrived;

    // 3. Connect
    await this.client.connect({
      useSSL: true,
      userName: 'cognito',
      password: token,
      keepAliveInterval: 60,
      cleanSession: true,
      onSuccess: this.onConnect,
      onFailure: this.onConnectFailure,
    });
  }

  private onConnect = () => {
    console.log('MQTT connected');
    this.reconnectAttempts = 0;
    this.subscribe();
  };

  private onConnectionLost = (error: any) => {
    console.error('MQTT connection lost:', error);
    this.attemptReconnect();
  };

  private attemptReconnect = async () => {
    if (this.reconnectAttempts >= this.maxReconnectAttempts) {
      console.error('Max reconnect attempts reached');
      // Notify user
      return;
    }

    const delay = Math.min(1000 * Math.pow(2, this.reconnectAttempts), 30000);
    this.reconnectAttempts++;

    await sleep(delay);
    await this.connect(this.driverId, await getToken());
  };

  private subscribe() {
    const driverId = useAuthStore.getState().driver.id;
    const vehicleId = useAuthStore.getState().driver.assigned_vehicle_id;

    const topics = [
      { topic: `raahi/drivers/${driverId}/alerts`, qos: 1 },
      { topic: `raahi/drivers/${driverId}/trips`, qos: 1 },
      { topic: `raahi/drivers/${driverId}/earnings`, qos: 1 },
      { topic: `raahi/drivers/${driverId}/chat`, qos: 1 },
      { topic: `raahi/drivers/${driverId}/notifications`, qos: 1 },
      { topic: `raahi/drivers/${driverId}/commands`, qos: 1 },
      { topic: `raahi/vehicles/${vehicleId}/status`, qos: 0 },
      { topic: `raahi/system/announcements`, qos: 1 },
    ];

    topics.forEach(({ topic, qos }) => {
      this.client.subscribe(topic, { qos });
    });
  }

  private onMessageArrived = (message: Paho.Message) => {
    const topic = message.destinationName;
    const payload = JSON.parse(message.payloadString);

    // Route to appropriate handler
    if (topic.includes('/alerts')) {
      handleAlert(payload);
    } else if (topic.includes('/trips')) {
      handleTripUpdate(payload);
    } else if (topic.includes('/earnings')) {
      handleEarningsUpdate(payload);
    } else if (topic.includes('/chat')) {
      handleChatResponse(payload);
    } else if (topic.includes('/notifications')) {
      handleNotification(payload);
    } else if (topic.includes('/commands')) {
      handleCommand(payload);
    } else if (topic.includes('/status')) {
      handleVehicleStatus(payload);
    } else if (topic.includes('/announcements')) {
      handleAnnouncement(payload);
    }
  };
}
```

---

## Offline Handling

When device goes offline:

1. **MQTT disconnects** - Expected behavior
2. **Pending acks stored** - Alert acks saved to SQLite sync queue
3. **On reconnect:**
   - Resubscribe to all topics
   - Process sync queue (send pending acks)
   - App refreshes data via REST API

```typescript
// hooks/useMqtt.ts

export function useMqtt() {
  const isOnline = useNetworkStatus();
  const mqttClient = useMqttClient();

  useEffect(() => {
    if (isOnline) {
      mqttClient.connect();
    } else {
      mqttClient.disconnect();
    }
  }, [isOnline]);

  // ...
}
```

---

## AWS IoT Core Configuration

### Topic Rules

```sql
-- Route alerts to Lambda for persistence
SELECT * FROM 'raahi/drivers/+/alerts'
  WHERE severity IN ('alert', 'critical')

-- Route trip completions to analytics
SELECT * FROM 'raahi/drivers/+/trips'
  WHERE type = 'status_update' AND status = 'completed'
```

### IAM Policy (for Cognito-authenticated drivers)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["iot:Connect"],
      "Resource": "arn:aws:iot:ap-south-1:*:client/raahi-${cognito-identity.amazonaws.com:sub}-*"
    },
    {
      "Effect": "Allow",
      "Action": ["iot:Subscribe"],
      "Resource": [
        "arn:aws:iot:ap-south-1:*:topicfilter/raahi/drivers/${cognito-identity.amazonaws.com:sub}/*",
        "arn:aws:iot:ap-south-1:*:topicfilter/raahi/system/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": ["iot:Receive"],
      "Resource": [
        "arn:aws:iot:ap-south-1:*:topic/raahi/drivers/${cognito-identity.amazonaws.com:sub}/*",
        "arn:aws:iot:ap-south-1:*:topic/raahi/system/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": ["iot:Publish"],
      "Resource": [
        "arn:aws:iot:ap-south-1:*:topic/raahi/drivers/${cognito-identity.amazonaws.com:sub}/alerts/ack",
        "arn:aws:iot:ap-south-1:*:topic/raahi/drivers/${cognito-identity.amazonaws.com:sub}/ping"
      ]
    }
  ]
}
```

---

## Metrics & Monitoring

Track via CloudWatch:

| Metric | Threshold | Alert |
|--------|-----------|-------|
| Connection failures | > 5% | Warning |
| Message latency | > 500ms | Warning |
| Publish failures | > 1% | Error |
| Subscription failures | Any | Error |

---

## Related Documents

- [Mobile App Architecture](./01_mobile_app_architecture.md)
- [Offline Sync Strategy](./06_offline_sync_strategy.md)
- [AWS IoT Core Extended](../03_components/cloud_services/aws_iot_core_extended/)

---

**Last Updated:** January 2025
