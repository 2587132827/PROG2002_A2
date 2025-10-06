const mysql = require('mysql2');

const getConnection = () => {
  return mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '123456',
    database: 'charityevents_db',
  });
};

module.exports = { getConnection };
