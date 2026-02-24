const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (_, res) => {
  res.send('🚀 Hello from a clean Docker image!');
});

app.listen(PORT, () => {
  console.log(`App running on http://localhost:${PORT}`);
});// Alteração Fri Jun 27 19:02:47 -03 2025 para quebrar cache
// Nova alteração Fri Jun 27 19:03:44 -03 2025
// Nova alteração 2 Fri Jun 27 19:04:44 -03 2025
