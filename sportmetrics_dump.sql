--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Homebrew)
-- Dumped by pg_dump version 14.13 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cross_trainning_exercices; Type: TABLE; Schema: public; Owner: louismartindunord
--

CREATE TABLE public.cross_trainning_exercices (
    exercices_id integer NOT NULL,
    name character varying(100) NOT NULL,
    muscle_area character varying(60)
);


ALTER TABLE public.cross_trainning_exercices OWNER TO louismartindunord;

--
-- Name: cross_trainning_exercices_exercices_id_seq; Type: SEQUENCE; Schema: public; Owner: louismartindunord
--

CREATE SEQUENCE public.cross_trainning_exercices_exercices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cross_trainning_exercices_exercices_id_seq OWNER TO louismartindunord;

--
-- Name: cross_trainning_exercices_exercices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: louismartindunord
--

ALTER SEQUENCE public.cross_trainning_exercices_exercices_id_seq OWNED BY public.cross_trainning_exercices.exercices_id;


--
-- Name: cross_trainning_rows; Type: TABLE; Schema: public; Owner: louismartindunord
--

CREATE TABLE public.cross_trainning_rows (
    id integer NOT NULL,
    user_id integer NOT NULL,
    cross_trainning_serie_id integer NOT NULL,
    number_of_serie integer NOT NULL
);


ALTER TABLE public.cross_trainning_rows OWNER TO louismartindunord;

--
-- Name: cross_trainning_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: louismartindunord
--

CREATE SEQUENCE public.cross_trainning_rows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cross_trainning_rows_id_seq OWNER TO louismartindunord;

--
-- Name: cross_trainning_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: louismartindunord
--

ALTER SEQUENCE public.cross_trainning_rows_id_seq OWNED BY public.cross_trainning_rows.id;


--
-- Name: cross_trainning_series; Type: TABLE; Schema: public; Owner: louismartindunord
--

CREATE TABLE public.cross_trainning_series (
    series_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.cross_trainning_series OWNER TO louismartindunord;

--
-- Name: cross_trainning_series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: louismartindunord
--

CREATE SEQUENCE public.cross_trainning_series_series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cross_trainning_series_series_id_seq OWNER TO louismartindunord;

--
-- Name: cross_trainning_series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: louismartindunord
--

ALTER SEQUENCE public.cross_trainning_series_series_id_seq OWNED BY public.cross_trainning_series.series_id;


--
-- Name: muscle_area; Type: TABLE; Schema: public; Owner: louis
--

CREATE TABLE public.muscle_area (
    name character varying(30),
    id integer NOT NULL
);


ALTER TABLE public.muscle_area OWNER TO louis;

--
-- Name: muscle_area_id_seq; Type: SEQUENCE; Schema: public; Owner: louis
--

CREATE SEQUENCE public.muscle_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muscle_area_id_seq OWNER TO louis;

--
-- Name: muscle_area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: louis
--

ALTER SEQUENCE public.muscle_area_id_seq OWNED BY public.muscle_area.id;


--
-- Name: musculation_exercices; Type: TABLE; Schema: public; Owner: louis
--

CREATE TABLE public.musculation_exercices (
    muscle_area text,
    musculation_exercice_name text
);


ALTER TABLE public.musculation_exercices OWNER TO louis;

--
-- Name: musculation_rows; Type: TABLE; Schema: public; Owner: louis
--

CREATE TABLE public.musculation_rows (
    date_seance text,
    seance text,
    exercice text,
    poid double precision,
    nombre_repetition double precision,
    commentaires text,
    user_id bigint
);


ALTER TABLE public.musculation_rows OWNER TO louis;

--
-- Name: series_exercices; Type: TABLE; Schema: public; Owner: louismartindunord
--

CREATE TABLE public.series_exercices (
    series_id integer NOT NULL,
    exercices_id integer NOT NULL,
    duree integer,
    nombre_repetition integer
);


ALTER TABLE public.series_exercices OWNER TO louismartindunord;

--
-- Name: sport_exercices; Type: TABLE; Schema: public; Owner: louis
--

CREATE TABLE public.sport_exercices (
    id bigint,
    name text
);


ALTER TABLE public.sport_exercices OWNER TO louis;

--
-- Name: sport_rows; Type: TABLE; Schema: public; Owner: louis
--

CREATE TABLE public.sport_rows (
    date_seance text,
    sport text,
    exercice text,
    duree double precision,
    commentaire text,
    id bigint,
    user_id integer
);


ALTER TABLE public.sport_rows OWNER TO louis;

--
-- Name: users; Type: TABLE; Schema: public; Owner: louismartindunord
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    user_right character(30) DEFAULT 'user'::bpchar,
    email public.citext
);


ALTER TABLE public.users OWNER TO louismartindunord;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: louismartindunord
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO louismartindunord;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: louismartindunord
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_informations; Type: TABLE; Schema: public; Owner: louismartindunord
--

