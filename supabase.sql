-- Kata Sprint leaderboard. Paste into Supabase → SQL Editor → Run.
create table public.scores (
  id         bigint generated always as identity primary key,
  name       text not null check (char_length(trim(name)) between 1 and 20),
  score      integer not null check (score between 1 and 12000),
  level      text not null check (level in ('easy', 'medium', 'hard', 'super')),
  lang       text not null check (lang in ('ms', 'en', 'mix')),
  correct    integer not null check (correct between 0 and 12),
  created_at timestamptz not null default now()
);

create index scores_board_idx on public.scores (level, lang, score desc);

-- Anyone can read the board and add a score; nobody can edit or delete from the game.
alter table public.scores enable row level security;

create policy "Anyone can read scores"
  on public.scores for select to anon, authenticated using (true);

create policy "Anyone can add a score"
  on public.scores for insert to anon, authenticated with check (true);
