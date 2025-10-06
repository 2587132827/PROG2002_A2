const express = require('express');
const router = express.Router();
const { getConnection } = require('../event_db');

router.get('/', (req, res) => {
  const withCount = req.query.with_event_count === 'true';
  if (withCount) {
    const sql = `
      SELECT c.id, c.name, c.slug, COUNT(e.id) AS active_event_count
      FROM event_categories c
      LEFT JOIN events e ON e.category_id = c.id AND e.status = 'active'
      GROUP BY c.id
      ORDER BY c.name ASC
    `;
    getConnection().query(sql, (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json(results);
    });
  } else {
    const sql = `SELECT id, name, slug FROM event_categories ORDER BY name ASC`;
    getConnection().query(sql, (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json(results);
    });
  }
});

module.exports = router;
