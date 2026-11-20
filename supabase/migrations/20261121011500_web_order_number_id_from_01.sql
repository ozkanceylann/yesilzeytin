-- The three existing web_siparisler rows were confirmed as test orders and removed.
-- Preserve no internal UUID column; id is the public order number from web-01 onward.
lock table public.web_siparisler in access exclusive mode;

do $$
begin
  if (select count(*) from public.web_siparisler) <> 3 then
    raise exception 'Order rows changed since confirmation; refusing to delete.';
  end if;
  if (select count(*) from public.web_siparisler where id in (
    '06ae4239-665b-4bd5-97ad-c5c3fe725890'::uuid,
    '3ec98fa6-7b9a-4f62-8b6a-67a0f088daa7'::uuid,
    'f6caaf7d-223d-4979-a053-657895dc7bec'::uuid
  )) <> 3 then
    raise exception 'Expected test rows were not found; refusing to delete.';
  end if;
end
$$;

delete from public.web_siparisler
where id in (
  '06ae4239-665b-4bd5-97ad-c5c3fe725890'::uuid,
  '3ec98fa6-7b9a-4f62-8b6a-67a0f088daa7'::uuid,
  'f6caaf7d-223d-4979-a053-657895dc7bec'::uuid
);

alter table public.web_siparisler drop constraint web_siparisler_pkey;
alter table public.web_siparisler alter column id drop default;
alter table public.web_siparisler alter column id type text using id::text;
alter table public.web_siparisler alter column id set not null;

create sequence public.web_siparisler_id_seq start with 1 increment by 1;
alter sequence public.web_siparisler_id_seq owned by public.web_siparisler.id;
alter table public.web_siparisler
  alter column id set default ('web-'::text || to_char(nextval('public.web_siparisler_id_seq'::regclass), 'FM00'));
alter table public.web_siparisler add constraint web_siparisler_pkey primary key (id);