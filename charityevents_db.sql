CREATE TABLE organizations (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(200) NOT NULL,
  mission TEXT,
  contact_email VARCHAR(255),
  phone VARCHAR(50),
  website VARCHAR(255),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE event_categories (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(120) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE events (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  org_id BIGINT UNSIGNED NOT NULL,
  category_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(200) NOT NULL,
  purpose VARCHAR(255),
  description TEXT,
  start_datetime DATETIME NOT NULL,
  end_datetime DATETIME NULL,
  venue_name VARCHAR(200),
  address VARCHAR(255),
  city VARCHAR(120),
  state VARCHAR(120),
  postcode VARCHAR(20),
  latitude DECIMAL(9,6),
  longitude DECIMAL(9,6),
  image_url VARCHAR(400),
  featured TINYINT(1) NOT NULL DEFAULT 0,
  ticket_price_cents INT UNSIGNED NOT NULL DEFAULT 0,
  capacity INT UNSIGNED,
  sold INT UNSIGNED NOT NULL DEFAULT 0,
  goal_amount_cents INT UNSIGNED,
  raised_amount_cents INT UNSIGNED NOT NULL DEFAULT 0,
  status ENUM('active','suspended') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_events_org FOREIGN KEY (org_id) REFERENCES organizations(id),
  CONSTRAINT fk_events_cat FOREIGN KEY (category_id) REFERENCES event_categories(id)
);

INSERT INTO organizations (id, name, mission, contact_email, phone, website, created_at, updated_at) VALUES
  (1, 'North River Community Aid', 'Small grants and mutual-aid logistics for rural towns', 'hello@nrcaid.org', '+1-541-555-0134', 'https://nrcaid.org', NOW(), NOW()),
  (2, 'Plainfield Arts Council', 'Micro-funding for neighborhood arts and workshops', 'info@plainfieldarts.org', '+1-765-555-0182', 'https://plainfieldarts.org', NOW(), NOW()),
  (3, 'Harvest Hands Co-op', 'Food-share and after-school snacks program', 'contact@harvesthands.coop', '+1-319-555-0170', 'https://harvesthands.coop', NOW(), NOW()),
  (4, 'Lakeside Literacy Trust', 'Used-books drives and literacy tutoring', 'support@lakesidelit.org', '+1-218-555-0112', 'https://lakesidelit.org', NOW(), NOW()),
  (5, 'Quiet Paws Rescue', 'Foster network for senior pets', 'care@quietpaws.org', '+1-315-555-0158', 'https://quietpaws.org', NOW(), NOW());


INSERT INTO event_categories (id, name, slug, created_at, updated_at) VALUES
  (1, 'Fun Run', 'fun-run', NOW(), NOW()),
  (2, 'Gala', 'gala', NOW(), NOW()),
  (3, 'Auction', 'auction', NOW(), NOW()),
  (4, 'Concert', 'concert', NOW(), NOW()),
  (5, 'Workshop', 'workshop', NOW(), NOW()),
  (6, 'Community Clean-up', 'community-cleanup', NOW(), NOW());


INSERT INTO events
(id, org_id, category_id, name, purpose, description, start_datetime, end_datetime,
 venue_name, address, city, state, postcode, latitude, longitude, image_url, featured,
 ticket_price_cents, capacity, sold, goal_amount_cents, raised_amount_cents, status,
 created_at, updated_at) VALUES
  (1, 1, 6, 'Riverside Litter Walk', 'Tidy the north bank footpath', 'Bring gloves; bags provided by township.',
   '2025-10-10 21:00:00', '2025-10-11 00:00:00',
   'North Footbridge', '12 Ferry Ln', 'Eugene', 'OR', '97401', 44.056000, -123.116000, NULL, 0,
   0, 40, 22, 800, 260, 'active', NOW(), NOW()),
  (2, 4, 5, 'Zine Binding Hour', 'DIY mini-zines for book swap', 'Staple-binding demo plus free supplies.',
   '2025-10-08 06:00:00', '2025-10-08 08:00:00',
   'Lakeside Library Basement A', '101 Willow St', 'Duluth', 'MN', '55802', 46.786000, -92.100000, NULL, 0,
   0, 25, 18, 500, 120, 'active', NOW(), NOW()),
  (3, 3, 5, 'Budget Batch Cooking', 'Share 3 simple recipes', 'Bring a lidded container; tastings after session.',
   '2025-10-15 05:00:00', '2025-10-15 07:00:00',
   'Community Kitchen', '44 Elm Ave', 'Cedar Rapids', 'IA', '52401', 41.978000, -91.665000, NULL, 0,
   500, 30, 16, 1500, 430, 'active', NOW(), NOW()),
  (4, 2, 4, 'Backroom Acoustic Night', 'Support local youth art wall', 'Two duos, unplugged; chairs limited.',
   '2025-10-12 07:00:00', '2025-10-12 09:00:00',
   'Plainfield Grange Hall', '6 Maple Ct', 'Plainfield', 'IN', '46168', 39.704000, -86.399000, NULL, 0,
   1200, 40, 28, 3000, 760, 'active', NOW(), NOW()),
  (5, 5, 5, 'Senior Pet Care Q&A', 'Home care tips for older pets', 'Gentle stretching & grooming basics.',
   '2025-10-07 03:00:00', '2025-10-07 04:30:00',
   'Quiet Paws Foster Hub', '9 Birch Way', 'Utica', 'NY', '13501', 43.100000, -75.232000, NULL, 0,
   0, 18, 12, 600, 210, 'active', NOW(), NOW()),
  (6, 4, 6, 'Trailhead Brush Pickup', 'Clear winter debris', 'Bring a small rake if you have one.',
   '2025-09-29 10:00:00', '2025-09-29 11:00:00',
   'East Overlook Lot', '300 Ridge Rd', 'Superior', 'WI', '54880', 46.720000, -92.104000, NULL, 0,
   0, 50, 50, 700, 740, 'active', NOW(), NOW()),
  (7, 1, 1, 'Low-Key 2K Loop', 'Fund first-aid kits', 'Walkers welcome; no timing chip.',
   '2025-10-18 20:00:00', '2025-10-18 21:00:00',
   'Mill Pond Path', '77 Mill Rd', 'Boise', 'ID', '83702', 43.615000, -116.202000, NULL, 0,
   800, 60, 31, 2500, 680, 'active', NOW(), NOW()),
  (8, 3, 3, 'Quiet Basket Auction', 'After-school snack fund', 'Handmade baskets & vouchers from local cafes.',
   '2025-10-21 05:00:00', '2025-10-21 07:00:00',
   'Parish Hall', '18 Cedar St', 'Des Moines', 'IA', '50309', 41.586000, -93.625000, NULL, 0,
   1500, 70, 22, 5000, 1320, 'active', NOW(), NOW()),
  (9, 2, 5, 'Watercolor Postcards', 'Mini-painting for mail art', 'All ages; paper provided.',
   '2025-10-04 07:00:00', '2025-10-04 09:00:00',
   'Art Room 2', '55 Third St', 'Toledo', 'OH', '43604', 41.653000, -83.537000, NULL, 0,
   300, 24, 21, 1200, 1180, 'active', NOW(), NOW()),
  (10, 5, 4, 'Porch Folk Tunes', 'Foster supplies micro-fund', 'Weather-permitting; bring a folding chair.',
   '2025-10-26 06:00:00', '2025-10-26 08:00:00',
   'Back Porch Stage', '402 Oak Ave', 'Santa Rosa', 'CA', '95401', 38.440000, -122.714000, NULL, 0,
   1000, 45, 19, 4000, 930, 'active', NOW(), NOW()),
  (11, 1, 2, 'Soup & Stories Evening', 'Grocery cards for families', 'Simple supper and short readings.',
   '2025-11-01 06:00:00', '2025-11-01 08:00:00',
   'Scout Hut', '3 Riverbank Rd', 'Spokane', 'WA', '99201', 47.659000, -117.426000, NULL, 0,
   1500, 50, 27, 6000, 1710, 'active', NOW(), NOW()),
  (12, 2, 1, 'Canal Path Jog', 'Footpath repair pot', 'Volunteers set the pace; no medals.',
   '2025-11-03 19:00:00', '2025-11-03 20:00:00',
   'Lock 3 Shelter', '210 Canal St', 'Scranton', 'PA', '18503', 41.408000, -75.662000, NULL, 0,
   600, 40, 0, 2000, 0, 'suspended', NOW(), NOW());
