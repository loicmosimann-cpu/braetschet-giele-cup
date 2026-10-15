# Brätschet Giele Cup – GitHub Pages + Supabase

## 1. Supabase einrichten
1. Unter https://supabase.com ein kostenloses Projekt erstellen.
2. **SQL Editor** öffnen, Inhalt von `setup.sql` einfügen und ausführen.
3. Unter **Authentication → Users → Add user** einen Admin mit E-Mail und starkem Passwort erstellen. Wenn möglich E-Mail als bestätigt markieren.
4. Die letzte auskommentierte `insert into public.cup_admins ...`-Anweisung aus `setup.sql` mit deiner tatsächlichen Admin-E-Mail (nicht Passwort!) anpassen, die Kommentarzeichen entfernen und im SQL Editor ausführen.
5. Unter **Project Settings → API** die Project URL und den **Publishable Key** (oder Legacy `anon` key) in `config.js` eintragen. **Nie `service_role` oder Secret Key verwenden.**
6. Unter **Authentication → Providers** E-Mail-Anmeldung aktiviert lassen. Öffentliche Registrierungen bei Bedarf unter Authentication-Einstellungen deaktivieren. Zusätzliche Nutzer erhalten ohnehin keine Adminrechte.

## 2. GitHub Pages
1. Auf https://github.com ein neues **öffentliches** Repository anlegen.
2. `index.html`, `config.js`, `setup.sql` und `README.md` hochladen.
3. Repository → **Settings → Pages** → Deploy from a branch → `main` → `/ (root)` → Save.
4. Die angezeigte `https://BENUTZERNAME.github.io/REPOSITORY/`-Adresse teilen.

## 3. Bedienung
- Jeder Besucher sieht die gemeinsamen Resultate und die Rangliste, ohne Login.
- Nur der in `cup_admins` eingetragene Admin kann sich über **Admin-Login** anmelden und Tore eintragen oder löschen.
- Änderungen erscheinen auf anderen Geräten spätestens nach etwa 10 Sekunden (solange die Seite offen ist).
- GitHub Pages hostet nur die Webseite. Die gemeinsamen Resultate liegen in Supabase.
- **Sicherheit:** Das Passwort liegt nur in Supabase Auth, nie im HTML oder Repository. Row Level Security schützt die Daten auch bei direkten API-Aufrufen.

## Wertung und Spielfelder
- **Stube:** Zwei Spieler bilden das erste Team und spielen gemeinsam gegen einen Spieler. Beide Spieler im Zweierteam erhalten bei einem Sieg jeweils 3 Punkte (bei einem Remis je 1 Punkt), der Einzelspieler erhält seine eigenen Punkte.
- **Zimmer:** Ein Spieler gegen einen Spieler.
- Die Tore werden jedem beteiligten Spieler seines Teams zugerechnet. Die Tabelle berechnet Punkte, Tore, Gegentore, Tordifferenz und maximal mögliche Punkte automatisch.
