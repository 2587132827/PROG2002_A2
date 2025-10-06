const express = require('express');
const router = express.Router();
const { getConnection } = require('../event_db');

router.get('/', (req, res) => {
  const sql = `SELECT id, name, mission, contact_email, phone, website FROM organizations`;
  getConnection().query(sql, (err, results) => {
    if (err){
      return res.status(500).json({ error: err.message });
    }
    res.json(results);
  });
});

module.exports = router;
