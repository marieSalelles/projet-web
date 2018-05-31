/*insertion de valeur dans la table catégorie*/

INSERT INTO public.categories(
	id, nomcategorie, created_at, updated_at)
	VALUES (2, 'media', '2018-05-20 16:40:37.498978', '2018-05-20 16:48:24.175768');

INSERT INTO public.categories(
	id, nomcategorie, created_at, updated_at)
	VALUES (1, 'high-tech', '2018-05-20 16:40:37.498978', '2018-05-20 16:48:24.175768');
	
INSERT INTO public.categories(
	id, nomcategorie, created_at, updated_at)
	VALUES (3, 'decoration', '2018-05-20 16:45:37.468928', '2018-05-20 16:50:24.785768');



/*trigger enchere : un utilisateur ne peut enchérir que sur un objets qu'il n'a pas proposé à la vente*/

create or replace function notbidsonmyobject() returns trigger as $body$
declare 
uti integer;
begin
select utilisateur_id into uti from objets where id = new.objet_id;
if uti = new.utilisateur_id then 
 RAISE EXCEPTION 'impossile d encherir sur son objet';
end if;
return new;
end;
$body$
language plpgsql;

create trigger enchereonobjet before insert on encheres
for each row
 execute procedure  notbidsonmyobject();

 /*trigger commentaire un utilisateur ne peut se commenter lui-même*/

create or replace function verifidcomment() returns trigger as $body$
begin
if new.utilisateur_id = new.uti_becomment_id then 
 RAISE EXCEPTION 'impossible de se commenter soi-même';
end if;
return new;
end;
$body$
language plpgsql;

create trigger notsameidcomment before insert on commentaires
for each row
 execute procedure  verifidcomment();