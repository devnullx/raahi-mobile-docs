-- =============================================================================
-- RAAHI MOBILE APP - SQLite Schema
-- Version: 1.0
-- Date: January 2025
-- Purpose: Offline-first local database for React Native app
-- =============================================================================

-- Enable foreign keys
PRAGMA foreign_keys = ON;

-- =============================================================================
-- CORE TABLES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Driver Profile (cached from server)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS driver (
    id TEXT PRIMARY KEY,                    -- DRV-XXX
    name TEXT NOT NULL,
    phone TEXT NOT NULL,
    email TEXT,
    profile_photo_url TEXT,
    license_number TEXT,
    license_type TEXT,                       -- HMV, LMV
    license_valid_until TEXT,                -- ISO date
    company_id TEXT,
    company_name TEXT,
    assigned_vehicle_id TEXT,
    assigned_vehicle_registration TEXT,
    safety_score INTEGER DEFAULT 0,
    total_trips INTEGER DEFAULT 0,
    preferences_json TEXT,                   -- JSON blob for preferences
    last_synced_at TEXT,                     -- ISO timestamp
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

-- -----------------------------------------------------------------------------
-- Active Shift
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS shift (
    id TEXT PRIMARY KEY,                     -- SFT-XXX
    driver_id TEXT NOT NULL,
    clocked_in_at TEXT NOT NULL,             -- ISO timestamp
    clocked_out_at TEXT,
    depot_name TEXT,
    depot_lat REAL,
    depot_lng REAL,
    status TEXT DEFAULT 'active',            -- active, completed
    total_hours REAL,
    trips_completed INTEGER DEFAULT 0,
    earnings_inr INTEGER DEFAULT 0,
    synced INTEGER DEFAULT 0,                -- 0 = not synced, 1 = synced
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (driver_id) REFERENCES driver(id)
);

CREATE INDEX idx_shift_driver ON shift(driver_id);
CREATE INDEX idx_shift_status ON shift(status);

-- -----------------------------------------------------------------------------
-- Trips
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS trip (
    id TEXT PRIMARY KEY,                     -- TRP-XXX
    driver_id TEXT NOT NULL,
    vehicle_id TEXT,
    vehicle_registration TEXT,
    status TEXT NOT NULL,                    -- assigned, accepted, loading, in_transit, unloading, completed, cancelled

    -- Origin
    origin_name TEXT,
    origin_address TEXT,
    origin_lat REAL,
    origin_lng REAL,

    -- Destination
    destination_name TEXT,
    destination_address TEXT,
    destination_lat REAL,
    destination_lng REAL,

    -- Cargo
    cargo_type TEXT,
    cargo_description TEXT,
    cargo_weight_kg REAL,
    cargo_value_inr INTEGER,
    eway_bill_number TEXT,
    seal_number TEXT,

    -- Consignee
    consignee_name TEXT,
    consignee_contact TEXT,
    consignee_address TEXT,

    -- Timestamps
    assigned_at TEXT,
    accepted_at TEXT,
    loading_started_at TEXT,
    loading_completed_at TEXT,
    started_at TEXT,
    arrived_at TEXT,
    unloading_started_at TEXT,
    completed_at TEXT,

    -- Progress
    distance_km REAL,
    distance_covered_km REAL DEFAULT 0,
    eta TEXT,
    items_loaded INTEGER DEFAULT 0,
    items_expected INTEGER DEFAULT 0,

    -- Results
    odometer_start INTEGER,
    odometer_end INTEGER,
    on_time INTEGER,                         -- 0 or 1
    early_by_minutes INTEGER,

    -- Earnings
    base_pay INTEGER,
    distance_bonus INTEGER,
    on_time_bonus INTEGER,
    safety_bonus INTEGER,
    other_bonus INTEGER,
    gross_earnings INTEGER,
    deductions INTEGER DEFAULT 0,
    net_earnings INTEGER,

    -- Sync
    synced INTEGER DEFAULT 0,
    last_synced_at TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (driver_id) REFERENCES driver(id)
);

CREATE INDEX idx_trip_driver ON trip(driver_id);
CREATE INDEX idx_trip_status ON trip(status);
CREATE INDEX idx_trip_date ON trip(assigned_at);
CREATE INDEX idx_trip_synced ON trip(synced);

-- -----------------------------------------------------------------------------
-- Trip Documents (e-way bills, LR, invoices, PoD)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS trip_document (
    id TEXT PRIMARY KEY,
    trip_id TEXT NOT NULL,
    type TEXT NOT NULL,                      -- eway_bill, loading_receipt, invoice, weighbridge, pod, damage_report
    number TEXT,
    photo_local_path TEXT,                   -- Local file path
    photo_url TEXT,                          -- Uploaded URL
    valid_until TEXT,
    metadata_json TEXT,                      -- Additional data as JSON
    captured_at TEXT,
    uploaded INTEGER DEFAULT 0,              -- 0 = pending upload, 1 = uploaded
    synced INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (trip_id) REFERENCES trip(id)
);

CREATE INDEX idx_trip_document_trip ON trip_document(trip_id);
CREATE INDEX idx_trip_document_uploaded ON trip_document(uploaded);

-- -----------------------------------------------------------------------------
-- Trip Signatures
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS trip_signature (
    id TEXT PRIMARY KEY,
    trip_id TEXT NOT NULL,
    type TEXT NOT NULL,                      -- loading_supervisor, consignee, damage_witness
    signer_name TEXT,
    signer_phone TEXT,
    signature_local_path TEXT,
    signature_url TEXT,
    captured_at TEXT,
    uploaded INTEGER DEFAULT 0,
    synced INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (trip_id) REFERENCES trip(id)
);

CREATE INDEX idx_trip_signature_trip ON trip_signature(trip_id);

-- -----------------------------------------------------------------------------
-- Trip Issues (operational problems during trip)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS trip_issue (
    id TEXT PRIMARY KEY,
    trip_id TEXT NOT NULL,
    type TEXT NOT NULL,                      -- traffic_jam, breakdown, road_closure, police_check, accident, customer_issue, weather, other
    location_lat REAL,
    location_lng REAL,
    location_description TEXT,
    expected_delay_minutes INTEGER,
    photo_local_path TEXT,
    photo_url TEXT,
    notes TEXT,
    reported_at TEXT,
    resolved_at TEXT,
    synced INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (trip_id) REFERENCES trip(id)
);

CREATE INDEX idx_trip_issue_trip ON trip_issue(trip_id);
CREATE INDEX idx_trip_issue_synced ON trip_issue(synced);

-- -----------------------------------------------------------------------------
-- Damage Reports
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS damage_report (
    id TEXT PRIMARY KEY,
    trip_id TEXT NOT NULL,
    item_description TEXT NOT NULL,
    damage_type TEXT,                        -- crushed, water_damage, torn_packaging, missing, broken, other
    photo_local_paths TEXT,                  -- JSON array of paths
    photo_urls TEXT,                         -- JSON array of URLs
    customer_remarks TEXT,
    customer_signature_path TEXT,
    customer_signature_url TEXT,
    supervisor_signature_path TEXT,
    supervisor_signature_url TEXT,
    estimated_deduction_inr INTEGER,
    reported_at TEXT,
    synced INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (trip_id) REFERENCES trip(id)
);

CREATE INDEX idx_damage_report_trip ON damage_report(trip_id);
CREATE INDEX idx_damage_report_synced ON damage_report(synced);

-- =============================================================================
-- EXPENSES
-- =============================================================================

CREATE TABLE IF NOT EXISTS expense (
    id TEXT PRIMARY KEY,                     -- Local: local_exp_XXX, Server: EXP-XXX
    server_id TEXT,                          -- Server ID after sync
    trip_id TEXT,
    driver_id TEXT NOT NULL,
    type TEXT NOT NULL,                      -- fuel, toll, food, parking, repair, other
    amount_inr INTEGER NOT NULL,

    -- Location
    location_name TEXT,
    location_lat REAL,
    location_lng REAL,

    -- Receipt
    receipt_local_path TEXT,
    receipt_url TEXT,

    -- FASTag/API data (for auto-captured expenses)
    source TEXT DEFAULT 'manual',            -- manual, fastag, fuel_api
    transaction_id TEXT,

    -- Fuel specific
    fuel_quantity_liters REAL,
    fuel_rate_per_liter REAL,
    fuel_pump_name TEXT,

    -- Status
    status TEXT DEFAULT 'pending',           -- pending, approved, rejected
    rejection_reason TEXT,
    notes TEXT,

    -- Timestamps
    expense_at TEXT NOT NULL,                -- When expense occurred
    uploaded INTEGER DEFAULT 0,
    synced INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (driver_id) REFERENCES driver(id),
    FOREIGN KEY (trip_id) REFERENCES trip(id)
);

CREATE INDEX idx_expense_driver ON expense(driver_id);
CREATE INDEX idx_expense_trip ON expense(trip_id);
CREATE INDEX idx_expense_type ON expense(type);
CREATE INDEX idx_expense_status ON expense(status);
CREATE INDEX idx_expense_synced ON expense(synced);
CREATE INDEX idx_expense_date ON expense(expense_at);

-- =============================================================================
-- EARNINGS (cached from server)
-- =============================================================================

CREATE TABLE IF NOT EXISTS earnings_summary (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    driver_id TEXT NOT NULL,
    period_type TEXT NOT NULL,               -- day, week, month
    period_start TEXT NOT NULL,              -- ISO date
    period_end TEXT NOT NULL,

    gross_earnings INTEGER,
    deductions INTEGER,
    net_earnings INTEGER,
    pending_approval INTEGER,

    base_pay INTEGER,
    distance_bonus INTEGER,
    on_time_bonus INTEGER,
    safety_bonus INTEGER,

    trips_completed INTEGER,
    total_distance_km INTEGER,

    last_synced_at TEXT,
    created_at TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (driver_id) REFERENCES driver(id),
    UNIQUE(driver_id, period_type, period_start)
);

CREATE INDEX idx_earnings_driver ON earnings_summary(driver_id);
CREATE INDEX idx_earnings_period ON earnings_summary(period_type, period_start);

-- =============================================================================
-- DOCUMENTS (driver documents wallet)
-- =============================================================================

CREATE TABLE IF NOT EXISTS document (
    id TEXT PRIMARY KEY,
    driver_id TEXT NOT NULL,
    type TEXT NOT NULL,                      -- driving_license, aadhar, pan, rc, insurance, medical_certificate, permit
    name TEXT NOT NULL,
    number TEXT,
    issued_by TEXT,
    valid_from TEXT,
    valid_until TEXT,
    status TEXT DEFAULT 'pending',           -- pending, verified, expired, rejected
    source TEXT DEFAULT 'manual',            -- manual, digilocker

    -- Files
    thumbnail_local_path TEXT,
    thumbnail_url TEXT,
    document_local_path TEXT,
    document_url TEXT,

    last_synced_at TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (driver_id) REFERENCES driver(id)
);

CREATE INDEX idx_document_driver ON document(driver_id);
CREATE INDEX idx_document_type ON document(type);
CREATE INDEX idx_document_status ON document(status);
CREATE INDEX idx_document_expiry ON document(valid_until);

-- =============================================================================
-- ALERTS (from Aghraan via MQTT)
-- =============================================================================

CREATE TABLE IF NOT EXISTS alert (
    id TEXT PRIMARY KEY,
    driver_id TEXT NOT NULL,
    trip_id TEXT,
    type TEXT NOT NULL,                      -- drowsiness, distraction, speeding, harsh_braking, lane_departure, forward_collision
    severity TEXT NOT NULL,                  -- info, warning, alert, critical
    message TEXT,

    -- Location
    location_lat REAL,
    location_lng REAL,

    -- Evidence
    evidence_json TEXT,                      -- JSON blob with details
    video_clip_url TEXT,

    -- Status
    acknowledged INTEGER DEFAULT 0,
    acknowledged_at TEXT,
    action_taken TEXT,
    action_notes TEXT,

    received_at TEXT NOT NULL,
    synced INTEGER DEFAULT 1,                -- Usually comes from server
    created_at TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (driver_id) REFERENCES driver(id),
    FOREIGN KEY (trip_id) REFERENCES trip(id)
);

CREATE INDEX idx_alert_driver ON alert(driver_id);
CREATE INDEX idx_alert_trip ON alert(trip_id);
CREATE INDEX idx_alert_severity ON alert(severity);
CREATE INDEX idx_alert_acknowledged ON alert(acknowledged);
CREATE INDEX idx_alert_date ON alert(received_at);

-- =============================================================================
-- AI CHAT HISTORY
-- =============================================================================

CREATE TABLE IF NOT EXISTS chat_message (
    id TEXT PRIMARY KEY,
    driver_id TEXT NOT NULL,
    role TEXT NOT NULL,                      -- user, assistant
    content TEXT NOT NULL,

    -- Context when message was sent
    trip_id TEXT,
    location_lat REAL,
    location_lng REAL,

    -- AI response metadata
    suggestions_json TEXT,                   -- JSON array of suggestions
    actions_json TEXT,                       -- JSON array of actions

    timestamp TEXT NOT NULL,
    synced INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (driver_id) REFERENCES driver(id)
);

CREATE INDEX idx_chat_driver ON chat_message(driver_id);
CREATE INDEX idx_chat_timestamp ON chat_message(timestamp);

-- =============================================================================
-- SYNC QUEUE (for offline operations)
-- =============================================================================

CREATE TABLE IF NOT EXISTS sync_queue (
    id TEXT PRIMARY KEY,
    operation TEXT NOT NULL,                 -- CREATE, UPDATE, DELETE
    entity TEXT NOT NULL,                    -- expense, trip_update, document, damage_report, issue, signature
    entity_id TEXT NOT NULL,                 -- Local ID of the entity
    payload TEXT NOT NULL,                   -- JSON payload to sync
    endpoint TEXT NOT NULL,                  -- API endpoint
    method TEXT NOT NULL,                    -- POST, PUT, PATCH, DELETE

    priority INTEGER DEFAULT 2,              -- 1 = critical, 2 = normal, 3 = low

    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 5,
    last_attempt_at TEXT,
    last_error TEXT,

    status TEXT DEFAULT 'pending',           -- pending, processing, completed, failed
    completed_at TEXT,

    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX idx_sync_queue_status ON sync_queue(status);
CREATE INDEX idx_sync_queue_priority ON sync_queue(priority);
CREATE INDEX idx_sync_queue_entity ON sync_queue(entity, entity_id);

-- =============================================================================
-- APP SETTINGS & CACHE
-- =============================================================================

-- Key-value store for app settings
CREATE TABLE IF NOT EXISTS app_settings (
    key TEXT PRIMARY KEY,
    value TEXT,
    updated_at TEXT DEFAULT (datetime('now'))
);

-- Cached POI data (dhabas, fuel stations, rest stops)
CREATE TABLE IF NOT EXISTS poi_cache (
    id TEXT PRIMARY KEY,
    type TEXT NOT NULL,                      -- restaurant, fuel_station, rest_stop, parking
    name TEXT NOT NULL,
    address TEXT,
    lat REAL NOT NULL,
    lng REAL NOT NULL,
    rating REAL,
    price_range TEXT,
    amenities_json TEXT,                     -- JSON array
    cached_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX idx_poi_type ON poi_cache(type);
CREATE INDEX idx_poi_location ON poi_cache(lat, lng);

-- Cached route data
CREATE TABLE IF NOT EXISTS route_cache (
    id TEXT PRIMARY KEY,
    origin_lat REAL NOT NULL,
    origin_lng REAL NOT NULL,
    destination_lat REAL NOT NULL,
    destination_lng REAL NOT NULL,
    waypoints_json TEXT,                     -- JSON array
    polyline TEXT,
    distance_km REAL,
    duration_minutes REAL,
    cached_at TEXT DEFAULT (datetime('now'))
);

-- =============================================================================
-- FILE UPLOAD QUEUE
-- =============================================================================

CREATE TABLE IF NOT EXISTS upload_queue (
    id TEXT PRIMARY KEY,
    local_path TEXT NOT NULL,
    file_type TEXT NOT NULL,                 -- image/jpeg, image/png
    purpose TEXT NOT NULL,                   -- expense_receipt, trip_photo, document, signature
    entity_type TEXT,                        -- expense, trip, document
    entity_id TEXT,

    upload_url TEXT,                         -- Presigned URL
    public_url TEXT,                         -- Final public URL after upload

    file_size_bytes INTEGER,
    status TEXT DEFAULT 'pending',           -- pending, uploading, completed, failed
    retry_count INTEGER DEFAULT 0,
    last_error TEXT,

    created_at TEXT DEFAULT (datetime('now')),
    completed_at TEXT
);

CREATE INDEX idx_upload_queue_status ON upload_queue(status);
CREATE INDEX idx_upload_queue_entity ON upload_queue(entity_type, entity_id);

-- =============================================================================
-- NOTIFICATIONS (local + push)
-- =============================================================================

CREATE TABLE IF NOT EXISTS notification (
    id TEXT PRIMARY KEY,
    type TEXT NOT NULL,                      -- trip_assignment, alert, earnings, document_expiry, break_reminder
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    data_json TEXT,                          -- Payload for deep linking

    read INTEGER DEFAULT 0,
    read_at TEXT,

    received_at TEXT NOT NULL,
    created_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX idx_notification_type ON notification(type);
CREATE INDEX idx_notification_read ON notification(read);
CREATE INDEX idx_notification_date ON notification(received_at);

-- =============================================================================
-- SCHEMA VERSION (for migrations)
-- =============================================================================

CREATE TABLE IF NOT EXISTS schema_version (
    version INTEGER PRIMARY KEY,
    applied_at TEXT DEFAULT (datetime('now'))
);

-- Insert initial version
INSERT OR IGNORE INTO schema_version (version) VALUES (1);

-- =============================================================================
-- TRIGGERS
-- =============================================================================

-- Update timestamp trigger for trip
CREATE TRIGGER IF NOT EXISTS update_trip_timestamp
AFTER UPDATE ON trip
BEGIN
    UPDATE trip SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- Update timestamp trigger for expense
CREATE TRIGGER IF NOT EXISTS update_expense_timestamp
AFTER UPDATE ON expense
BEGIN
    UPDATE expense SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- Update timestamp trigger for document
CREATE TRIGGER IF NOT EXISTS update_document_timestamp
AFTER UPDATE ON document
BEGIN
    UPDATE document SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- =============================================================================
-- VIEWS
-- =============================================================================

-- View: Pending sync items count
CREATE VIEW IF NOT EXISTS v_sync_pending AS
SELECT
    entity,
    COUNT(*) as count
FROM sync_queue
WHERE status = 'pending'
GROUP BY entity;

-- View: Today's earnings
CREATE VIEW IF NOT EXISTS v_today_earnings AS
SELECT
    driver_id,
    SUM(net_earnings) as total_earnings,
    COUNT(*) as trips_count,
    SUM(distance_km) as total_distance
FROM trip
WHERE date(completed_at) = date('now')
AND status = 'completed'
GROUP BY driver_id;

-- View: Pending uploads
CREATE VIEW IF NOT EXISTS v_pending_uploads AS
SELECT
    purpose,
    COUNT(*) as count,
    SUM(file_size_bytes) as total_bytes
FROM upload_queue
WHERE status = 'pending'
GROUP BY purpose;

-- View: Unacknowledged alerts
CREATE VIEW IF NOT EXISTS v_unacknowledged_alerts AS
SELECT *
FROM alert
WHERE acknowledged = 0
ORDER BY
    CASE severity
        WHEN 'critical' THEN 1
        WHEN 'alert' THEN 2
        WHEN 'warning' THEN 3
        ELSE 4
    END,
    received_at DESC;

-- =============================================================================
-- SAMPLE DATA (for development/testing)
-- =============================================================================

-- Uncomment for testing:
/*
INSERT INTO driver (id, name, phone, company_name, safety_score, total_trips)
VALUES ('DRV-790', 'Ramesh Kumar', '+919876543210', 'ABC Logistics', 94, 234);

INSERT INTO app_settings (key, value) VALUES
('language', 'hi'),
('notifications_enabled', 'true'),
('voice_enabled', 'true'),
('last_sync_at', datetime('now'));
*/

-- =============================================================================
-- END OF SCHEMA
-- =============================================================================