CREATE TABLE public.users_informations (
    id integer NOT NULL,
    user_id integer,
    poid numeric(5,2),
    taille numeric(5,2),
    objectif text,
    modification_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users_informations OWNER TO louismartindunord;

--
-- Name: users_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: louismartindunord
--

CREATE SEQUENCE public.users_informations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_informations_id_seq OWNER TO louismartindunord;

--
-- Name: users_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: louismartindunord
--

ALTER SEQUENCE public.users_informations_id_seq OWNED BY public.users_informations.id;


--
-- Name: cross_trainning_exercices exercices_id; Type: DEFAULT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_exercices ALTER COLUMN exercices_id SET DEFAULT nextval('public.cross_trainning_exercices_exercices_id_seq'::regclass);


--
-- Name: cross_trainning_rows id; Type: DEFAULT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_rows ALTER COLUMN id SET DEFAULT nextval('public.cross_trainning_rows_id_seq'::regclass);


--
-- Name: cross_trainning_series series_id; Type: DEFAULT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_series ALTER COLUMN series_id SET DEFAULT nextval('public.cross_trainning_series_series_id_seq'::regclass);


--
-- Name: muscle_area id; Type: DEFAULT; Schema: public; Owner: louis
--

ALTER TABLE ONLY public.muscle_area ALTER COLUMN id SET DEFAULT nextval('public.muscle_area_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_informations id; Type: DEFAULT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users_informations ALTER COLUMN id SET DEFAULT nextval('public.users_informations_id_seq'::regclass);


--
-- Data for Name: cross_trainning_exercices; Type: TABLE DATA; Schema: public; Owner: louismartindunord
--

COPY public.cross_trainning_exercices (exercices_id, name, muscle_area) FROM stdin;
24	Pompes	Pectoraux
25	Abs Wheel	abdominaux
26	Heel Touch	abdominaux
27	Pompes Rapprochées	triceps
28	Crunch	abdominaux
\.


--
-- Data for Name: cross_trainning_rows; Type: TABLE DATA; Schema: public; Owner: louismartindunord
--

COPY public.cross_trainning_rows (id, user_id, cross_trainning_serie_id, number_of_serie) FROM stdin;
\.


--
-- Data for Name: cross_trainning_series; Type: TABLE DATA; Schema: public; Owner: louismartindunord
--

COPY public.cross_trainning_series (series_id, name) FROM stdin;
26	Petit Enchaînement Abdos 
\.


--
-- Data for Name: muscle_area; Type: TABLE DATA; Schema: public; Owner: louis
--

COPY public.muscle_area (name, id) FROM stdin;
Dos	1
Pectoraux	2
Jambes	3
Épaules	4
Bras	5
Dorsaux	6
abdominaux	7
dos	9
triceps	10
\.


--
-- Data for Name: musculation_exercices; Type: TABLE DATA; Schema: public; Owner: louis
--

COPY public.musculation_exercices (muscle_area, musculation_exercice_name) FROM stdin;
Abdominaux	Abdominal
Abdominaux	Abdos Machine
Abdominaux	Abs Wheel
Bras	Arm Curl
Dos	Back Extension
Bras	Biceps Curl Allongé
Bras	Biceps Curl Assis
Bras	Biceps Curl Poulie
Bras	Biceps Curl Prise Marteau
Bras	Biceps Curl Prise Marteau à la Poulie
Bras	Biceps Curl à la barre
Bras	Biceps Curls
Bras	Biceps curl allongé
Pectoraux	Chest Press
Pectoraux	Converging Chest Press
Épaules	Converging Shoulder Press
Pectoraux	Dip Assist
Pectoraux	Dips
Dos	Diverging Lat Pull Down
Dos	Diverging Seated Row
Dos	Diverging Seated Row Prise Verticale
Pectoraux	Développé Couché
Pectoraux	Développé Couché Prise Serrée
Pectoraux	Développé Couché haltère
Pectoraux	Développé Couché incliné bas
Pectoraux	Développé Couché incliné haut
Pectoraux	Développé Incliné
Pectoraux	Développé Incliné Haltères
Épaules	Développé Militaire
Épaules	Développé Militaire Haltères
Épaules	Développé Militaire à la Smith Machine
Épaules	Développé Militaire à la barre
Pectoraux	Ecartés Poulie
Épaules	Face Pull Down à la poulie
Jambes	Fentes
Jambes	Hip Abduction
Jambes	Hip Adduction
Jambes	Hip Thrust
Dos	Lat Pull
Dos	Lat Pull prise Poignée
Épaules	Lateral Raise Poulie
Jambes	Leg Extension
Jambes	Leg Press
Dos	Low Row
Dos	Lower Back Bench
Abdominaux	Machine Abdominaux
Jambes	Mollets sur Leg Press
Pectoraux	Pec Fly
Pectoraux	Pectoraux à la poulie
Pectoraux	Pectoraux à la poulie bas
Pectoraux	Pectoraux à la poulie haut
Jambes	Prone leg Curl
NaN	Rear Delt
Abdominaux	Rotary Torso
Dos	Rowing Bar
Dos	Rowing Menton
Dos	Rowing buste penché
Dos	Rowing debout
Dos	Seated Row
Dos	Seated Row Prise Verticale
Épaules	Shoulder press
Jambes	Squat
Dos	Tirage Menton
Dos	Tirage Verticale
Dos	Traction avec Élastique
Bras	Triceps Double Chassées Croisé à la poulie
Bras	Triceps Doubles Chassées à la Poulie
Bras	Triceps Pull Downs Poulie
Bras	Triceps à la Poulie
Bras	Triceps à la Poulie Inversée
Bras	Triceps à la poulie
Épaules	Élévation Frontale Disque
Épaules	Élévation Frontale Poulie
Épaules	Élévations Frontales Haltères
Épaules	Élévations Latérales Haltères
Épaules	Élévations Latérales à la Poulie
\.


--
-- Data for Name: musculation_rows; Type: TABLE DATA; Schema: public; Owner: louis
--

COPY public.musculation_rows (date_seance, seance, exercice, poid, nombre_repetition, commentaires, user_id) FROM stdin;
2024-02-19	Pectoraux	Développé Couché	60	6	\N	19
2024-02-19	Pectoraux	Développé Couché	60	6	\N	19
2024-02-19	Pectoraux	Développé Couché	60	6	\N	19
2024-02-19	Pectoraux	Développé Couché	50	10	\N	19
2024-02-19	Pectoraux	Développé Couché	50	9	\N	19
2024-02-19	Pectoraux	Développé Couché	50	10	\N	19
2024-02-19	Pectoraux	Ecartés Poulie	32	10	bonne hauteur 11	19
2024-02-19	Pectoraux	Ecartés Poulie	36	10	\N	19
2024-02-19	Pectoraux	Ecartés Poulie	36	10	\N	19
2024-02-19	Pectoraux	Ecartés Poulie	38.3	10	\N	19
2024-02-21	Dos	Lat Pull	23	10	\N	19
2024-02-21	Dos	Lat Pull	27	20	\N	19
2024-02-21	Dos	Lat Pull	32	20	\N	19
2024-02-21	Dos	Lat Pull	36	12	\N	19
2024-02-21	Dos	Lat Pull	36	12	\N	19
2024-02-21	Dos	Lat Pull	41	12	\N	19
2024-02-21	Dos	Lat Pull	41	12	\N	19
2024-02-21	Dos	Seated Row Prise Verticale	54.3	10	\N	19
2024-02-21	Dos	Seated Row Prise Verticale	54.3	10	\N	19
2024-02-21	Dos	Seated Row Prise Verticale	54.3	12	\N	19
2024-02-21	Dos	Seated Row Prise Verticale	54.3	12	\N	19
2024-02-21	Dos	Seated Row Prise Verticale	54.3	12	\N	19
2024-02-21	Dos	Seated Row Prise Verticale	54.3	12	\N	19
2024-02-21	Dos	Biceps Curls	5	12	\N	19
2024-02-21	Dos	Biceps Curls	5	12	\N	19
2024-02-21	Dos	Biceps Curls	5	12	\N	19
2024-02-25	Jambes	Squat	20	10	\N	19
2024-02-25	Jambes	Squat	60	10	\N	19
2024-02-25	Jambes	Squat	70	10	\N	19
2024-02-25	Jambes	Squat	70	10	\N	19
2024-02-25	Jambes	Squat	70	10	\N	19
2024-02-25	Jambes	Hip Thrust	100	10	\N	19
2024-02-25	Jambes	Hip Thrust	100	12	\N	19
2024-02-25	Jambes	Hip Thrust	100	12	\N	19
2024-02-25	Jambes	Hip Thrust	100	12	\N	19
2024-02-25	Jambes	Mollets sur Leg Press	59	15	\N	19
2024-02-25	Jambes	Mollets sur Leg Press	59	15	\N	19
2024-02-25	Jambes	Mollets sur Leg Press	59	15	\N	19
2024-02-25	Jambes	Mollets sur Leg Press	59	15	\N	19
2024-02-25	Jambes	Mollets sur Leg Press	59	15	\N	19
2024-02-25	Jambes	Leg Press	45	12	Une jambe après l'autre	19
2024-02-25	Jambes	Leg Press	45	12	Une jambe après l'autre	19
2024-02-25	Jambes	Leg Press	45	12	Une jambe après l'autre	19
2024-02-25	Jambes	Leg Press	45	12	Une jambe après l'autre	19
2024-02-25	Jambes	Leg Press	45	12	Une jambe après l'autre	19
2024-02-25	Jambes	Leg Press	79	10	deux jambes	19
2024-02-25	Jambes	Leg Press	79	10	deux jambes	19
2024-02-25	Jambes	Leg Press	79	10	deux jambes	19
2024-02-25	Jambes	Leg Press	79	10	deux jambes	19
2024-02-25	Jambes	Leg Press	79	10	deux jambes	19
2024-02-25	Jambes	Hip Adduction	54.3	12	\N	19
2024-02-25	Jambes	Hip Adduction	54.3	12	\N	19
2024-02-25	Jambes	Hip Adduction	54.3	12	\N	19
2024-02-25	Jambes	Hip Adduction	54.3	12	\N	19
2024-02-25	Jambes	Prone leg Curl	45	10	\N	19
2024-02-25	Jambes	Prone leg Curl	45	8	\N	19
2024-02-25	Jambes	Prone leg Curl	45	8	\N	19
2024-02-25	Jambes	Prone leg Curl	45	6	\N	19
2024-02-26	Pectoraux	Développé Couché	20	4	\N	19
2024-02-26	Pectoraux	Développé Couché	20	10	\N	19
2024-02-26	Pectoraux	Développé Couché	20	6	\N	19
2024-02-26	Pectoraux	Développé Couché	20	7	\N	19
2024-02-26	Pectoraux	Ecartés Poulie	14	10	\N	19
2024-02-26	Pectoraux	Ecartés Poulie	18	10	\N	19
2024-02-26	Pectoraux	Ecartés Poulie	20.3	10	\N	19
2024-02-26	Pectoraux	Ecartés Poulie	20.3	10	\N	19
2024-02-26	Pectoraux	Triceps Pull Downs Poulie	32	15	\N	19
2024-02-26	Pectoraux	Triceps Pull Downs Poulie	36	15	\N	19
2024-02-26	Pectoraux	Triceps Pull Downs Poulie	41	12	\N	19
2024-02-26	Pectoraux	Triceps Pull Downs Poulie	66	10	\N	19
2024-02-26	Pectoraux	Pec Fly	59	15	\N	19
2024-02-26	Pectoraux	Pec Fly	66	15	\N	19
2024-02-26	Pectoraux	Pec Fly	73	15	\N	19
2024-02-26	Pectoraux	Pec Fly	73	10	\N	19
2024-02-26	Pectoraux	Pec Fly	73	10	\N	19
2024-02-26	Pectoraux	Ecartés Poulie	36	10	\N	19
2024-02-26	Pectoraux	Ecartés Poulie	36	10	\N	19
2024-02-26	Pectoraux	Ecartés Poulie	36	10	\N	19
2024-01-03	Dos	Lat Pull	45	20	\N	19
2024-01-03	Dos	Lat Pull	61.3	12	\N	19
2024-01-03	Dos	Lat Pull	61.3	12	\N	19
2024-01-03	Dos	Lat Pull	61.3	12	\N	19
2024-01-03	Dos	Lat Pull	61.3	10	\N	19
2024-01-03	Dos	Lat Pull	\N	\N	\N	19
2024-01-03	Dos	Lat Pull	\N	\N	\N	19
2024-01-03	Dos	Biceps Curl Assis	8	10	\N	19
2024-01-03	Dos	Biceps Curl Assis	8	10	\N	19
2024-01-03	Dos	Biceps Curl Assis	8	10	\N	19
2024-01-03	Dos	Biceps Curl Assis	8	10	\N	19
2024-01-03	Dos	Rear Delt	66	10	\N	19
2024-01-03	Dos	Rear Delt	73	10	\N	19
2024-01-03	Dos	Rear Delt	73	10	\N	19
2024-02-03	Pectoraux	Ecartés Poulie	38.3	15	\N	19
2024-02-03	Pectoraux	Ecartés Poulie	41	15	\N	19
2024-02-03	Pectoraux	Ecartés Poulie	41	15	\N	19
2024-02-03	Pectoraux	Ecartés Poulie	41	15	\N	19
2024-02-03	Jambes	Mollets sur Leg Press	66	12	\N	19
2024-02-03	Jambes	Mollets sur Leg Press	66	12	\N	19
2024-02-03	Jambes	Mollets sur Leg Press	66	12	\N	19
2024-02-03	Jambes	Mollets sur Leg Press	66	12	\N	19
2024-02-03	Jambes	Mollets sur Leg Press	66	12	\N	19
2024-02-03	Jambes	Mollets sur Leg Press	66	12	\N	19
2024-02-03	Jambes	Hip Abduction	12	54.3	\N	19
2024-02-03	Jambes	Hip Abduction	15	59	\N	19
2024-02-03	Jambes	Hip Abduction	15	66	\N	19
2024-02-03	Jambes	Hip Abduction	15	66	\N	19
2024-02-03	Jambes	Hip Abduction	15	66	\N	19
2024-03-03	Jambes	Leg Extension	47.3	10	\N	19
2024-03-03	Jambes	Leg Extension	47.3	13	\N	19
2024-03-03	Jambes	Leg Extension	52	15	\N	19
2024-03-03	Jambes	Leg Extension	52	15	\N	19
2024-03-03	Jambes	Leg Extension	52	15	\N	19
2024-03-03	Jambes	Leg Extension	54.3	15	\N	19
2024-03-03	Jambes	Hip Abduction	59	10	\N	19
2024-03-03	Jambes	Hip Abduction	59	12	\N	19
2024-03-03	Jambes	Hip Abduction	59	15	\N	19
2024-04-03	Pectoraux	Développé Incliné	10	10	\N	19
2024-04-03	Pectoraux	Développé Incliné	15	9	\N	19
2024-04-03	Pectoraux	Développé Incliné	15	10	\N	19
2024-04-03	Pectoraux	Développé Incliné	15	10	\N	19
2024-04-03	Pectoraux	Développé Incliné	15	7	\N	19
2024-04-03	Pectoraux	Shoulder press	32	12	\N	19
2024-04-03	Pectoraux	Shoulder press	36	14	\N	19
2024-04-03	Pectoraux	Shoulder press	41	12	\N	19
2024-04-03	Pectoraux	Shoulder press	41	7	\N	19
2024-04-03	Pectoraux	Dip Assist	23	12	\N	19
2024-04-03	Pectoraux	Dip Assist	23	12	\N	19
2024-04-03	Pectoraux	Dip Assist	23	12	\N	19
2024-04-03	Pectoraux	Dip Assist	23	12	\N	19
2024-04-03	Pectoraux	Dip Assist	23	12	\N	19
2024-04-03	Pectoraux	Développé Incliné Haltères	16	10	\N	19
2024-04-03	Pectoraux	Développé Incliné Haltères	16	10	\N	19
2024-04-03	Pectoraux	Développé Incliné Haltères	16	10	\N	19
2024-04-03	Pectoraux	Développé Incliné Haltères	16	10	\N	19
2024-04-03	Pectoraux	Développé Incliné Haltères	16	7	\N	19
2024-04-03	Pectoraux	Ecartés Poulie	36	12	\N	19
2024-04-03	Pectoraux	Ecartés Poulie	41	12	\N	19
2024-04-03	Pectoraux	Ecartés Poulie	41	12	\N	19
2024-04-03	Pectoraux	Ecartés Poulie	41	12	\N	19
2024-06-03	Dos	Seated Row	53	12	\N	19
2024-06-03	Dos	Seated Row	59	10	\N	19
2024-06-03	Dos	Seated Row	66	10	\N	19
2024-06-03	Dos	Seated Row	66	10	\N	19
2024-06-03	Dos	Seated Row	73	10	\N	19
2024-06-03	Dos	Seated Row	73	10	\N	19
2024-06-03	Dos	Arm Curl	32	10	\N	19
2024-06-03	Dos	Arm Curl	36	10	\N	19
2024-06-03	Dos	Arm Curl	36	10	\N	19
2024-06-03	Dos	Arm Curl	36	10	\N	19
2024-06-03	Dos	Rear Delt	52	10	\N	19
2024-06-03	Dos	Rear Delt	59	10	\N	19
2024-06-03	Dos	Rear Delt	69	10	\N	19
2024-06-03	Dos	Rear Delt	69	10	\N	19
2024-06-03	Dos	Rear Delt	69	10	\N	19
2024-07-03	Épaules	Élévations Latérales Haltères	5	12	\N	19
2024-07-03	Épaules	Élévations Latérales Haltères	6	10	\N	19
2024-07-03	Épaules	Élévations Latérales Haltères	6	12	\N	19
2024-07-03	Épaules	Élévations Latérales Haltères	5	10	\N	19
2024-08-03	Bras	Triceps à la Poulie	36	12	\N	19
2024-08-03	Bras	Triceps à la Poulie	41	12	\N	19
2024-08-03	Bras	Triceps à la Poulie	25.3	12	\N	19
2024-08-03	Bras	Triceps à la Poulie	25.3	11	\N	19
2024-08-03	Bras	Triceps à la Poulie	25.3	11	\N	19
2024-08-03	Bras	Triceps à la Poulie	25.3	10	\N	19
2024-08-03	Bras	Triceps à la Poulie	25.3	10	\N	19
2024-08-03	Bras	Triceps à la Poulie Inversée	36	20	\N	19
2024-08-03	Bras	Triceps à la Poulie Inversée	45	13	\N	19
2024-08-03	Bras	Triceps à la Poulie Inversée	45	11	\N	19
2024-08-03	Bras	Triceps à la Poulie Inversée	45	10	\N	19
2024-08-03	Bras	Biceps Curls	6	12	\N	19
2024-08-03	Bras	Biceps Curl Allongé	6	12	\N	19
2024-08-03	Bras	Biceps Curls	6	12	\N	19
2024-08-03	Bras	Biceps Curls	6	12	\N	19
2024-08-03	Bras	Triceps à la Poulie	14	10	\N	19
2024-08-03	Bras	Triceps à la Poulie	14	10	\N	19
2024-08-03	Bras	Triceps à la Poulie	14	13	\N	19
2024-08-03	Bras	Triceps à la Poulie	14	13	\N	19
2024-09-03	Abdos	Rotary Torso	50	20	\N	19
2024-09-03	Abdos	Rotary Torso	54	20	\N	19
2024-09-03	Abdos	Rotary Torso	54	20	\N	19
2024-09-03	Abdos	Rotary Torso	54	20	\N	19
2024-11-03	Pectoraux	Développé Couché	60	7	\N	19
2024-11-03	Pectoraux	Développé Couché	60	7	\N	19
2024-11-03	Pectoraux	Développé Couché	60	7	\N	19
2024-11-03	Pectoraux	Développé Couché	60	6	\N	19
2024-11-03	Pectoraux	Développé Couché	60	8	\N	19
2024-11-03	Pectoraux	Développé Couché	60	7	\N	19
2024-11-03	Pectoraux	Dip Assist	23	15	\N	19
2024-11-03	Pectoraux	Dip Assist	18	15	\N	19
2024-11-03	Pectoraux	Dip Assist	14	12	\N	19
2024-11-03	Pectoraux	Pec Fly	66	12	\N	19
2024-11-03	Pectoraux	Pec Fly	73	12	\N	19
2024-11-03	Pectoraux	Pec Fly	73	12	\N	19
2024-11-03	Pectoraux	Pec Fly	73	10	\N	19
2024-11-03	Pectoraux	Pec Fly	73	10	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	7	10	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	7	10	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	7	10	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	7	10	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	7	10	\N	19
2024-03-24	Épaules Bras	Triceps à la Poulie	32	10	\N	19
2024-03-24	Épaules Bras	Triceps à la poulie	32	10	\N	19
2024-03-24	Épaules Bras	Triceps à la Poulie	32	10	\N	19
2024-03-24	Épaules Bras	Triceps à la Poulie	32	10	\N	19
2024-03-24	Épaules Bras	Triceps à la Poulie	32	10	\N	19
2024-03-24	Épaules Bras	Biceps Curl Poulie	29.3	10	\N	19
2024-03-24	Épaules Bras	Biceps Curl Poulie	29.3	10	\N	19
2024-03-24	Épaules Bras	Biceps Curl Poulie	29.3	10	\N	19
2024-03-24	Épaules Bras	Biceps Curl Poulie	29.3	10	\N	19
2024-03-24	Épaules Bras	Biceps Curl Poulie	29.3	10	\N	19
2024-03-24	Épaules Bras	Rear Delt	45	10	\N	19
2024-03-24	Épaules Bras	Rear Delt	45	10	\N	19
2024-03-24	Épaules Bras	Rear Delt	45	10	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	4	12	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	4	12	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	4	12	\N	19
2024-03-24	Épaules Bras	Élévations Latérales Haltères	4	12	\N	19
2024-03-25	Abdos	Rotary Torso	50	15	\N	19
2024-03-25	Abdos	Rotary Torso	50	15	\N	19
2024-03-25	Abdos	Rotary Torso	50	15	\N	19
2024-03-25	Abdos	Rotary Torso	50	15	\N	19
2024-03-25	Abdos	Rotary Torso	50	15	\N	19
2024-03-25	Abdos	Abdos Machine	10	15	\N	19
2024-03-25	Abdos	Abdos Machine	10	15	\N	19
2024-03-25	Abdos	Abdos Machine	10	15	\N	19
2024-03-25	Pectoraux	Chest Press	32	12	\N	19
2024-03-25	Pectoraux	Chest Press	34.3	12	\N	19
2024-03-25	Pectoraux	Chest Press	34.3	12	\N	19
2024-03-25	Pectoraux	Chest Press	34.3	12	\N	19
2024-03-25	Pectoraux	Chest Press	34.3	12	\N	19
2024-03-27	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-03-27	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-03-27	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-03-27	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-03-27	Abdos Jambes	Rotary Torso	59	15	\N	19
2024-03-27	Abdos Jambes	Abdos Machine	10	15	\N	19
2024-03-27	Abdos Jambes	Abdos Machine	15	15	\N	19
2024-03-27	Abdos Jambes	Abdos Machine	15	11	\N	19
2024-03-27	Abdos Jambes	Abdos Machine	15	14	\N	19
2024-03-27	Abdos Jambes	Abdos Machine	15	15	\N	19
2024-03-27	Abdos Jambes	Mollets sur Leg Press	68.3	20	\N	19
2024-03-27	Abdos Jambes	Mollets sur Leg Press	73	15	\N	19
2024-03-27	Abdos Jambes	Mollets sur Leg Press	73	15	\N	19
2024-03-27	Abdos Jambes	Mollets sur Leg Press	73	15	\N	19
2024-03-27	Abdos Jambes	Mollets sur Leg Press	73	15	\N	19
2024-08-04	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-08-04	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-08-04	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-08-04	Abdos Jambes	Rotary Torso	54	15	\N	19
2024-08-04	Abdos Jambes	Machine Abdominaux	32	10	\N	19
2024-08-04	Abdos Jambes	Machine Abdominaux	32	10	\N	19
2024-08-04	Abdos Jambes	Machine Abdominaux	32	10	\N	19
2024-08-04	Abdos Jambes	Machine Abdominaux	32	10	\N	19
2024-08-04	Abdos Jambes	Lower Back Bench	10	10	\N	19
2024-08-04	Abdos Jambes	Lower Back Bench	10	10	\N	19
2024-08-04	Abdos Jambes	Lower Back Bench	10	10	\N	19
2024-08-04	Abdos Jambes	Lower Back Bench	10	10	\N	19
2024-12-04	Dos	Seated Row	52	12	\N	19
2024-12-04	Dos	Seated Row	52	12	\N	19
2024-12-04	Dos	Seated Row	52	12	\N	19
2024-12-04	Dos	Rear Delt	59	10	\N	19
2024-12-04	Dos	Rear Delt	59	10	\N	19
2024-12-04	Dos	Rear Delt	59	10	\N	19
2024-12-04	Dos	Rear Delt	52	10	\N	19
2024-12-04	Dos	Abdos Machine	15	15	\N	19
2024-12-04	Dos	Abdos Machine	15	15	\N	19
2024-12-04	Dos	Abdos Machine	15	15	\N	19
2024-12-04	Dos	Abdos Machine	15	15	\N	19
2024-12-04	Dos	Abdos Machine	15	15	\N	19
2024-12-04	Dos	Lat Pull prise Poignée	52	10	\N	19
2024-12-04	Abdos	Machine Abdominaux	52	10	\N	19
2024-04-15	Jambes	Mollets sur Leg Press	59	15	\N	19
2024-04-15	Jambes	Mollets sur Leg Press	66	15	\N	19
2024-04-15	Jambes	Mollets sur Leg Press	66	15	\N	19
2024-04-15	Jambes	Mollets sur Leg Press	66	15	\N	19
2024-04-15	Jambes	Mollets sur Leg Press	73	15	\N	19
2024-04-15	Abdos	Rotary Torso	59	12	\N	19
2024-04-15	Abdos	Rotary Torso	59	12	\N	19
2024-04-15	Abdos	Rotary Torso	59	12	\N	19
2024-04-15	Abdos	Rotary Torso	59	12	\N	19
2024-04-15	Abdos	Rotary Torso	59	12	\N	19
2024-04-15	\N	Abdos Machine	15	15	\N	19
2024-04-15	\N	Abdos Machine	15	15	\N	19
2024-04-15	\N	Lower Back Bench	10	10	\N	19
2024-04-15	\N	Lower Back Bench	10	10	\N	19
2024-04-15	\N	Lower Back Bench	10	10	\N	19
2024-04-16	Pectoraux	Pec Fly	59	12	\N	19
2024-04-16	Pectoraux	Pec Fly	59	12	\N	19
2024-04-16	Pectoraux	Pec Fly	59	12	\N	19
2024-04-16	Pectoraux	Pec Fly	59	12	\N	19
2024-04-16	Pectoraux	Pec Fly	59	12	\N	19
2024-04-16	Pectoraux	Chest Press	25	12	\N	19
2024-04-16	Pectoraux	Chest Press	27.3	12	\N	19
2024-04-16	Pectoraux	Chest Press	32	12	\N	19
2024-04-16	Pectoraux	Chest Press	32	12	\N	19
2024-04-16	Pectoraux	Chest Press	32	12	\N	19
2024-04-16	Pectoraux	Back Extension	73	12	\N	19
2024-04-16	Pectoraux	Back Extension	73	12	\N	19
2024-04-16	Pectoraux	Back Extension	73	12	\N	19
2024-04-16	Pectoraux	Back Extension	73	12	\N	19
2024-04-16	Pectoraux	Back Extension	73	12	\N	19
2024-04-19	Dos	Diverging Seated Row Prise Verticale	36	10	\N	19
2024-04-19	Dos	Diverging Seated Row Prise Verticale	36	12	\N	19
2024-04-19	Dos	Diverging Seated Row Prise Verticale	36	12	\N	19
2024-04-19	Dos	Diverging Seated Row Prise Verticale	36	12	\N	19
2024-04-19	Dos	Biceps Curl Poulie	18	12	\N	19
2024-04-19	Dos	Biceps Curl Poulie	23	12	\N	19
2024-04-19	Dos	Biceps Curl Poulie	23	13	\N	19
2024-04-19	Dos	Biceps Curl Poulie	23	10	\N	19
2024-04-19	Dos	Biceps Curl Poulie	23	11	\N	19
2024-04-19	Dos	Rear Delt	52	10	\N	19
2024-04-20	Mobilités Jambes	Rotary Torso	59	15	\N	19
2024-04-20	Mobilités Jambes	Rotary Torso	59	15	\N	19
2024-04-20	Mobilités Jambes	Rotary Torso	59	15	\N	19
2024-04-20	Mobilités Jambes	Rotary Torso	59	15	\N	19
2024-04-20	Mobilités Jambes	Abdos Machine	20	15	\N	19
2024-04-20	Mobilités Jambes	Abdos Machine	20	15	\N	19
2024-04-20	Mobilités Jambes	Abdos Machine	20	15	\N	19
2024-04-20	Mobilités Jambes	Squat	40	15	\N	19
2024-04-20	Mobilités Jambes	Squat	50	15	\N	19
2024-04-20	Mobilités Jambes	Squat	60	15	\N	19
2024-04-20	Mobilités Jambes	Squat	70	15	\N	19
2024-04-20	Mobilités Jambes	Squat	80	15	\N	19
2024-04-23	Mobilités Jambes	Rotary Torso	59	10	\N	19
2024-04-23	Mobilités Jambes	Rotary Torso	59	10	\N	19
2024-04-23	Mobilités Jambes	Rotary Torso	59	10	\N	19
2024-04-30	Dos	Lat Pull	54.3	10	\N	19
2024-04-30	Dos	Lat Pull	54.3	10	\N	19
2024-04-30	Dos	Lat Pull	54.3	10	\N	19
2024-04-30	Dos	Lat Pull	59	10	\N	19
2024-04-30	Dos	Biceps Curl Poulie	23	10	\N	19
2024-04-30	Dos	Biceps Curl Poulie	25.3	12	\N	19
2024-04-30	Dos	Biceps Curl Poulie	25.3	12	\N	19
2024-04-30	Dos	Biceps Curl Poulie	25.3	12	\N	19
2024-04-30	Dos	Biceps Curl Poulie	27	12	\N	19
2024-04-30	Dos	Rear Delt	59	10	\N	19
2024-04-30	Dos	Rear Delt	59	10	\N	19
2024-04-30	Dos	Rear Delt	59	10	\N	19
2024-04-30	Dos	Rear Delt	59	10	\N	19
2024-04-30	Dos	Rear Delt	59	10	\N	19
2024-04-30	Jambes	Seated Row	61.3	8	\N	19
2024-04-30	Jambes	Seated Row	61.3	8	\N	19
2024-04-30	Jambes	Seated Row	\N	\N	\N	19
2024-04-30	Jambes	Seated Row	61.3	8	\N	19
2024-02-05	Jambes	Squat	65	10	\N	19
2024-02-05	Jambes	Squat	65	10	\N	19
2024-02-05	Jambes	Squat	65	10	\N	19
2024-02-05	Jambes	Squat	65	10	\N	19
2024-02-05	Jambes	Squat	65	10	\N	19
2024-02-05	Jambes	Hip Thrust	30	10	\N	19
2024-02-05	Jambes	Hip Thrust	30	10	\N	19
2024-02-05	Jambes	Hip Thrust	30	10	\N	19
2024-02-05	Jambes	Hip Thrust	30	10	\N	19
2024-02-05	Jambes	Hip Thrust	30	10	\N	19
2024-02-05	Jambes	Leg Press	73	12	\N	19
2024-02-05	Jambes	Leg Press	73	12	\N	19
2024-02-05	Jambes	Leg Press	73	12	\N	19
2024-02-05	Jambes	Leg Press	73	12	\N	19
2024-02-05	Jambes	Leg Press	73	12	\N	19
2024-02-05	Jambes	Leg Extension	52	10	\N	19
2024-02-05	Jambes	Leg Extension	52	10	\N	19
2024-03-05	Épaules	Développé Militaire à la barre	40	10	\N	19
2024-03-05	Épaules	Développé Militaire à la barre	40	10	\N	19
2024-03-05	Épaules	Développé Militaire à la barre	40	10	\N	19
2024-03-05	Épaules	Triceps à la Poulie Inversée	32	12	\N	19
2024-03-05	Épaules	Triceps à la Poulie Inversée	32	12	\N	19
2024-03-05	Épaules	Triceps à la Poulie Inversée	36	12	\N	19
2024-03-05	Épaules	Triceps à la Poulie Inversée	36	12	\N	19
2024-03-05	Épaules	Triceps à la Poulie Inversée	36	12	\N	19
2024-03-05	Épaules	Élévations Latérales à la Poulie	20.3	10	\N	19
2024-03-05	Épaules	Élévations Latérales à la Poulie	20.3	10	\N	19
2024-03-05	Épaules	Élévations Latérales à la Poulie	20.3	10	\N	19
2024-03-05	Épaules	Converging Shoulder Press	23	10	\N	19
2024-03-05	Épaules	Converging Shoulder Press	23	10	\N	19
2024-03-05	Épaules	Élévations Latérales Haltères	5	10	\N	19
2024-03-05	Épaules	Élévations Latérales Haltères	5	10	\N	19
2024-03-05	Épaules	Élévations Latérales Haltères	5	10	\N	19
2024-03-05	Épaules	Élévations Latérales Haltères	5	10	\N	19
2024-03-05	Épaules	Élévations Latérales Haltères	5	10	\N	19
2024-09-05	Jambes	Squat	60	10	\N	19
2024-09-05	Jambes	Squat	80	10	\N	19
2024-09-05	Jambes	Squat	80	10	\N	19
2024-09-05	Jambes	Squat	70	10	\N	19
2024-09-05	Jambes	Squat	70	10	\N	19
2024-09-05	Jambes	Hip Thrust	100	10	\N	19
2024-09-05	Jambes	Hip Thrust	100	10	\N	19
2024-09-05	Jambes	Hip Thrust	100	10	\N	19
2024-09-05	Jambes	Hip Thrust	100	10	\N	19
2024-09-05	Jambes	Hip Thrust	100	10	\N	19
2024-09-05	Jambes	Mollets sur Leg Press	73	10	\N	19
2024-09-05	Jambes	Mollets sur Leg Press	73	10	\N	19
2024-09-05	Jambes	Mollets sur Leg Press	73	10	\N	19
2024-09-05	Jambes	Mollets sur Leg Press	73	10	\N	19
2024-09-05	Jambes	Mollets sur Leg Press	73	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Hip Abduction	59	10	\N	19
2024-09-05	Jambes	Leg Extension	59	19	\N	19
2024-09-05	Jambes	Leg Extension	52	12	\N	19
2024-09-05	Jambes	Leg Extension	52	12	\N	19
2024-09-05	Jambes	Leg Extension	52	12	\N	19
2024-10-05	Haut du Corps	Développé Militaire à la barre	40	10	\N	19
2024-10-05	Haut du Corps	Développé Militaire à la barre	50	10	\N	19
2024-10-05	Haut du Corps	Développé Militaire à la barre	50	8	\N	19
2024-10-05	Haut du Corps	Développé Militaire à la barre	50	8	\N	19
2024-10-05	Haut du Corps	Développé Militaire à la barre	40	10	\N	19
2024-10-05	Haut du Corps	Pec Fly	66	12	\N	19
2024-10-05	Haut du Corps	Pec Fly	66	12	\N	19
2024-10-05	Haut du Corps	Pec Fly	72	12	\N	19
2024-10-05	Haut du Corps	Pec Fly	72	12	\N	19
2024-10-05	Haut du Corps	Pec Fly	72	12	\N	19
2024-10-05	Haut du Corps	Pec Fly	\N	\N	Penser à prendre la poignée la plus basse	19
2024-10-05	Haut du Corps	Converging Chest Press	32	12	\N	19
2024-10-05	Haut du Corps	Converging Chest Press	32	12	\N	19
2024-10-05	Haut du Corps	Converging Chest Press	34.3	12	\N	19
2024-10-05	Haut du Corps	Converging Chest Press	34.3	12	\N	19
2024-10-05	Haut du Corps	Converging Chest Press	34.3	12	\N	19
2024-10-05	Haut du Corps	Triceps à la Poulie Inversée	36	12	\N	19
2024-10-05	Haut du Corps	Triceps à la Poulie Inversée	36	12	\N	19
2024-10-05	Haut du Corps	Triceps à la Poulie Inversée	36	12	\N	19
2024-11-05	Dos	Traction avec Élastique	\N	5	\N	19
2024-11-05	Dos	Traction avec Élastique	\N	5	\N	19
2024-11-05	Dos	Traction avec Élastique	\N	5	\N	19
2024-11-05	Dos	Traction avec Élastique	\N	5	\N	19
2024-11-05	Dos	Traction avec Élastique	\N	5	\N	19
2024-11-05	Dos	Tirage Verticale	59	8	\N	19
2024-11-05	Dos	Tirage Verticale	59	10	\N	19
2024-11-05	Dos	Tirage Verticale	59	7	\N	19
2024-11-05	Dos	Tirage Verticale	59	10	\N	19
2024-11-05	Dos	Tirage Verticale	59	5	\N	19
2024-11-05	Dos	Biceps Curls	6	10	\N	19
2024-11-05	Dos	Biceps Curls	6	12	\N	19
2024-11-05	Dos	Biceps Curls	6	10	\N	19
2024-11-05	Dos	Biceps Curls	6	12	\N	19
2024-11-05	Dos	Rear Delt	59	12	\N	19
2024-11-05	Dos	Rear Delt	59	12	\N	19
2024-11-05	Dos	Rear Delt	59	10	\N	19
2024-05-13	Dos	Back Extension	10	10	\N	19
2024-05-13	Dos	Back Extension	10	10	\N	19
2024-05-13	Dos	Back Extension	10	10	\N	19
2024-05-13	Dos	Back Extension	10	10	\N	19
2024-05-13	Dos	Back Extension	10	10	\N	19
2024-05-13	Dos	Rotary Torso	59	10	\N	19
2024-05-13	Dos	Rotary Torso	64	10	\N	19
2024-05-13	Dos	Rotary Torso	64	10	\N	19
2024-05-14	Pectoraux	Développé Couché	40	15	\N	19
2024-05-14	Pectoraux	Développé Couché	50	12	\N	19
2024-05-14	Pectoraux	Développé Couché	50	8	\N	19
2024-05-14	Pectoraux	Développé Couché	50	9	\N	19
2024-05-14	Pectoraux	Ecartés Poulie	21.3	10	\N	19
2024-05-14	Pectoraux	Ecartés Poulie	21.3	10	\N	19
2024-05-14	Pectoraux	Ecartés Poulie	21.3	10	\N	19
2024-05-14	Pectoraux	Ecartés Poulie	21.3	10	\N	19
2024-05-14	Pectoraux	Ecartés Poulie	21.3	10	\N	19
2024-05-14	Pectoraux	Triceps à la Poulie Inversée	34.3	15	\N	19
2024-05-14	Pectoraux	Triceps à la Poulie Inversée	38.3	15	\N	19
2024-05-14	Pectoraux	Triceps à la Poulie Inversée	38.3	15	\N	19
2024-05-14	Pectoraux	Triceps à la Poulie Inversée	38.3	15	\N	19
2024-05-14	Pectoraux	Triceps à la Poulie Inversée	38.3	12	\N	19
2024-05-14	Pectoraux	Pec Fly	79	19	\N	19
2024-05-14	Pectoraux	Pec Fly	79	8	\N	19
2024-05-14	Pectoraux	Pec Fly	79	8	\N	19
2024-05-14	Pectoraux	Pec Fly	79	8	\N	19
2024-05-14	Pectoraux	Pec Fly	79	8	\N	19
2024-05-16	Full Body	Développé Militaire à la barre	45	10	\N	19
2024-05-16	Full Body	Développé Militaire à la barre	45	10	\N	19
2024-05-16	Full Body	Développé Militaire à la barre	45	10	\N	19
2024-05-16	Full Body	Développé Militaire à la barre	45	10	\N	19
2024-05-16	Full Body	Développé Militaire à la barre	45	10	\N	19
2024-05-16	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-16	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-16	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-16	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-16	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-17	Jambes	Squat	60	10	\N	19
2024-05-17	Jambes	Squat	60	10	\N	19
2024-05-17	Jambes	Squat	60	10	\N	19
2024-05-17	Jambes	Squat	60	10	\N	19
2024-05-17	Jambes	Squat	60	10	\N	19
2024-05-17	Jambes	Hip Thrust	100	10	\N	19
2024-05-17	Jambes	Hip Thrust	100	10	\N	19
2024-05-17	Jambes	Hip Thrust	100	10	\N	19
2024-05-17	Jambes	Hip Thrust	100	10	\N	19
2024-05-18	Bras	Biceps Curl Poulie	32	10	\N	19
2024-05-18	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-18	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-18	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-18	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-18	Bras	Triceps à la Poulie Inversée	36	10	\N	19
2024-05-18	Bras	Triceps à la Poulie Inversée	41	12	\N	19
2024-05-18	Bras	Triceps à la Poulie Inversée	41	12	\N	19
2024-05-18	Bras	Triceps à la Poulie Inversée	43.3	12	\N	19
2024-05-18	Bras	Triceps à la Poulie Inversée	43.3	12	\N	19
2024-05-18	Bras	Triceps à la Poulie Inversée	45	11	\N	19
2024-05-18	Bras	Biceps Curls	7	10	\N	19
2024-05-18	Bras	Biceps Curls	7	10	\N	19
2024-05-19	Épaules	Converging Shoulder Press	27	12	\N	19
2024-05-19	Épaules	Converging Shoulder Press	32	10	\N	19
2024-05-19	Épaules	Converging Shoulder Press	32	10	\N	19
2024-05-19	Épaules	Converging Shoulder Press	32	10	\N	19
2024-05-19	Épaules	Converging Shoulder Press	27	10	\N	19
2024-05-19	Épaules	Élévations Frontales Haltères	7	10	\N	19
2024-05-19	Épaules	Élévations Frontales Haltères	7	12	\N	19
2024-05-19	Épaules	Élévations Frontales Haltères	7	12	\N	19
2024-05-19	Épaules	Élévations Frontales Haltères	7	12	\N	19
2024-05-19	Épaules	Élévations Latérales Haltères	6	10	\N	19
2024-05-19	Épaules	Élévations Latérales Haltères	6	10	\N	19
2024-05-19	Épaules	Élévations Latérales Haltères	6	10	\N	19
2024-05-19	Épaules	Élévations Latérales Haltères	6	10	\N	19
2024-05-20	Pectoraux	Développé Couché haltère	18	12	\N	19
2024-05-20	Pectoraux	Développé Couché haltère	18	12	\N	19
2024-05-20	Pectoraux	Développé Couché haltère	18	12	\N	19
2024-05-20	Pectoraux	Développé Couché haltère	18	12	\N	19
2024-05-20	Pectoraux	Développé Couché haltère	18	12	\N	19
2024-05-20	Bras	Triceps à la Poulie	29.3	10	\N	19
2024-05-20	Bras	Triceps à la Poulie	29.3	10	\N	19
2024-05-20	Bras	Triceps à la Poulie	34.3	10	\N	19
2024-05-20	Bras	Triceps à la Poulie	34.3	10	\N	19
2024-05-20	Bras	Triceps à la Poulie	34.3	10	\N	19
2024-05-20	Pectoraux	Pec Fly	66	15	\N	19
2024-05-20	Pectoraux	Pec Fly	73	12	\N	19
2024-05-20	Pectoraux	Pec Fly	73	12	\N	19
2024-05-20	Pectoraux	Pec Fly	73	12	\N	19
2024-05-20	Pectoraux	Pec Fly	73	12	\N	19
2024-05-20	Bras	Dips	\N	15	\N	19
2024-05-20	Bras	Dips	\N	15	\N	19
2024-05-20	Bras	Dips	\N	15	\N	19
2024-05-20	Bras	Dips	\N	15	\N	19
2024-05-20	Bras	Dips	\N	15	\N	19
2024-05-21	Dos	Lat Pull	66	7	\N	19
2024-05-21	Dos	Lat Pull	66	7	\N	19
2024-05-21	Dos	Lat Pull	59	10	\N	19
2024-05-21	Dos	Lat Pull	59	10	\N	19
2024-05-21	Dos	Lat Pull	59	10	\N	19
2024-05-21	Dos	Lat Pull	59	10	\N	19
2024-05-21	Dos	Back Extension	10	10	\N	19
2024-05-21	Dos	Back Extension	10	10	\N	19
2024-05-21	Dos	Back Extension	10	10	\N	19
2024-05-21	Dos	Back Extension	10	10	\N	19
2024-05-21	Dos	Diverging Seated Row	52	8	\N	19
2024-05-21	Dos	Diverging Seated Row	52	8	\N	19
2024-05-21	Dos	Diverging Seated Row	52	8	\N	19
2024-05-21	Dos	Diverging Seated Row	52	8	\N	19
2024-05-22	Full Body	Squat	60	10	\N	19
2024-05-22	Full Body	Squat	60	10	\N	19
2024-05-22	Full Body	Squat	60	10	\N	19
2024-05-22	Full Body	Squat	70	10	\N	19
2024-05-22	Full Body	Squat	80	10	\N	19
2024-05-22	Full Body	Hip Thrust	100	10	\N	19
2024-05-22	Full Body	Hip Thrust	100	10	\N	19
2024-05-22	Full Body	Hip Thrust	100	10	\N	19
2024-05-23	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-23	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-23	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-23	Bras	Biceps Curl Poulie	27	10	\N	19
2024-05-23	Bras	Triceps Doubles Chassées à la Poulie	9	12	\N	19
2024-05-23	Bras	Triceps Doubles Chassées à la Poulie	11.5	10	\N	19
2024-05-23	Bras	Triceps Doubles Chassées à la Poulie	14	10	\N	19
2024-05-23	Bras	Triceps Doubles Chassées à la Poulie	14	10	\N	19
2024-05-23	Abdos	Abdos Machine	15	10	\N	19
2024-05-23	Abdos	Abdos Machine	15	10	\N	19
2024-05-23	Bras	Arm Curl	29.3	10	\N	19
2024-05-23	Bras	Arm Curl	32	10	\N	19
2024-05-23	Bras	Arm Curl	34.3	10	\N	19
2024-05-23	Bras	Arm Curl	36	10	\N	19
2024-05-25	Full Body	Rear Delt	73	10	\N	19
2024-05-25	Full Body	Rear Delt	73	10	\N	19
2024-05-25	Full Body	Rear Delt	73	10	\N	19
2024-05-25	Full Body	Rear Delt	73	10	\N	19
2024-05-25	Full Body	Rear Delt	73	10	Trop lourd	19
2024-05-25	Full Body	Lat Pull	59	10	\N	19
2024-05-25	Full Body	Lat Pull	59	10	\N	19
2024-05-25	Full Body	Lat Pull	59	10	\N	19
2024-05-25	Full Body	Lat Pull	59	10	\N	19
2024-05-25	Full Body	Lat Pull	59	10	Bon poid essayer de monter dans 2 séances	19
2024-05-25	Full Body	Squat	80	10	\N	19
2024-05-25	Full Body	Squat	80	10	\N	19
2024-05-25	Full Body	Squat	80	10	\N	19
2024-05-25	Full Body	Squat	80	10	\N	19
2024-05-25	Full Body	Squat	80	10	Bon poid	19
2024-05-25	Full Body	Développé Couché	55	10	\N	19
2024-05-25	Full Body	Développé Couché	55	10	\N	19
2024-05-25	Full Body	Développé Couché	55	10	\N	19
2024-05-25	Full Body	Développé Couché	55	10	Encore un peu lourd mais j’essaie de partir sur ce poid moyen	19
2024-05-26	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-05-26	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-05-26	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-05-26	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-05-26	Pectoraux	Développé Couché haltère	20	10	essayer de monter prochaine séance	19
2024-05-26	Pectoraux	Pectoraux à la poulie	25.3	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie	25.3	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie	25.3	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie	25.3	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie	25.3	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie bas	20.3	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie bas	23	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie bas	23	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie bas	23	10	\N	19
2024-05-26	Pectoraux	Pectoraux à la poulie bas	23	10	\N	19
2024-05-26	Bras	Triceps à la Poulie Inversée	36	15	\N	19
2024-05-26	Bras	Triceps à la Poulie Inversée	41	12	\N	19
2024-05-26	Bras	Triceps à la Poulie Inversée	45	12	\N	19
2024-05-26	Bras	Triceps à la Poulie Inversée	45	12	\N	19
2024-05-26	Bras	Triceps à la Poulie Inversée	45	12	\N	19
2024-05-26	Pectoraux	Dip Assist	14	10	\N	19
2024-05-26	Pectoraux	Dip Assist	14	10	\N	19
2024-05-26	Pectoraux	Dip Assist	14	10	un peu trop lourd	19
2024-05-26	Pectoraux	Pec Fly	66	12	\N	19
2024-05-26	Pectoraux	Pec Fly	66	12	\N	19
2024-05-26	Pectoraux	Pec Fly	66	12	\N	19
2024-05-26	Pectoraux	Pec Fly	66	12	\N	19
2024-05-26	Pectoraux	Pec Fly	66	12	trop léger même pour fin de séance	19
2024-05-28	Dos	Rotary Torso	54	15	\N	19
2024-05-28	Dos	Rotary Torso	54	15	\N	19
2024-05-28	Dos	Rotary Torso	54	15	\N	19
2024-05-28	Dos	Rotary Torso	54	15	\N	19
2024-05-28	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-28	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-28	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-28	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-28	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-28	Dos	Biceps Curl Assis	8	10	\N	19
2024-05-28	Dos	Biceps Curl Assis	8	10	\N	19
2024-05-28	Dos	Biceps Curl Prise Marteau	8	10	\N	19
2024-05-29	Épaules	Développé Militaire Haltères	16	10	Bon poid pour le moment	19
2024-05-29	Épaules	Développé Militaire Haltères	16	10	Bon poid pour le moment	19
2024-05-29	Épaules	Développé Militaire Haltères	16	10	Bon poid pour le moment	19
2024-05-29	Épaules	Développé Militaire Haltères	16	10	Bon poid pour le moment	19
2024-05-29	Épaules	Développé Militaire Haltères	16	10	Bon poid pour le moment	19
2024-05-29	Épaules	Triceps à la Poulie Inversée	27	12	\N	19
2024-05-29	Épaules	Triceps à la Poulie Inversée	32	12	\N	19
2024-05-29	Épaules	Triceps à la Poulie Inversée	36	12	\N	19
2024-05-29	Épaules	Triceps à la Poulie Inversée	38.2	12	\N	19
2024-05-29	Épaules	Triceps à la Poulie Inversée	41	12	\N	19
2024-05-30	Dos	Traction avec Élastique	\N	10	\N	19
2024-05-30	Dos	Low Row	59	10	\N	19
2024-05-30	Dos	Low Row	59	10	\N	19
2024-05-30	Dos	Low Row	59	10	\N	19
2024-05-30	Dos	Low Row	59	10	\N	19
2024-05-30	Dos	Low Row	59	10	\N	19
2024-05-30	Dos	Biceps Curl Poulie	27	10	\N	19
2024-05-30	Dos	Biceps Curl Poulie	27	10	\N	19
2024-05-30	Dos	Biceps Curl Poulie	23	10	\N	19
2024-05-30	Dos	Biceps Curl Poulie	23	10	\N	19
2024-05-30	Dos	Biceps Curl Poulie	23	10	\N	19
2024-05-30	Dos	Back Extension	10	10	\N	19
2024-05-30	Dos	Back Extension	10	10	\N	19
2024-05-30	Dos	Rear Delt	66	12	\N	19
2024-05-30	Dos	Rear Delt	66	12	\N	19
2024-05-30	Dos	Rear Delt	66	10	\N	19
2024-05-30	Dos	Rear Delt	66	12	\N	19
2024-05-30	Dos	Rear Delt	66	12	\N	19
2024-05-30	Dos	Biceps Curl Allongé	6	10	\N	19
2024-05-30	Dos	Biceps Curl Allongé	6	10	\N	19
2024-05-30	Dos	Biceps Curl Allongé	6	10	\N	19
2024-06-01	full body	Mollets sur Leg Press	73	12	\N	19
2024-06-01	full body	Mollets sur Leg Press	73	12	\N	19
2024-06-01	full body	Mollets sur Leg Press	73	12	\N	19
2024-06-01	full body	Mollets sur Leg Press	73	12	\N	19
2024-06-01	full body	Biceps Curl à la barre	20	10	\N	19
2024-06-01	full body	Biceps Curl à la barre	20	12	\N	19
2024-06-01	full body	Biceps Curl à la barre	20	12	\N	19
2024-06-01	full body	Biceps Curl à la barre	20	12	\N	19
2024-06-01	full body	Biceps Curl à la barre	20	12	\N	19
2024-06-01	full body	Triceps à la Poulie Inversée	41	12	\N	19
2024-06-01	full body	Triceps à la Poulie Inversée	45	12	\N	19
2024-06-01	full body	Triceps à la Poulie Inversée	45	12	\N	19
2024-06-01	full body	Triceps à la Poulie Inversée	45	12	\N	19
2024-06-01	full body	Triceps à la Poulie Inversée	45	12	\N	19
2024-06-01	full body	Biceps curl allongé	7	10	\N	19
2024-06-01	full body	Biceps curl allongé	7	10	\N	19
2024-06-01	full body	Biceps curl allongé	7	10	\N	19
2024-06-01	full body	Biceps curl allongé	5	10	\N	19
2024-06-01	full body	Biceps curl allongé	5	10	\N	19
2024-06-02	jambes	Squat	60	12	\N	19
2024-06-02	jambes	Squat	60	12	\N	19
2024-06-02	jambes	Squat	60	12	\N	19
2024-06-02	jambes	Squat	60	12	\N	19
2024-06-02	jambes	Squat	60	12	\N	19
2024-06-02	jambes	Hip Thrust	100	12	\N	19
2024-06-02	jambes	Hip Thrust	100	12	\N	19
2024-06-02	jambes	Hip Thrust	100	12	\N	19
2024-06-02	jambes	Hip Thrust	100	12	\N	19
2024-06-02	jambes	Hip Thrust	100	12	\N	19
2024-06-02	jambes	Prone leg Curl	36	10	\N	19
2024-06-02	jambes	Prone leg Curl	36	10	\N	19
2024-06-02	jambes	Prone leg Curl	36	10	\N	19
2024-06-02	jambes	Prone leg Curl	36	10	\N	19
2024-06-02	jambes	Prone leg Curl	36	10	\N	19
2024-06-02	jambes	Fentes	8	20	\N	19
2024-06-03	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-06-03	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-06-03	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-06-03	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-06-03	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-06-03	Pectoraux	Développé Couché haltère	20	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie haut	18	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie bas	18	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie haut	23	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie bas	18	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie haut	23	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie bas	18	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie haut	23	10	\N	19
2024-06-03	Pectoraux	Pectoraux à la poulie bas	18	10	\N	19
2024-06-03	Pectoraux	Triceps à la Poulie	27	10	\N	19
2024-06-03	Pectoraux	Triceps à la Poulie	32	12	\N	19
2024-06-03	Pectoraux	Triceps à la Poulie	36	12	\N	19
2024-06-03	Pectoraux	Triceps à la Poulie	36	12	\N	19
2024-06-03	Pectoraux	Triceps à la Poulie	36	12	\N	19
2024-06-03	Pectoraux	Pec Fly	70	10	\N	19
2024-06-03	Pectoraux	Élévation Frontale Disque	10	10	\N	19
2024-06-03	Pectoraux	Pec Fly	70	10	\N	19
2024-06-03	Pectoraux	Élévation Frontale Disque	10	10	\N	19
2024-06-03	Pectoraux	Pec Fly	70	10	\N	19
2024-06-03	Pectoraux	Élévation Frontale Disque	10	10	\N	19
2024-06-03	Pectoraux	Pec Fly	70	10	\N	19
2024-06-03	Pectoraux	Élévation Frontale Disque	10	10	\N	19
2024-06-03	Pectoraux	Pec Fly	70	10	\N	19
2024-06-03	Pectoraux	Élévation Frontale Disque	10	10	\N	19
2024-06-04	abdos	Rotary Torso	64	10	\N	19
2024-06-04	abdos	Rotary Torso	64	10	\N	19
2024-06-04	abdos	Rotary Torso	64	10	\N	19
2024-06-04	abdos	Rotary Torso	64	10	\N	19
2024-06-04	abdos	Rotary Torso	64	10	\N	19
2024-06-04	abdos	Abdos Machine	15	12	\N	19
2024-06-04	abdos	Abdos Machine	15	12	\N	19
2024-06-04	abdos	Abdos Machine	15	12	\N	19
2024-06-04	abdos	Abdos Machine	15	12	\N	19
2024-06-04	abdos	Abdos Machine	15	12	\N	19
2024-06-04	abdos	Back Extension	10	10	\N	19
2024-06-04	abdos	Back Extension	10	10	\N	19
2024-06-04	abdos	Back Extension	10	10	\N	19
2024-06-04	abdos	Back Extension	10	10	\N	19
2024-06-05	Épaules	Shoulder press	23	12	\N	19
2024-06-05	Épaules	Shoulder press	32	12	\N	19
2024-06-05	Épaules	Shoulder press	36	12	\N	19
2024-06-05	Épaules	Shoulder press	38.3	12	\N	19
2024-06-05	Épaules	Shoulder press	41	12	\N	19
2024-06-05	Épaules	Shoulder press	41	12	bon poid 41	19
2024-06-05	Épaules	Rowing debout	20	10	\N	19
2024-06-05	Épaules	Rowing debout	20	10	\N	19
2024-06-05	Épaules	Rowing debout	20	10	\N	19
2024-06-05	Épaules	Rowing debout	20	10	\N	19
2024-06-05	Épaules	Rowing debout	20	10	Essayer 25 prochaine séance	19
2024-06-05	Épaules	Élévations Latérales Haltères	6	10	\N	19
2024-06-05	Épaules	Élévations Latérales Haltères	6	10	\N	19
2024-06-05	Épaules	Élévations Latérales Haltères	7	10	\N	19
2024-06-05	Épaules	Élévations Latérales Haltères	7	10	\N	19
2024-06-05	Épaules	Élévations Latérales Haltères	7	10	Continuer à 7kg	19
2024-06-05	Épaules	Développé Militaire Haltères	14	10	\N	19
2024-06-05	Épaules	Développé Militaire Haltères	14	10	\N	19
2024-06-07	Dos	Lat Pull prise Poignée	45	12	\N	19
2024-06-07	Dos	Lat Pull prise Poignée	52	12	\N	19
2024-06-07	Dos	Lat Pull prise Poignée	52	12	\N	19
2024-06-07	Dos	Lat Pull prise Poignée	52	12	\N	19
2024-06-07	Dos	Lat Pull prise Poignée	52	12	\N	19
2024-06-07	Dos	Seated Row	52	10	\N	19
2024-06-07	Dos	Seated Row	52	10	\N	19
2024-06-07	Dos	Seated Row	52	10	\N	19
2024-06-07	Dos	Seated Row	52	10	\N	19
2024-06-07	Dos	Seated Row	52	10	\N	19
2024-06-08	Jambes	Squat	60	10	\N	19
2024-06-08	Jambes	Squat	60	10	\N	19
2024-06-08	Jambes	Squat	60	10	\N	19
2024-06-08	Jambes	Squat	60	10	\N	19
2024-06-08	Jambes	Squat	60	10	\N	19
2024-06-08	Jambes	Hip Thrust	100	10	\N	19
2024-06-08	Jambes	Hip Thrust	100	10	\N	19
2024-06-08	Jambes	Hip Thrust	100	10	\N	19
2024-06-08	Jambes	Hip Thrust	100	10	\N	19
2024-06-08	Jambes	Hip Thrust	100	10	\N	19
2024-06-08	Jambes	Hip Abduction	59	12	\N	19
2024-06-08	Jambes	Hip Abduction	59	12	\N	19
2024-06-08	Jambes	Hip Abduction	59	12	\N	19
2024-06-09	Épaules	Développé Militaire Haltères	16	10	\N	19
2024-06-09	Épaules	Développé Militaire Haltères	16	10	\N	19
2024-06-09	Épaules	Développé Militaire Haltères	16	10	\N	19
2024-06-09	Épaules	Développé Militaire Haltères	16	10	\N	19
2024-06-09	Épaules	Développé Militaire Haltères	16	10	\N	19
2024-06-09	Épaules	Développé Couché Prise Serrée	30	10	\N	19
2024-06-09	Épaules	Développé Couché Prise Serrée	35	10	\N	19
2024-06-09	Épaules	Développé Couché Prise Serrée	35	10	\N	19
2024-06-09	Épaules	Développé Militaire Haltères	35	10	\N	19
2024-06-09	Épaules	Développé Couché Prise Serrée	37.5	10	\N	19
2024-06-09	Épaules	Développé Couché Prise Serrée	37.5	10	\N	19
2024-06-10	Bras	Biceps Curl Poulie	30	10	\N	19
2024-06-10	Bras	Biceps Curl Poulie	35	10	\N	19
2024-06-10	Bras	Biceps Curl Poulie	35	10	\N	19
2024-06-10	Bras	Biceps Curl Poulie	35	10	\N	19
2024-06-10	Bras	Biceps Curl Poulie	37.5	10	\N	19
2024-06-10	Bras	Biceps Curl Poulie	37.5	10	\N	19
2024-06-10	Bras	Développé Couché Prise Serrée	30	12	\N	19
2024-06-10	Bras	Développé Couché Prise Serrée	30	12	\N	19
2024-06-10	Bras	Développé Couché Prise Serrée	30	12	\N	19
2024-06-10	Bras	Développé Couché Prise Serrée	30	12	\N	19
2024-06-10	Bras	Développé Couché Prise Serrée	30	12	\N	19
2024-06-11	abdos	Abdos Machine	15	16	\N	19
2024-06-11	abdos	Abdos Machine	15	16	\N	19
2024-06-11	abdos	Abdos Machine	15	16	\N	19
2024-06-11	abdos	Abdos Machine	15	16	\N	19
2024-06-11	abdos	Abdos Machine	15	16	\N	19
2024-06-11	abdos	Rotary Torso	54	15	\N	19
2024-06-11	abdos	Rotary Torso	54	15	\N	19
2024-06-11	abdos	Rotary Torso	54	15	\N	19
2024-06-11	abdos	Back Extension	20	10	\N	19
2024-06-11	abdos	Back Extension	20	10	\N	19
2024-06-11	abdos	Back Extension	20	10	\N	19
2024-06-11	abdos	Back Extension	20	10	\N	19
2024-06-11	abdos	Back Extension	20	10	\N	19
2024-06-12	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-12	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-12	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-12	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-12	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-12	Dos	Rowing buste penché	40	10	\N	19
2024-06-12	Dos	Rowing buste penché	40	10	\N	19
2024-06-12	Dos	Rowing buste penché	40	10	\N	19
2024-06-13	Épaules	Développé Militaire à la barre	40	10	\N	19
2024-06-13	Épaules	Développé Militaire à la barre	50	8	\N	19
2024-06-13	Épaules	Développé Militaire à la barre	50	7	\N	19
2024-06-13	Épaules	Développé Militaire à la barre	50	8	\N	19
2024-06-13	Épaules	Développé Militaire à la barre	40	10	\N	19
2024-06-13	Épaules	Lateral Raise Poulie	6.3	6	\N	19
2024-06-13	Épaules	Lateral Raise Poulie	6.3	6	\N	19
2024-06-13	Épaules	Lateral Raise Poulie	6.3	6	\N	19
2024-06-13	Épaules	Lateral Raise Poulie	6.3	6	\N	19
2024-06-13	Épaules	Lateral Raise Poulie	6.3	6	\N	19
2024-06-13	Épaules	Rowing debout	25	12	\N	19
2024-06-13	Épaules	Rowing debout	25	12	\N	19
2024-06-13	Épaules	Rowing debout	25	12	\N	19
2024-06-13	Épaules	Rowing debout	25	12	\N	19
2024-06-13	Épaules	Rowing debout	25	12	\N	19
2024-06-13	Épaules	Rear Delt	66	12	\N	19
2024-06-13	Épaules	Rear Delt	66	12	\N	19
2024-06-13	Épaules	Rear Delt	66	12	\N	19
2024-06-13	Épaules	Rear Delt	66	12	\N	19
2024-06-13	Épaules	Rear Delt	66	12	\N	19
2024-06-13	Épaules	Élévation Frontale Poulie	18	10	\N	19
2024-06-13	Épaules	Élévation Frontale Poulie	20.3	10	\N	19
2024-06-13	Épaules	Élévation Frontale Poulie	20.3	10	\N	19
2024-06-13	Épaules	Élévation Frontale Poulie	20.3	10	\N	19
2024-06-16	Full body	Squat	60	10	\N	19
2024-06-16	Full body	Squat	70	10	\N	19
2024-06-16	Full body	Squat	70	10	\N	19
2024-06-16	Full body	Squat	70	10	\N	19
2024-06-16	Full body	Squat	70	10	\N	19
2024-06-16	Full body	Développé Couché	20	6	\N	19
2024-06-16	Full body	Élévation Frontale Poulie	18	10	\N	19
2024-06-16	Full body	Dips	\N	10	\N	19
2024-06-16	Full body	Développé Couché	20	6	\N	19
2024-06-16	Full body	Élévation Frontale Poulie	18	10	\N	19
2024-06-16	Full body	Dips	\N	10	\N	19
2024-06-16	Full body	Développé Couché	20	6	\N	19
2024-06-16	Full body	Élévation Frontale Poulie	18	10	\N	19
2024-06-16	Full body	Dips	\N	10	\N	19
2024-06-16	Full body	Développé Couché	20	6	\N	19
2024-06-16	Full body	Élévation Frontale Poulie	18	10	\N	19
2024-06-16	Full body	Dips	\N	10	\N	19
2024-06-16	Full body	Développé Couché	20	6	\N	19
2024-06-16	Full body	Élévation Frontale Poulie	18	10	\N	19
2024-06-16	Full body	Dips	\N	10	\N	19
2024-06-16	Full body	Développé Couché Prise Serrée	40	8	\N	19
2024-06-16	Full body	Développé Couché Prise Serrée	40	10	\N	19
2024-06-16	Full body	Développé Couché Prise Serrée	40	10	\N	19
2024-06-16	Full body	Biceps curl allongé	6	10	\N	19
2024-06-16	Full body	Biceps curl allongé	6	10	\N	19
2024-06-24	Pectoraux	Développé Couché	55	10	\N	19
2024-06-24	Pectoraux	Développé Couché	55	10	\N	19
2024-06-24	Pectoraux	Développé Couché	55	10	\N	19
2024-06-24	Pectoraux	Développé Couché	55	9	\N	19
2024-06-24	Pectoraux	Développé Couché	55	6	\N	19
2024-07-01	Pectoraux	Développé Couché	60	6	\N	19
2024-06-24	Pectoraux	Développé Couché Prise Serrée	40	10	\N	19
2024-06-24	Pectoraux	Développé Couché Prise Serrée	40	10	\N	19
2024-06-24	Pectoraux	Développé Couché Prise Serrée	40	7	\N	19
2024-06-24	Pectoraux	Développé Couché Prise Serrée	40	7	\N	19
2024-06-24	Pectoraux	Pectoraux à la poulie	18	10	\N	19
2024-06-24	Pectoraux	Pectoraux à la poulie	18	10	\N	19
2024-06-24	Pectoraux	Pectoraux à la poulie	18	10	\N	19
2024-06-24	Pectoraux	Pectoraux à la poulie	18	10	\N	19
2024-06-24	Pectoraux	Pectoraux à la poulie	18	10	\N	19
2024-06-25	Full body	Squat	60	15	\N	19
2024-06-25	Full body	Squat	60	15	\N	19
2024-06-25	Full body	Squat	60	15	\N	19
2024-06-25	Full body	Squat	60	15	\N	19
2024-06-25	Full body	Squat	60	15	\N	19
2024-06-25	Full body	Abdominal	45	12	\N	19
2024-06-25	Full body	Abdominal	45	12	\N	19
2024-06-25	Full body	Abdominal	45	12	\N	19
2024-06-25	Full body	Abdominal	45	12	\N	19
2024-06-25	Full body	Mollets sur Leg Press	73	15	\N	19
2024-06-27	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-27	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-27	Dos	Traction avec Élastique	\N	10	\N	19
2024-06-27	Dos	Traction avec Élastique	\N	6	\N	19
2024-06-27	Dos	Traction avec Élastique	\N	6	\N	19
2024-06-27	Dos	Seated Row	59	10	\N	19
2024-06-27	Dos	Seated Row	59	10	\N	19
2024-06-27	Dos	Seated Row	59	10	\N	19
2024-06-27	Dos	Seated Row	52	12	\N	19
2024-06-27	Dos	Seated Row	52	12	\N	19
2024-06-27	Dos	Biceps Curl Prise Marteau	6	10	\N	19
2024-06-27	Dos	Biceps Curl Prise Marteau	6	10	\N	19
2024-06-27	Dos	Biceps Curl Prise Marteau	6	10	\N	19
2024-06-27	Dos	Biceps Curl Prise Marteau	6	10	\N	19
2024-06-27	Dos	Biceps Curl Prise Marteau	6	10	\N	19
2024-06-27	Dos	Biceps Curl Prise Marteau	6	10	\N	19
2024-06-27	Dos	Back Extension	10	10	\N	19
2024-06-27	Dos	Back Extension	10	10	\N	19
2024-06-27	Dos	Back Extension	10	10	\N	19
2024-06-27	Dos	Back Extension	10	10	\N	19
2024-06-27	Dos	Diverging Lat Pull Down	41	10	\N	19
2024-06-27	Dos	Diverging Lat Pull Down	45	10	\N	19
2024-06-27	Dos	Diverging Lat Pull Down	45	10	\N	19
2024-06-27	Dos	Diverging Lat Pull Down	45	10	\N	19
2024-06-27	Dos	Biceps Curl Allongé	6	10	\N	19
2024-06-27	Dos	Biceps Curl Allongé	6	10	\N	19
2024-06-27	Dos	Biceps Curl Allongé	6	10	\N	19
2024-06-28	Épaules	Développé Militaire Haltères	18	10	\N	19
2024-06-28	Épaules	Développé Militaire Haltères	18	10	\N	19
2024-06-28	Épaules	Développé Militaire Haltères	18	10	\N	19
2024-06-28	Épaules	Développé Militaire Haltères	18	7	\N	19
2024-06-28	Épaules	Triceps à la Poulie Inversée	41	10	\N	19
2024-06-28	Épaules	Triceps à la Poulie Inversée	41	10	\N	19
2024-06-28	Épaules	Triceps à la Poulie Inversée	41	12	\N	19
2024-06-28	Épaules	Triceps à la Poulie Inversée	41	12	\N	19
2024-06-28	Épaules	Triceps à la Poulie Inversée	41	12	\N	19
2024-06-28	Épaules	Face Pull Down à la poulie	27	12	\N	19
2024-06-28	Épaules	Face Pull Down à la poulie	29.3	12	\N	19
2024-06-28	Épaules	Face Pull Down à la poulie	32	12	\N	19
2024-06-28	Épaules	Face Pull Down à la poulie	32	12	\N	19
2024-06-28	Épaules	Face Pull Down à la poulie	32	12	\N	19
2024-06-28	Épaules	Rowing debout	25	10	\N	19
2024-06-28	Épaules	Rowing debout	25	12	\N	19
2024-06-28	Épaules	Rowing debout	25	12	\N	19
2024-06-28	Épaules	Rowing debout	25	12	\N	19
2024-06-28	Épaules	Rowing debout	25	12	\N	19
2024-06-28	Épaules	Élévations Latérales Haltères	7	10	\N	19
2024-06-28	Épaules	Élévations Latérales Haltères	7	10	\N	19
2024-06-28	Épaules	Élévations Latérales Haltères	7	10	\N	19
2024-06-28	Épaules	Élévations Latérales Haltères	7	10	\N	19
2024-06-28	Épaules	Élévations Latérales Haltères	7	10	\N	19
2024-06-28	Épaules	Triceps Doubles Chassées à la Poulie	9	10	\N	19
2024-06-28	Épaules	Triceps Doubles Chassées à la Poulie	11.3	12	\N	19
2024-06-28	Épaules	Triceps Doubles Chassées à la Poulie	11.3	10	\N	19
2024-06-28	Épaules	Triceps Doubles Chassées à la Poulie	11.3	10	Hauteur 17	19
2024-06-29	Abdos	Rotary Torso	50	15	\N	19
2024-06-29	Abdos	Rotary Torso	50	15	\N	19
2024-06-29	Abdos	Rotary Torso	50	15	\N	19
2024-06-29	Abdos	Abdos Machine	15	15	\N	19
2024-06-29	Abdos	Abdos Machine	15	15	\N	19
2024-06-29	Abdos	Abdos Machine	15	15	\N	19
2024-06-29	Abdos	Abdos Machine	15	15	\N	19
2024-06-29	Abdos	Biceps Curl Prise Marteau	7	12	\N	19
2024-07-01	Pectoraux	Développé Couché	60	9	\N	19
2024-07-01	Pectoraux	Développé Couché	60	7	\N	19
2024-07-01	Pectoraux	Développé Couché	60	6	\N	19
2024-07-01	Pectoraux	Développé Couché	50	10	\N	19
2024-07-01	Pectoraux	Développé Couché Prise Serrée	40	10	\N	19
2024-07-01	Pectoraux	Développé Couché Prise Serrée	40	6	\N	19
2024-07-01	Pectoraux	Développé Couché Prise Serrée	40	10	\N	19
2024-07-01	Pectoraux	Développé Couché Prise Serrée	40	6	\N	19
2024-07-01	Pectoraux	Pec Fly	79	10	\N	19
2024-07-01	Pectoraux	Pec Fly	79	10	\N	19
2024-07-01	Pectoraux	Pec Fly	79	10	\N	19
2024-07-01	Pectoraux	Pec Fly	79	10	\N	19
2024-07-01	Pectoraux	Pec Fly	79	10	\N	19
2024-07-01	Pectoraux	Triceps à la Poulie Inversée	45	10	\N	19
2024-07-01	Pectoraux	Triceps à la Poulie Inversée	45	10	\N	19
2024-07-01	Pectoraux	Triceps à la Poulie Inversée	45	8	\N	19
2024-07-01	Pectoraux	Triceps à la Poulie Inversée	45	10	\N	19
2024-07-02	Dos	Traction avec Élastique	\N	10	\N	19
2024-07-02	Dos	Traction avec Élastique	\N	10	\N	19
2024-07-02	Dos	Traction avec Élastique	\N	10	\N	19
2024-07-02	Dos	Traction avec Élastique	\N	5	\N	19
2024-07-02	Dos	Traction avec Élastique	\N	5	\N	19
2024-07-02	Dos	Rear Delt	66	12	\N	19
2024-07-02	Dos	Rear Delt	73	10	\N	19
2024-07-02	Dos	Rear Delt	73	10	\N	19
2024-07-02	Dos	Biceps Curl Prise Marteau	8	10	\N	19
2024-07-02	Dos	Biceps Curl Prise Marteau	8	10	\N	19
2024-07-02	Dos	Biceps Curl Prise Marteau	8	10	\N	19
2024-07-02	Dos	Biceps Curl Prise Marteau	8	10	\N	19
2024-07-02	Dos	Biceps Curl Prise Marteau	8	6	\N	19
2024-07-03	Jambes	Squat	60	10	\N	19
2024-07-03	Jambes	Squat	80	10	\N	19
2024-07-03	Jambes	Squat	80	10	\N	19
2024-07-03	Jambes	Squat	80	10	\N	19
2024-07-03	Jambes	Squat	80	10	\N	19
2024-07-03	Jambes	Hip Thrust	120	10	\N	19
2024-07-03	Jambes	Hip Thrust	120	10	\N	19
2024-07-03	Jambes	Hip Thrust	120	10	\N	19
2024-07-03	Jambes	Hip Thrust	120	10	\N	19
2024-07-03	Jambes	Hip Thrust	120	10	Passer à 110 prochaine fois	19
2024-07-03	Jambes	Mollets sur Leg Press	79	10	\N	19
2024-07-03	Jambes	Mollets sur Leg Press	79	10	\N	19
2024-07-03	Jambes	Mollets sur Leg Press	79	10	\N	19
2024-07-03	Jambes	Mollets sur Leg Press	79	10	\N	19
2024-07-03	Jambes	Mollets sur Leg Press	79	10	\N	19
2024-07-03	Jambes	Leg Extension	52	10	\N	19
2024-07-03	Jambes	Leg Extension	52	10	\N	19
2024-07-03	Jambes	Leg Extension	52	10	\N	19
2024-07-03	Jambes	Leg Extension	52	10	\N	19
2024-07-04	Épaules	Développé Militaire	16	12	\N	19
2024-07-04	Épaules	Développé Militaire	16	12	\N	19
2024-07-04	Épaules	Développé Militaire	16	11	\N	19
2024-07-04	Épaules	Développé Militaire	16	8	\N	19
2024-07-04	Épaules	Triceps à la Poulie Inversée	27	12	\N	19
2024-07-04	Épaules	Triceps à la Poulie Inversée	27	12	\N	19
2024-07-04	Épaules	Triceps à la Poulie Inversée	32	12	\N	19
2024-07-04	Épaules	Triceps à la Poulie Inversée	32	12	\N	19
2024-07-04	Épaules	Lateral Raise Poulie	9	7	\N	19
2024-07-04	Épaules	Lateral Raise Poulie	9	7	\N	19
2024-07-04	Épaules	Lateral Raise Poulie	9	7	\N	19
2024-07-05	Abdos	Abs Wheel	\N	12	\N	19
2024-07-05	Abdos	Abs Wheel	\N	12	\N	19
2024-07-05	Abdos	Abs Wheel	\N	12	\N	19
2024-07-05	Abdos	Abs Wheel	\N	12	\N	19
2024-07-05	Abdos	Abs Wheel	\N	12	\N	19
2024-07-05	Abdos	Biceps Curl Poulie	29.3	10	\N	19
2024-07-05	Abdos	Biceps Curl Poulie	27	10	\N	19
2024-07-05	Abdos	Biceps Curl Poulie	27	10	\N	19
2024-07-05	Abdos	Biceps Curl Poulie	27	10	\N	19
2024-07-05	Abdos	Biceps Curl Poulie	27	10	\N	19
2024-07-05	Abdos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-05	Abdos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-05	Abdos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-05	Abdos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-05	Abdos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-06	Pectoraux	Développé Couché	60	7	\N	19
2024-07-06	Pectoraux	Développé Couché	70	3	\N	19
2024-07-06	Pectoraux	Développé Couché	70	3	\N	19
2024-07-06	Pectoraux	Développé Couché	70	2	\N	19
2024-07-06	Pectoraux	Développé Couché	60	7	\N	19
2024-07-06	Pectoraux	Développé Couché	60	4	\N	19
2024-07-06	Pectoraux	Développé Couché incliné haut	40	10	\N	19
2024-07-06	Pectoraux	Développé Couché incliné haut	45	8	\N	19
2024-07-06	Pectoraux	Développé Couché incliné haut	45	9	\N	19
2024-07-06	Pectoraux	Développé Couché incliné haut	45	5	\N	19
2024-07-06	Pectoraux	Pec Fly	79	12	\N	19
2024-07-06	Pectoraux	Pec Fly	86	10	\N	19
2024-07-06	Pectoraux	Pec Fly	86	10	\N	19
2024-07-06	Pectoraux	Pec Fly	86	7	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	7	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	7	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	5	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	5	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	5	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	4	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	4	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	4	\N	19
2024-07-07	Dos	Traction avec Élastique	\N	4	\N	19
2024-07-07	Dos	Biceps Curl Poulie	29.3	10	\N	19
2024-07-07	Dos	Biceps Curl Poulie	29.3	10	\N	19
2024-07-07	Dos	Biceps Curl Poulie	29.3	7	\N	19
2024-07-07	Dos	Biceps Curl Poulie	29.3	6	\N	19
2024-07-07	Dos	Biceps Curl Poulie	23	8	\N	19
2024-07-07	Dos	Back Extension	10	10	\N	19
2024-07-07	Dos	Back Extension	10	10	\N	19
2024-07-07	Dos	Back Extension	15	10	\N	19
2024-07-07	Dos	Back Extension	15	10	\N	19
2024-07-07	Dos	Back Extension	15	10	\N	19
2024-07-07	Dos	Rear Delt	66	12	\N	19
2024-07-07	Dos	Rear Delt	66	12	\N	19
2024-07-07	Dos	Rear Delt	66	12	\N	19
2024-07-07	Dos	Rear Delt	66	6	\N	19
2024-07-07	Dos	Rear Delt	66	6	\N	19
2024-07-07	Dos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-07	Dos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-07	Dos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-07	Dos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-07	Dos	Biceps Curl Prise Marteau	7	10	\N	19
2024-07-08	Tricpeps Abdos	Triceps à la Poulie Inversée	36	12	\N	19
2024-07-08	Tricpeps Abdos	Triceps à la Poulie Inversée	41	12	\N	19
2024-07-08	Tricpeps Abdos	Triceps à la Poulie Inversée	41	12	\N	19
2024-07-08	Tricpeps Abdos	Triceps à la Poulie Inversée	41	12	\N	19
2024-07-08	Tricpeps Abdos	Triceps à la Poulie Inversée	41	12	\N	19
2024-07-08	Tricpeps Abdos	Triceps à la Poulie Inversée	41	12	\N	19
2024-07-08	Tricpeps Abdos	Abdos Machine	15	13	\N	19
2024-07-08	Tricpeps Abdos	Abdos Machine	15	8	\N	19
2024-07-09	Épaules	Développé Militaire Haltères	18	10	\N	19
2024-07-09	Épaules	Développé Militaire Haltères	20	7	\N	19
2024-07-09	Épaules	Développé Militaire Haltères	20	4	\N	19
2024-07-09	Épaules	Développé Militaire Haltères	20	5	\N	19
2024-07-09	Épaules	Développé Militaire Haltères	20	4	\N	19
2024-07-09	Épaules	Développé Militaire Haltères	18	5	\N	19
2024-07-09	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-09	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-09	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-09	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-09	Épaules	Rowing Menton	20	10	\N	19
2024-07-09	Épaules	Rowing Menton	20	10	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	42.5	10	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	42.5	10	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	42.5	10	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	42.5	10	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	40	10	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	42.5	8	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	42.5	10	\N	19
2024-07-10	Pectoraux	Développé Couché incliné haut	42.5	10	\N	19
2024-07-10	Pectoraux	Tirage Menton	32	12	\N	19
2024-07-10	Pectoraux	Tirage Menton	32	12	\N	19
2024-07-10	Pectoraux	Tirage Menton	32	12	\N	19
2024-07-10	Pectoraux	Tirage Menton	32	12	\N	19
2024-07-10	Pectoraux	Tirage Menton	32	12	\N	19
2024-07-10	Pectoraux	Rotary Torso	64	12	\N	19
2024-07-10	Pectoraux	Rotary Torso	64	12	\N	19
2024-07-10	Pectoraux	Rotary Torso	64	12	\N	19
2024-07-10	Pectoraux	Triceps Double Chassées Croisé à la poulie	14	12	\N	19
2024-07-10	Pectoraux	Triceps Double Chassées Croisé à la poulie	16.3	10	\N	19
2024-07-10	Pectoraux	Triceps Double Chassées Croisé à la poulie	16.3	10	\N	19
2024-07-10	Pectoraux	Triceps Double Chassées Croisé à la poulie	14	10	\N	19
2024-07-11	Abdos Biceps	Abs Wheel	\N	10	\N	19
2024-07-11	Abdos Biceps	Abs Wheel	\N	10	\N	19
2024-07-11	Abdos Biceps	Abs Wheel	\N	10	\N	19
2024-07-11	Abdos Biceps	Abs Wheel	\N	10	\N	19
2024-07-11	Abdos Biceps	Abs Wheel	\N	10	\N	19
2024-07-11	Abdos Biceps	Abdos Machine	15	10	\N	19
2024-07-11	Abdos Biceps	Abdos Machine	15	10	\N	19
2024-07-11	Abdos Biceps	Abdos Machine	15	10	\N	19
2024-07-11	Abdos Biceps	Abdos Machine	15	10	\N	19
2024-07-11	Abdos Biceps	Abdos Machine	15	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Allongé	8	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Allongé	8	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Allongé	8	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Allongé	8	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Allongé	8	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Prise Marteau à la Poulie	23	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Prise Marteau à la Poulie	27	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Prise Marteau à la Poulie	27	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Prise Marteau à la Poulie	27	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Prise Marteau à la Poulie	27	10	\N	19
2024-07-11	Abdos Biceps	Biceps Curl Prise Marteau à la Poulie	27	10	\N	19
2024-07-12	Dos	Lat Pull	59.3	10	\N	19
2024-07-12	Dos	Lat Pull	59.3	10	\N	19
2024-07-12	Dos	Lat Pull	59.3	10	\N	19
2024-07-12	Dos	Lat Pull	59.3	10	\N	19
2024-07-12	Dos	Lat Pull	59.3	10	\N	19
2024-07-12	Dos	Seated Row	59	10	\N	19
2024-07-12	Dos	Seated Row	59	10	\N	19
2024-07-12	Dos	Seated Row	59	10	\N	19
2024-07-12	Dos	Seated Row	59	10	\N	19
2024-07-12	Dos	Seated Row	59	10	\N	19
2024-07-14	Jambes	Biceps Curl Assis	8	12	\N	19
2024-07-14	Jambes	Biceps Curl Assis	8	12	\N	19
2024-07-14	Jambes	Biceps Curl Assis	8	12	\N	19
2024-07-14	Jambes	Biceps Curl Assis	8	12	\N	19
2024-07-14	Jambes	Squat	85	10	\N	19
2024-07-14	Jambes	Squat	85	10	\N	19
2024-07-14	Jambes	Squat	85	10	\N	19
2024-07-14	Jambes	Squat	85	10	\N	19
2024-07-14	Jambes	Squat	85	10	\N	19
2024-07-14	Jambes	Hip Thrust	100	10	\N	19
2024-07-14	Jambes	Hip Thrust	100	10	\N	19
2024-07-14	Jambes	Hip Thrust	100	10	\N	19
2024-07-14	Jambes	Hip Thrust	100	10	\N	19
2024-07-14	Jambes	Hip Thrust	100	10	\N	19
2024-07-15	Pectoraux	Développé Couché	60	9	\N	19
2024-07-15	Pectoraux	Développé Couché	60	7	\N	19
2024-07-15	Pectoraux	Développé Couché	60	5	\N	19
2024-07-15	Pectoraux	Développé Couché	60	6	\N	19
2024-07-15	Pectoraux	Développé Couché	60	6	\N	19
2024-07-15	Pectoraux	Développé Couché incliné bas	40	10	\N	19
2024-07-15	Pectoraux	Développé Couché incliné bas	50	10	\N	19
2024-07-15	Pectoraux	Développé Couché incliné bas	50	10	\N	19
2024-07-15	Pectoraux	Développé Couché incliné bas	50	10	\N	19
2024-07-15	Pectoraux	Développé Couché incliné bas	50	10	\N	19
2024-07-15	Pectoraux	Triceps à la Poulie Inversée	36	12	\N	19
2024-07-15	Pectoraux	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-15	Pectoraux	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-15	Pectoraux	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-15	Pectoraux	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-15	Pectoraux	Pec Fly	66	10	\N	19
2024-07-15	Pectoraux	Pec Fly	66	10	\N	19
2024-07-16	Épaules	Développé Militaire à la Smith Machine	45	10	\N	19
2024-07-16	Épaules	Développé Militaire à la Smith Machine	45	10	\N	19
2024-07-16	Épaules	Développé Militaire à la Smith Machine	45	10	\N	19
2024-07-16	Épaules	Développé Militaire à la Smith Machine	45	10	\N	19
2024-07-16	Épaules	Développé Militaire à la Smith Machine	45	10	\N	19
2024-07-16	Épaules	Triceps Double Chassées Croisé à la poulie	9	10	\N	19
2024-07-16	Épaules	Triceps Double Chassées Croisé à la poulie	14	10	\N	19
2024-07-16	Épaules	Triceps Double Chassées Croisé à la poulie	16.3	10	\N	19
2024-07-16	Épaules	Triceps Double Chassées Croisé à la poulie	16.3	10	\N	19
2024-07-16	Épaules	Triceps Double Chassées Croisé à la poulie	16.3	8	\N	19
2024-07-16	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-16	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-16	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-16	Épaules	Lateral Raise Poulie	9	10	\N	19
2024-07-16	Épaules	Élévation Frontale Poulie	18	8	\N	19
2024-07-18	Dos	Traction avec Élastique	\N	10	\N	19
2024-07-18	Dos	Traction avec Élastique	\N	10	\N	19
2024-07-18	Dos	Traction avec Élastique	\N	7	\N	19
2024-07-18	Dos	Traction avec Élastique	\N	7	\N	19
2024-07-18	Dos	Traction avec Élastique	\N	8	\N	19
2024-07-18	Dos	Rowing Bar	55	10	\N	19
2024-07-18	Dos	Rowing Bar	60	10	\N	19
2024-07-18	Dos	Rowing Bar	60	10	\N	19
2024-07-18	Dos	Rowing Bar	60	10	\N	19
2024-07-18	Dos	Biceps Curl Allongé	7	10	\N	19
2024-07-18	Dos	Biceps Curl Allongé	7	10	\N	19
2024-07-19	Haut du corp	Développé Couché incliné haut	40	12	\N	19
2024-07-19	Haut du corp	Développé Couché incliné haut	45	10	\N	19
2024-07-18	Haut du corp	Développé Couché incliné haut	45	9	\N	19
2024-07-18	Haut du corp	Développé Couché incliné haut	45	10	\N	19
2024-07-18	Haut du corp	Développé Couché incliné haut	45	10	\N	19
2024-07-18	Haut du corp	Abs Wheel	\N	10	\N	19
2024-07-18	Haut du corp	Abs Wheel	\N	10	\N	19
2024-07-18	Haut du corp	Abs Wheel	\N	10	\N	19
2024-07-18	Haut du corp	Abs Wheel	\N	10	\N	19
2024-07-18	Haut du corp	Abs Wheel	\N	10	\N	19
2024-07-18	Haut du corp	Triceps à la Poulie Inversée	41	12	\N	19
2024-07-18	Haut du corp	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-18	Haut du corp	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-18	Haut du corp	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-18	Haut du corp	Triceps à la Poulie Inversée	41	10	\N	19
2024-07-18	Haut du corp	Rotary Torso	59	12	\N	19
2024-07-18	Haut du corp	Rotary Torso	59	12	\N	19
2024-07-18	Haut du corp	Rotary Torso	59	12	\N	19
2024-07-18	Haut du corp	Back Extension	10	10	\N	19
2024-07-18	Haut du corp	Back Extension	10	10	\N	19
2024-07-18	Haut du corp	Back Extension	10	10	\N	19
2024-07-18	Haut du corp	Back Extension	10	10	\N	19
2024-07-18	Haut du corp	Développé Couché Prise Serrée	45	10	\N	19
2024-07-18	Haut du corp	Développé Couché Prise Serrée	45	8	\N	19
2024-07-18	Haut du corp	Développé Couché Prise Serrée	45	10	\N	19
2024-07-18	Haut du corp	Développé Couché Prise Serrée	45	8	\N	19
\.


--
-- Data for Name: series_exercices; Type: TABLE DATA; Schema: public; Owner: louismartindunord
--

COPY public.series_exercices (series_id, exercices_id, duree, nombre_repetition) FROM stdin;
26	25	\N	10
26	26	\N	20
26	27	\N	7
26	28	\N	12
\.


--
-- Data for Name: sport_exercices; Type: TABLE DATA; Schema: public; Owner: louis
--

COPY public.sport_exercices (id, name) FROM stdin;
26	Vélo Elliptique
27	Cross Trainning
28	Tennis
311	Course sur Tapis
\N	Ping Pong
\N	Kettlebell Swings
\N	Natation
\N	Yoga
\.


--
-- Data for Name: sport_rows; Type: TABLE DATA; Schema: public; Owner: louis
--

COPY public.sport_rows (date_seance, sport, exercice, duree, commentaire, id, user_id) FROM stdin;
2024-02-24	Cardio	Vélo Elliptique	30	\N	26	19
2024-02-24	Cardio	Cross Trainning	30	\N	27	19
2024-02-24	Cardio	Tennis	60	\N	28	19
2024-02-03	Cardio	Cross Trainning	\N	20 pompes \n20 ballons mur en équilibres \n12 abdos avec poids \n20 montée caisse \n10abdos circulaire avec poid \n20 Planche militaire 	95	19
2024-04-03	Cardio	Tennis	60	\N	143	19
2024-07-03	Cardio	Vélo Elliptique	25	\N	159	19
2024-07-03	Cardio	\N	\N	Pompes\nEpaules\nAbdo allongée jambes levée \nExercice avec poid \nPlanche \nAbs Wheel\nSquat avec haltères 16kg	160	19
2024-10-03	Cardio	Tennis	60	\N	188	19
2024-03-24	Cardio	Tennis	60	\N	225	19
2024-03-25	Cardio	Vélo Elliptique	30	intensité 13 calorie 381 distances 2,72 km 	226	19
2024-04-19	Cardio	Course sur Tapis	7.2	Intensité 8	311	19
2024-04-27	Cardio	Vélo Elliptique	25	\N	337	19
\N	Cardio	Cross Trainning	\N	Séance de Cardio : \n Pompes \n Squat 15kg x15\nAbdos levée de jambes x15\nFentes 16kg\nMontée de boxe 15x\nAbdo avec poid 10kg x 10	338	19
2024-02-05	Cardio	Cross Trainning	60	\N	374	19
2024-05-13	Cardio	Vélo Elliptique	30	\N	457	19
2024-05-13	Cardio	Vélo Elliptique	10	\N	466	19
2024-05-13	Cardio	Cross Trainning	60	\N	467	19
2024-05-15	Cardio	Tennis	60	\N	487	19
2024-05-18	Cardio	Cross Trainning	60	\N	507	19
2024-05-21	Cardio	Course sur Tapis	\N	\N	554	19
2024-05-21	Cardio	Tennis	60	\N	569	19
2024-05-21	Cardio	Cross Trainning	60	\N	570	19
2024-05-22	Cardio	Vélo Elliptique	30	\N	571	19
2024-05-23	Cardio	Tennis	60	\N	594	19
2024-05-27	Cardio	Cross Trainning	60	\N	642	19
2024-05-29	Cardio	Vélo Elliptique	30	\N	655	19
2024-06-03	Cardio	Tennis	60	\N	751	19
2024-06-06	Cardio	Tennis	60	\N	784	19
2024-06-09	Cardio	Tennis	120	\N	808	19
2024-06-12	Cardio	Vélo Elliptique	30	\N	844	19
2024-06-13	Cardio	Vélo Elliptique	30	\N	853	19
2024-06-24	Cardio	Tennis	90	\N	917	19
2024-06-29	Cardio	Vélo Elliptique	30	\N	983	19
2024-06-29	Cardio	Tennis	60	\N	992	19
2024-06-30	Cardio	Tennis	60	\N	993	19
2024-07-01	Cardio	Stepper	\N	\N	1012	19
2024-07-02	Cardio	Tennis	60	\N	1026	19
2024-07-03	Cardio	Cross-Trainning	60	\N	1046	19
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: louismartindunord
--

COPY public.users (id, username, password, user_right, email) FROM stdin;
19	louismn	$argon2id$v=19$m=65536,t=3,p=4$RDZIVl2gerhsX8DoSRvGYw$QX7YuRifemV04iNLBaLFjWV13XAsqx3n5PZV+bCb0js	admin                         	l.martindunord@gmail.com
\.


--
-- Data for Name: users_informations; Type: TABLE DATA; Schema: public; Owner: louismartindunord
--

COPY public.users_informations (id, user_id, poid, taille, objectif, modification_date) FROM stdin;
1	19	92.40	183.00	Perdre du poid	2024-09-20 13:05:44.547555
2	19	92.40	183.00	Perdre du poid	2024-09-20 14:37:21.335967
\.


--
-- Name: cross_trainning_exercices_exercices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: louismartindunord
--

SELECT pg_catalog.setval('public.cross_trainning_exercices_exercices_id_seq', 28, true);


--
-- Name: cross_trainning_rows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: louismartindunord
--

SELECT pg_catalog.setval('public.cross_trainning_rows_id_seq', 1, false);


--
-- Name: cross_trainning_series_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: louismartindunord
--

SELECT pg_catalog.setval('public.cross_trainning_series_series_id_seq', 26, true);


--
-- Name: muscle_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: louis
--

SELECT pg_catalog.setval('public.muscle_area_id_seq', 11, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: louismartindunord
--

SELECT pg_catalog.setval('public.users_id_seq', 44, true);


--
-- Name: users_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: louismartindunord
--

SELECT pg_catalog.setval('public.users_informations_id_seq', 2, true);


--
-- Name: cross_trainning_exercices cross_trainning_exercices_pkey; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_exercices
    ADD CONSTRAINT cross_trainning_exercices_pkey PRIMARY KEY (exercices_id);


--
-- Name: cross_trainning_rows cross_trainning_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_rows
    ADD CONSTRAINT cross_trainning_rows_pkey PRIMARY KEY (id);


--
-- Name: cross_trainning_series cross_trainning_series_pkey; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_series
    ADD CONSTRAINT cross_trainning_series_pkey PRIMARY KEY (series_id);


--
-- Name: muscle_area muscle_area_pkey; Type: CONSTRAINT; Schema: public; Owner: louis
--

ALTER TABLE ONLY public.muscle_area
    ADD CONSTRAINT muscle_area_pkey PRIMARY KEY (id);


--
-- Name: cross_trainning_series unique_cross_serie_name; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_series
    ADD CONSTRAINT unique_cross_serie_name UNIQUE (name);


--
-- Name: muscle_area unique_name; Type: CONSTRAINT; Schema: public; Owner: louis
--

ALTER TABLE ONLY public.muscle_area
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: users unique_username; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_informations users_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users_informations
    ADD CONSTRAINT users_informations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: cross_trainning_rows cross_trainning_rows_cross_trainning_serie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_rows
    ADD CONSTRAINT cross_trainning_rows_cross_trainning_serie_id_fkey FOREIGN KEY (cross_trainning_serie_id) REFERENCES public.cross_trainning_series(series_id);


--
-- Name: cross_trainning_rows cross_trainning_rows_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.cross_trainning_rows
    ADD CONSTRAINT cross_trainning_rows_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: series_exercices series_exercices_exercices_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.series_exercices
    ADD CONSTRAINT series_exercices_exercices_id_fkey FOREIGN KEY (exercices_id) REFERENCES public.cross_trainning_exercices(exercices_id) ON DELETE CASCADE;


--
-- Name: series_exercices series_exercices_series_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.series_exercices
    ADD CONSTRAINT series_exercices_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.cross_trainning_series(series_id) ON DELETE CASCADE;


--
-- Name: users_informations users_informations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: louismartindunord
--

ALTER TABLE ONLY public.users_informations
    ADD CONSTRAINT users_informations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

