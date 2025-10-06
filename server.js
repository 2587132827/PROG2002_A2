const express = require('express');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(express.json());

// import routes
const orgRouter = require('./routes/organizations');
const catRouter = require('./routes/categories');
const eventsRouter = require('./routes/events');

app.use('/api/organizations', orgRouter);
app.use('/api/categories', catRouter);
app.use('/api/events', eventsRouter);

app.use(express.static(path.join(__dirname, 'static')));

app.listen(PORT, () => {
  console.log(`Server start at http://localhost:${PORT}`);
});

