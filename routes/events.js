const express = require('express');
const router = express.Router();
const { getConnection } = require('../event_db');

// 工具函数：判断是否 past
const isPast = (endDatetime) => {
  if (!endDatetime) return false;
  const now = new Date();
  return new Date(endDatetime) < now;
};

// GET /api/events
router.get('/', (req, res) => {
  const { date, city, state, category_id, status, featured } = req.query;

  let conditions = ["e.status != 'suspended'"];
  let params = [];

  // date filter
  if (date) {
    conditions.push("e.start_datetime <= ? AND e.end_datetime >= ?");
    params.push(date, date);
  }

  // city/state filter
  if (city) {
    conditions.push("e.city LIKE ?");
    params.push(`%${city}%`);
  }
  if (state) {
    conditions.push("e.state LIKE ?");
    params.push(`%${state}%`);
  }

  // category filter
  if (category_id) {
    conditions.push("e.category_id = ?");
    params.push(category_id);
  }

  // featured
  if (featured === 'true') {
    conditions.push("e.featured = 1");
  }

  // status: upcoming/past/active
  const now = new Date();
  if (status === 'past') {
    conditions.push("e.end_datetime < ?");
    params.push(now);
  } else if (status === 'upcoming') {
    conditions.push("(e.end_datetime IS NULL OR e.end_datetime >= ?)");
    params.push(now);
  }

  const sql = `
    SELECT e.*, c.name AS category, o.name AS organization
    FROM events e
    JOIN event_categories c ON e.category_id = c.id
    JOIN organizations o ON e.org_id = o.id
    WHERE ${conditions.join(" AND ")}
    ORDER BY e.start_datetime ASC
  `;

  getConnection().query(sql, params, (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }

    const data = results.map((event) => ({
      ...event,
      ticket_price: event.ticket_price_cents / 100,
      goal_amount: event.goal_amount_cents / 100,
      raised_amount: event.raised_amount_cents / 100,
      is_past: isPast(event.end_datetime),
    }));

    res.json(data);
  });
});


// GET /api/events/:id
router.get('/:id', (req, res) => {
  const sql = `
    SELECT e.*, c.name AS category, o.name AS organization, o.mission, o.contact_email, o.phone
    FROM events e
    JOIN event_categories c ON e.category_id = c.id
    JOIN organizations o ON e.org_id = o.id
    WHERE e.id = ?
  `;
  getConnection().query(sql, [req.params.id], (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    if (results.length === 0) {
      return res.status(404).json({ error: "Event not found" });
    }

    const event = results[0];
    res.json({
      ...event,
      ticket_price: event.ticket_price_cents / 100,
      goal_amount: event.goal_amount_cents / 100,
      raised_amount: event.raised_amount_cents / 100,
      is_past: isPast(event.end_datetime),
      category: { id: event.category_id, name: event.category },
      organization: {
        id: event.org_id,
        name: event.organization,
        mission: event.mission,
        contact_email: event.contact_email,
        phone: event.phone
      }
    });
  });
});

module.exports = router;
