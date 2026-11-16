revoke all on public.web_siparisler from public, anon, authenticated;
grant insert (ad_soyad, telefon, sehir_ilce, adres, urun, toplam_tutar, odeme_sekli)
  on public.web_siparisler to anon;
grant select, insert, update, delete on public.web_siparisler to service_role;