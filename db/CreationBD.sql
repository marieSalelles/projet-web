--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3 (Ubuntu 10.3-1.pgdg14.04+1)
-- Dumped by pg_dump version 10.1

-- Started on 2018-05-29 20:31:07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 217 (class 1255 OID 21833990)
-- Name: notbidsonmyobject(); Type: FUNCTION; Schema: public; Owner: xjkigakxleujhr
--

CREATE FUNCTION notbidsonmyobject() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 
uti integer;
begin
select utilisateur_id into uti from objets where id = new.objet_id;
if uti = new.utilisateur_id then 
 RAISE EXCEPTION 'impossile d encherir sur son objet';
end if;
return new;
end;
$$;


ALTER FUNCTION public.notbidsonmyobject() OWNER TO xjkigakxleujhr;

--
-- TOC entry 219 (class 1255 OID 21833916)
-- Name: verifidcomment(); Type: FUNCTION; Schema: public; Owner: xjkigakxleujhr
--

CREATE FUNCTION verifidcomment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
begin
if new.utilisateur_id = new.uti_becomment_id then 
 RAISE EXCEPTION 'impossible de se commenter soi-même';
end if;
return new;
end;
$$;


ALTER FUNCTION public.verifidcomment() OWNER TO xjkigakxleujhr;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 21306465)
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: xjkigakxleujhr
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO xjkigakxleujhr;

--
-- TOC entry 199 (class 1259 OID 21306475)
-- Name: categories; Type: TABLE; Schema: public; Owner: xjkigakxleujhr
--

