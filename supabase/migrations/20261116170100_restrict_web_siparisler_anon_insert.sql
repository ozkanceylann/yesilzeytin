alter table public.web_siparisler
  add constraint web_siparisler_web_catalog_check check (
    (urun = 'Zeytin - 1 kg orta boy - 300 TL' and toplam_tutar = 300)
    or (urun = 'Zeytin - 2 kg orta boy - 500 TL' and toplam_tutar = 500)
    or (urun = 'Zeytin - 5 kg orta boy - 800 TL' and toplam_tutar = 800)
    or (urun = 'Zeytin - 10 kg orta boy - 1300 TL' and toplam_tutar = 1300)
    or (urun = 'Zeytin - 10 kg iri boy - 1700 TL' and toplam_tutar = 1700)
  );
revoke insert on public.web_siparisler from public, anon, authenticated;
grant insert (ad_soyad, telefon, sehir_ilce, adres, urun, toplam_tutar, odeme_sekli)
  on public.web_siparisler to anon;
alter policy "Website visitors can submit orders"
on public.web_siparisler
with check (
  char_length(trim(ad_soyad)) between 2 and 160
  and telefon ~ '^05[0-9]{9}$'
  and char_length(trim(adres)) between 5 and 1000
  and char_length(trim(urun)) between 2 and 300
  and toplam_tutar >= 0
  and odeme_sekli in ('Kapıda Nakit Ödeme', 'Kapıda Kredi Kartı İle')
  and kaynak = 'yesilzeytin_web'
  and durum = 'Yeni'
);