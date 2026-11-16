create table public.web_siparisler (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  ad_soyad text not null check (char_length(trim(ad_soyad)) between 2 and 160),
  telefon text not null check (telefon ~ '^05[0-9]{9}$'),
  sehir_ilce text,
  adres text not null check (char_length(trim(adres)) between 5 and 1000),
  urun text not null check (char_length(trim(urun)) between 2 and 300),
  toplam_tutar integer not null check (toplam_tutar >= 0),
  odeme_sekli text not null check (odeme_sekli in ('Kapıda Nakit Ödeme', 'Kapıda Kredi Kartı İle')),
  kaynak text not null default 'yesilzeytin_web' check (char_length(kaynak) <= 80),
  durum text not null default 'Yeni' check (char_length(durum) <= 40)
);

create index web_siparisler_created_at_idx on public.web_siparisler (created_at desc);
alter table public.web_siparisler enable row level security;
grant insert on public.web_siparisler to anon;
grant select, insert, update, delete on public.web_siparisler to service_role;
create policy "Website visitors can submit orders"
on public.web_siparisler for insert to anon
with check (
  char_length(trim(ad_soyad)) between 2 and 160
  and telefon ~ '^05[0-9]{9}$'
  and char_length(trim(adres)) between 5 and 1000
  and char_length(trim(urun)) between 2 and 300
  and toplam_tutar >= 0
  and odeme_sekli in ('Kapıda Nakit Ödeme', 'Kapıda Kredi Kartı İle')
);