CREATE TABLE categories (
    id bigint NOT NULL,
    nomcategorie character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE categories OWNER TO xjkigakxleujhr;

--
-- TOC entry 198 (class 1259 OID 21306473)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: xjkigakxleujhr
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO xjkigakxleujhr;

--
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 198
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xjkigakxleujhr
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- TOC entry 207 (class 1259 OID 21551231)
-- Name: commentaires; Type: TABLE; Schema: public; Owner: xjkigakxleujhr
--

CREATE TABLE commentaires (
    id bigint NOT NULL,
    uti_becomment_id bigint,
    utilisateur_id bigint,
    datecomment timestamp without time zone,
    commentaire text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE commentaires OWNER TO xjkigakxleujhr;

--
-- TOC entry 206 (class 1259 OID 21551229)
-- Name: commentaires_id_seq; Type: SEQUENCE; Schema: public; Owner: xjkigakxleujhr
--

CREATE SEQUENCE commentaires_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE commentaires_id_seq OWNER TO xjkigakxleujhr;

--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 206
-- Name: commentaires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xjkigakxleujhr
--

ALTER SEQUENCE commentaires_id_seq OWNED BY commentaires.id;


--
-- TOC entry 205 (class 1259 OID 21551208)
-- Name: encheres; Type: TABLE; Schema: public; Owner: xjkigakxleujhr
--

CREATE TABLE encheres (
    id bigint NOT NULL,
    objet_id bigint,
    utilisateur_id bigint,
    dateench timestamp without time zone,
    prix numeric,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE encheres OWNER TO xjkigakxleujhr;

--
-- TOC entry 204 (class 1259 OID 21551206)
-- Name: encheres_id_seq; Type: SEQUENCE; Schema: public; Owner: xjkigakxleujhr
--

CREATE SEQUENCE encheres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE encheres_id_seq OWNER TO xjkigakxleujhr;

--
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 204
-- Name: encheres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xjkigakxleujhr
--

ALTER SEQUENCE encheres_id_seq OWNED BY encheres.id;


--
-- TOC entry 203 (class 1259 OID 21551185)
-- Name: objets; Type: TABLE; Schema: public; Owner: xjkigakxleujhr
--

CREATE TABLE objets (
    id bigint NOT NULL,
    nomobjet character varying,
    prix numeric,
    photo character varying,
    description text,
    datefinench timestamp without time zone,
    categorie_id bigint,
    utilisateur_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE objets OWNER TO xjkigakxleujhr;

--
-- TOC entry 202 (class 1259 OID 21551183)
-- Name: objets_id_seq; Type: SEQUENCE; Schema: public; Owner: xjkigakxleujhr
--

CREATE SEQUENCE objets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE objets_id_seq OWNER TO xjkigakxleujhr;

--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 202
-- Name: objets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xjkigakxleujhr
--

ALTER SEQUENCE objets_id_seq OWNED BY objets.id;


--
-- TOC entry 196 (class 1259 OID 21306457)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: xjkigakxleujhr
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO xjkigakxleujhr;

--
-- TOC entry 201 (class 1259 OID 21551174)
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: xjkigakxleujhr
--

CREATE TABLE utilisateurs (
    id bigint NOT NULL,
    nomuti character varying,
    prenomuti character varying,
    login character varying,
    password_digest character varying,
    age integer,
    rue character varying,
    codepostal integer,
    ville character varying,
    remember_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE utilisateurs OWNER TO xjkigakxleujhr;

--
-- TOC entry 200 (class 1259 OID 21551172)
-- Name: utilisateurs_id_seq; Type: SEQUENCE; Schema: public; Owner: xjkigakxleujhr
--

CREATE SEQUENCE utilisateurs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE utilisateurs_id_seq OWNER TO xjkigakxleujhr;

--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 200
-- Name: utilisateurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: xjkigakxleujhr
--

ALTER SEQUENCE utilisateurs_id_seq OWNED BY utilisateurs.id;


--
-- TOC entry 3595 (class 2604 OID 21306478)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- TOC entry 3599 (class 2604 OID 21551234)
-- Name: commentaires id; Type: DEFAULT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY commentaires ALTER COLUMN id SET DEFAULT nextval('commentaires_id_seq'::regclass);


--
-- TOC entry 3598 (class 2604 OID 21551211)
-- Name: encheres id; Type: DEFAULT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY encheres ALTER COLUMN id SET DEFAULT nextval('encheres_id_seq'::regclass);


--
-- TOC entry 3597 (class 2604 OID 21551188)
-- Name: objets id; Type: DEFAULT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY objets ALTER COLUMN id SET DEFAULT nextval('objets_id_seq'::regclass);


--
-- TOC entry 3596 (class 2604 OID 21551177)
-- Name: utilisateurs id; Type: DEFAULT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY utilisateurs ALTER COLUMN id SET DEFAULT nextval('utilisateurs_id_seq'::regclass);


--
-- TOC entry 3603 (class 2606 OID 21306472)
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- TOC entry 3605 (class 2606 OID 21306483)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3617 (class 2606 OID 21551239)
-- Name: commentaires commentaires_pkey; Type: CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY commentaires
    ADD CONSTRAINT commentaires_pkey PRIMARY KEY (id);


--
-- TOC entry 3613 (class 2606 OID 21551216)
-- Name: encheres encheres_pkey; Type: CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY encheres
    ADD CONSTRAINT encheres_pkey PRIMARY KEY (id);


--
-- TOC entry 3611 (class 2606 OID 21551193)
-- Name: objets objets_pkey; Type: CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY objets
    ADD CONSTRAINT objets_pkey PRIMARY KEY (id);


--
-- TOC entry 3601 (class 2606 OID 21306464)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3607 (class 2606 OID 21551182)
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id);


--
-- TOC entry 3618 (class 1259 OID 21551240)
-- Name: index_commentaires_on_uti_becomment_id; Type: INDEX; Schema: public; Owner: xjkigakxleujhr
--

CREATE INDEX index_commentaires_on_uti_becomment_id ON public.commentaires USING btree (uti_becomment_id);


--
-- TOC entry 3619 (class 1259 OID 21551241)
-- Name: index_commentaires_on_utilisateur_id; Type: INDEX; Schema: public; Owner: xjkigakxleujhr
--

CREATE INDEX index_commentaires_on_utilisateur_id ON public.commentaires USING btree (utilisateur_id);


--
-- TOC entry 3614 (class 1259 OID 21551227)
-- Name: index_encheres_on_objet_id; Type: INDEX; Schema: public; Owner: xjkigakxleujhr
--

CREATE INDEX index_encheres_on_objet_id ON public.encheres USING btree (objet_id);


--
-- TOC entry 3615 (class 1259 OID 21551228)
-- Name: index_encheres_on_utilisateur_id; Type: INDEX; Schema: public; Owner: xjkigakxleujhr
--

CREATE INDEX index_encheres_on_utilisateur_id ON public.encheres USING btree (utilisateur_id);


--
-- TOC entry 3608 (class 1259 OID 21551204)
-- Name: index_objets_on_categorie_id; Type: INDEX; Schema: public; Owner: xjkigakxleujhr
--

CREATE INDEX index_objets_on_categorie_id ON public.objets USING btree (categorie_id);


--
-- TOC entry 3609 (class 1259 OID 21551205)
-- Name: index_objets_on_utilisateur_id; Type: INDEX; Schema: public; Owner: xjkigakxleujhr
--

CREATE INDEX index_objets_on_utilisateur_id ON public.objets USING btree (utilisateur_id);


--
-- TOC entry 3624 (class 2620 OID 21833991)
-- Name: encheres enchereonobjet; Type: TRIGGER; Schema: public; Owner: xjkigakxleujhr
--

CREATE TRIGGER enchereonobjet BEFORE INSERT ON public.encheres FOR EACH ROW EXECUTE PROCEDURE notbidsonmyobject();


--
-- TOC entry 3625 (class 2620 OID 21833927)
-- Name: commentaires notsameidcomment; Type: TRIGGER; Schema: public; Owner: xjkigakxleujhr
--

CREATE TRIGGER notsameidcomment BEFORE INSERT ON public.commentaires FOR EACH ROW EXECUTE PROCEDURE verifidcomment();


--
-- TOC entry 3622 (class 2606 OID 21551217)
-- Name: encheres fk_rails_151e964de4; Type: FK CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY encheres
    ADD CONSTRAINT fk_rails_151e964de4 FOREIGN KEY (objet_id) REFERENCES objets(id);


--
-- TOC entry 3621 (class 2606 OID 21551199)
-- Name: objets fk_rails_23cc4f0872; Type: FK CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY objets
    ADD CONSTRAINT fk_rails_23cc4f0872 FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id);


--
-- TOC entry 3620 (class 2606 OID 21551194)
-- Name: objets fk_rails_c1416224c1; Type: FK CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY objets
    ADD CONSTRAINT fk_rails_c1416224c1 FOREIGN KEY (categorie_id) REFERENCES categories(id);


--
-- TOC entry 3623 (class 2606 OID 21551222)
-- Name: encheres fk_rails_d5f19628e2; Type: FK CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY encheres
    ADD CONSTRAINT fk_rails_d5f19628e2 FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id);


--
-- TOC entry 3623 (class 2606 OID 21551222)
-- Name: encheres fk_rails_d45e7f4630; Type: FK CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY commentaires
    ADD CONSTRAINT fk_rails_d45e7f4630 FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id);


--
-- TOC entry 3623 (class 2606 OID 21551222)
-- Name: encheres fk_rails_ef30c43e79; Type: FK CONSTRAINT; Schema: public; Owner: xjkigakxleujhr
--

ALTER TABLE ONLY commentaires
    ADD CONSTRAINT fk_rails_ef30c43e79 FOREIGN KEY (uti_becomment_id) REFERENCES utilisateurs(id);


--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: xjkigakxleujhr
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO xjkigakxleujhr;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-05-29 20:31:34

--
-- PostgreSQL database dump complete
--

