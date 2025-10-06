const express = require('express');

const app = express();
const PORT = 5000;

app.listen(PORT, () => {
  console.log(`Server start at http://localhost:${PORT}`);
});

