alter table public.web_siparisler
  drop constraint if exists web_siparisler_web_catalog_check;

alter table public.web_siparisler
  add constraint web_siparisler_web_catalog_check check (
    (urun = 'Yeşil Zeytin - 1 kg orta boy - 300 TL + 50 TL Kargo' and toplam_tutar = 350 and kargo_tutar = 50)
    or (urun = 'Yeşil Zeytin - 2 kg orta boy - 500 TL' and toplam_tutar = 500 and kargo_tutar = 0)
    or (urun = 'Yeşil Zeytin - 5 kg orta boy - 800 TL' and toplam_tutar = 800 and kargo_tutar = 0)
    or (urun = 'Yeşil Zeytin - 10 kg orta boy - 1300 TL' and toplam_tutar = 1300 and kargo_tutar = 0)
    or (urun = 'Yeşil Zeytin - 10 kg iri boy - 1700 TL' and toplam_tutar = 1700 and kargo_tutar = 0)
    or (urun = 'Zeytinyağı - 5 litre soğuk sıkım premium zeytinyağı - 1700 TL' and toplam_tutar = 1700 and kargo_tutar = 0)
    or (urun = 'Tanışma Paketi - (Vakumlu) 10 çeşit tanışma paketi - 1500 TL (toplam 5 kg)' and toplam_tutar = 1500 and kargo_tutar = 0)
    or (urun = 'Tanışma Paketi - (Bidonlu) 10 çeşit tanışma paketi - 1700 TL' and toplam_tutar = 1700 and kargo_tutar = 0)
  );
