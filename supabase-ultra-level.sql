-- Run once in Supabase → SQL Editor to allow the Super Duper Hard level.
alter table public.scores drop constraint scores_level_check;
alter table public.scores add constraint scores_level_check
  check (level in ('easy', 'medium', 'hard', 'super', 'ultra'));

alter table public.scores drop constraint scores_score_check;
alter table public.scores add constraint scores_score_check
  check (score between 1 and 30000);
