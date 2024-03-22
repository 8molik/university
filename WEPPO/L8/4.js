const express = require('express');
const app = express();

app.get('/', (req, res) => {
  // Ustawianie ciasteczka
  res.setHeader('Set-Cookie', 'example=HelloCookie');
  
  // Odczytywanie ciasteczka
  const cookieValue = req.headers.cookie || 'Brak ciasteczka';

  // Usuwanie ciasteczka poprzez ustawienie Max-Age na -1
  res.setHeader('Set-Cookie', 'example=; Max-Age=-1');

  // Sprawdzanie czy przeglądarka obsługuje ciasteczka po stronie klienta
  const isCookieEnabled = req.headers.cookie !== undefined;

  //navigator.cookieEnabled
});

app.listen(3000)
