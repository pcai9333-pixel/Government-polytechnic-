-- Run this in Supabase SQL Editor.
create table if not exists public.payment_submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null,
  register_number text not null,
  department text not null,
  year text not null,
  section text not null,
  academic_year text not null default '2026-27',
  amount numeric not null,
  payment_method text not null default 'UPI',
  upi_reference text not null,
  status text not null default 'marked_for_verification'
);

alter table public.payment_submissions enable row level security;

-- Students can submit a payment record but cannot read the whole table.
create policy "allow public payment submissions"
on public.payment_submissions
for insert
to anon, authenticated
with check (
  amount > 0
  and length(trim(name)) between 1 and 120
  and length(trim(register_number)) between 1 and 50
  and length(trim(upi_reference)) between 1 and 120
);

-- Admin reads are controlled by Supabase Auth.
-- After creating the admin user in Authentication, create a policy for the admin.
-- Replace ADMIN-USER-UUID with that user's UUID:
create policy "admin can read payment submissions"
on public.payment_submissions
for select
to authenticated
using (auth.uid() = 'ADMIN-USER-UUID');

-- Optional: admin can update verification status.
create policy "admin can update payment submissions"
on public.payment_submissions
for update
to authenticated
using (auth.uid() = 'ADMIN-USER-UUID')
with check (auth.uid() = 'ADMIN-USER-UUID');
