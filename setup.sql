-- In Supabase SQL Editor einmal ausführen.
create table if not exists public.cup_results (
  match_id text primary key check (match_id ~ '^[ab](5|6|7|8|9|10|11|12|13|14)$'),
  score_a integer check (score_a between 0 and 999),
  score_b integer check (score_b between 0 and 999)
);
create table if not exists public.cup_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.cup_results enable row level security;
alter table public.cup_admins enable row level security;
revoke all on public.cup_admins from anon, authenticated;
grant select on public.cup_admins to authenticated;
grant select on public.cup_results to anon, authenticated;
grant insert, update, delete on public.cup_results to authenticated;
drop policy if exists "Public can view scores" on public.cup_results;
create policy "Public can view scores" on public.cup_results for select to anon, authenticated using (true);
drop policy if exists "Only admins can insert" on public.cup_results;
create policy "Only admins can insert" on public.cup_results for insert to authenticated
  with check (exists (select 1 from public.cup_admins where user_id = (select auth.uid())));
drop policy if exists "Only admins can update" on public.cup_results;
create policy "Only admins can update" on public.cup_results for update to authenticated
  using (exists (select 1 from public.cup_admins where user_id = (select auth.uid())))
  with check (exists (select 1 from public.cup_admins where user_id = (select auth.uid())));
drop policy if exists "Only admins can delete" on public.cup_results;
create policy "Only admins can delete" on public.cup_results for delete to authenticated
  using (exists (select 1 from public.cup_admins where user_id = (select auth.uid())));
drop policy if exists "Users can check own admin status" on public.cup_admins;
create policy "Users can check own admin status" on public.cup_admins for select to authenticated
  using (user_id = (select auth.uid()));

-- ERST NACHDEM du den Admin unter Authentication > Users erstellt hast:
-- Ersetze die Beispiel-E-Mail und führe diese Anweisung im SQL Editor aus.
-- insert into public.cup_admins(user_id)
-- select id from auth.users where email = 'DEINE-ADMIN-EMAIL@example.com'
-- on conflict do nothing;
