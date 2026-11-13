--
-- PostgreSQL database dump
--

\restrict R7yQ7TkHob8NHix4Xm1tCYoZJgeeUR6ae8o0P73PxX6mTh1ER9igbDOzZg7k7uB

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.4

-- Started on 2026-11-11 18:13:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 17696)
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(200) NOT NULL
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17695)
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_id_seq OWNER TO postgres;

--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 231
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- TOC entry 236 (class 1259 OID 17718)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17717)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 235
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 224 (class 1259 OID 17642)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17641)
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO postgres;

--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 223
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 244 (class 1259 OID 17815)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17814)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 243
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 240 (class 1259 OID 17775)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17774)
-- Name: order_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_statuses_id_seq OWNER TO postgres;

--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 239
-- Name: order_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_statuses_id_seq OWNED BY public.order_statuses.id;


--
-- TOC entry 242 (class 1259 OID 17786)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    client_id integer NOT NULL,
    pickup_point_id integer NOT NULL,
    pickup_code integer NOT NULL,
    status_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17785)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 241
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 228 (class 1259 OID 17664)
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    postal_code character varying(10) NOT NULL,
    city_id integer NOT NULL,
    street_id integer NOT NULL,
    house_number character varying(20)
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17663)
-- Name: pickup_points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickup_points_id_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 227
-- Name: pickup_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


--
-- TOC entry 238 (class 1259 OID 17729)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    article character varying(20) NOT NULL,
    name character varying(300) NOT NULL,
    unit_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    author_id integer NOT NULL,
    publisher_id integer NOT NULL,
    category_id integer NOT NULL,
    discount numeric(5,2) DEFAULT 0 NOT NULL,
    stock_quantity integer DEFAULT 0 NOT NULL,
    description text,
    photo character varying(255),
    CONSTRAINT products_discount_check CHECK (((discount >= (0)::numeric) AND (discount <= (100)::numeric))),
    CONSTRAINT products_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT products_stock_quantity_check CHECK ((stock_quantity >= 0))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17728)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 237
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 234 (class 1259 OID 17707)
-- Name: publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishers (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.publishers OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17706)
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publishers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publishers_id_seq OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 233
-- Name: publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publishers_id_seq OWNED BY public.publishers.id;


--
-- TOC entry 220 (class 1259 OID 17612)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17611)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 226 (class 1259 OID 17653)
-- Name: streets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.streets (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.streets OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17652)
-- Name: streets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.streets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.streets_id_seq OWNER TO postgres;

--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 225
-- Name: streets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.streets_id_seq OWNED BY public.streets.id;


--
-- TOC entry 230 (class 1259 OID 17685)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17684)
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_id_seq OWNER TO postgres;

--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 229
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- TOC entry 222 (class 1259 OID 17623)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    login character varying(150) NOT NULL,
    password character varying(100) NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17622)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4821 (class 2604 OID 17699)
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- TOC entry 4823 (class 2604 OID 17721)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4817 (class 2604 OID 17645)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 4829 (class 2604 OID 17818)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4827 (class 2604 OID 17778)
-- Name: order_statuses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses ALTER COLUMN id SET DEFAULT nextval('public.order_statuses_id_seq'::regclass);


--
-- TOC entry 4828 (class 2604 OID 17789)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4819 (class 2604 OID 17667)
-- Name: pickup_points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points ALTER COLUMN id SET DEFAULT nextval('public.pickup_points_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 17732)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 4822 (class 2604 OID 17710)
-- Name: publishers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers ALTER COLUMN id SET DEFAULT nextval('public.publishers_id_seq'::regclass);


--
-- TOC entry 4815 (class 2604 OID 17615)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 17656)
-- Name: streets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets ALTER COLUMN id SET DEFAULT nextval('public.streets_id_seq'::regclass);


--
-- TOC entry 4820 (class 2604 OID 17688)
-- Name: units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 17626)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5052 (class 0 OID 17696)
-- Dependencies: 232
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authors (id, name) VALUES (1, 'Виктор Астафьев');
INSERT INTO public.authors (id, name) VALUES (2, 'Гилберт Кит Честертон');
INSERT INTO public.authors (id, name) VALUES (3, 'Кирилл Каланджи');
INSERT INTO public.authors (id, name) VALUES (4, 'Людмила Улицкая');
INSERT INTO public.authors (id, name) VALUES (5, 'Аркадий Гайдар');
INSERT INTO public.authors (id, name) VALUES (6, 'Юрий Родичев');
INSERT INTO public.authors (id, name) VALUES (7, 'Дэниел Джей Барретт');
INSERT INTO public.authors (id, name) VALUES (8, 'Шон Кэрролл');
INSERT INTO public.authors (id, name) VALUES (9, 'Яков Гордин');
INSERT INTO public.authors (id, name) VALUES (10, 'Иосиф Бродский');
INSERT INTO public.authors (id, name) VALUES (11, 'Янь Чуннянь Янь Чуннянь');
INSERT INTO public.authors (id, name) VALUES (12, 'Дмитрий Мережковский');
INSERT INTO public.authors (id, name) VALUES (13, 'Дмитрий Щербаков');
INSERT INTO public.authors (id, name) VALUES (14, 'Роджер Осборн, Дэн Стерджис');
INSERT INTO public.authors (id, name) VALUES (15, 'Любовь Беликова, Инна Ерофеева, Татьяна Шутова');
INSERT INTO public.authors (id, name) VALUES (16, 'Сергей Моргачев');
INSERT INTO public.authors (id, name) VALUES (17, 'Екатерина Габарта, Ирина Игнатьева');
INSERT INTO public.authors (id, name) VALUES (18, 'Татьяна Лопаткина, Софья Маннапова');


--
-- TOC entry 5056 (class 0 OID 17718)
-- Dependencies: 236
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories (id, name) VALUES (1, 'Художественная литература');
INSERT INTO public.categories (id, name) VALUES (2, 'Учебник для вузов');
INSERT INTO public.categories (id, name) VALUES (3, 'Хрестоматия');
INSERT INTO public.categories (id, name) VALUES (4, 'Учебное пособие');


--
-- TOC entry 5044 (class 0 OID 17642)
-- Dependencies: 224
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cities (id, name) VALUES (1, 'г. Лесной');


--
-- TOC entry 5064 (class 0 OID 17815)
-- Dependencies: 244
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (1, 1, 2, 2);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (2, 1, 1, 2);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (3, 2, 2, 1);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (4, 2, 1, 1);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (5, 3, 3, 10);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (6, 3, 4, 10);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (7, 4, 5, 5);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (8, 4, 3, 4);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (9, 5, 6, 20);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (10, 5, 7, 20);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (11, 6, 2, 2);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (12, 6, 1, 2);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (13, 7, 8, 3);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (14, 7, 9, 3);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (15, 8, 6, 1);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (16, 8, 5, 1);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (17, 9, 10, 5);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (18, 9, 9, 1);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (19, 10, 10, 5);
INSERT INTO public.order_items (id, order_id, product_id, quantity) VALUES (20, 10, 9, 5);


--
-- TOC entry 5060 (class 0 OID 17775)
-- Dependencies: 240
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_statuses (id, name) VALUES (1, 'Завершен');
INSERT INTO public.order_statuses (id, name) VALUES (2, 'Новый');


--
-- TOC entry 5062 (class 0 OID 17786)
-- Dependencies: 242
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (2, '2023-09-28', '2024-04-21', 7, 11, 902, 1);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (3, '2024-03-21', '2024-04-22', 8, 2, 903, 1);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (4, '2024-02-20', '2024-04-23', 9, 11, 904, 1);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (5, '2024-03-17', '2024-04-24', 10, 2, 905, 1);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (6, '2024-03-01', '2024-04-25', 7, 15, 906, 1);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (7, '2024-02-02', '2024-04-26', 8, 3, 907, 1);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (8, '2024-03-31', '2024-04-27', 9, 19, 908, 2);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (9, '2024-04-02', '2024-04-28', 10, 5, 909, 2);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (10, '2024-04-03', '2024-04-29', 10, 19, 910, 2);
INSERT INTO public.orders (id, order_date, delivery_date, client_id, pickup_point_id, pickup_code, status_id) VALUES (1, '2024-02-27', '2024-04-20', 10, 1, 979, 1);


--
-- TOC entry 5048 (class 0 OID 17664)
-- Dependencies: 228
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (1, '420151', 1, 1, '32');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (2, '125061', 1, 2, '8');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (3, '630370', 1, 3, '24');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (4, '400562', 1, 4, '32');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (5, '614510', 1, 5, '47');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (6, '410542', 1, 6, '46');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (7, '620839', 1, 7, '8');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (8, '443890', 1, 8, '1');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (9, '603379', 1, 9, '46');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (10, '603721', 1, 10, '41');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (11, '410172', 1, 11, '13');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (12, '614611', 1, 12, '50');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (13, '454311', 1, 13, '19');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (14, '660007', 1, 14, '19');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (15, '603036', 1, 15, '4');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (16, '394060', 1, 16, '43');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (17, '410661', 1, 17, '50');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (18, '625590', 1, 8, '20');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (19, '625683', 1, 19, NULL);
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (20, '450983', 1, 20, '26');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (21, '394782', 1, 21, '3');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (22, '603002', 1, 22, '28');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (23, '450558', 1, 23, '30');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (24, '344288', 1, 21, '1');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (25, '614164', 1, 25, '30');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (26, '394242', 1, 8, '43');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (27, '660540', 1, 27, '25');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (28, '125837', 1, 3, '40');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (29, '125703', 1, 29, '49');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (30, '625283', 1, 30, '46');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (31, '614753', 1, 31, '35');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (32, '426030', 1, 5, '44');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (33, '450375', 1, 33, '44');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (34, '625560', 1, 34, '12');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (35, '630201', 1, 20, '17');
INSERT INTO public.pickup_points (id, postal_code, city_id, street_id, house_number) VALUES (36, '190949', 1, 36, '26');


--
-- TOC entry 5058 (class 0 OID 17729)
-- Dependencies: 238
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (2, 'G843H5', 'Тайны и загадки отца БраунаТайны и загадки отца Брауна', 1, 193.00, 2, 1, 1, 30.00, 9, 'Гилберт Кит Честертон — признанный классик английской литературы, один из самых ярких писателей первой половины XX века. Классикой стали его романы и многочисленные эссе, однако любовь массового читателя принесли ему рассказы об отце Брауне, тихом, застенчивом священнике, мастерски раскрывающем наиболее запутанные загадки и преступления.', '2.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (3, 'D325D4', 'Девайс', 1, 1599.00, 3, 2, 1, 5.00, 12, 'Молодой фрилансер Захар Скаро устраивается на очередную подработку. Задача, казалось бы, тривиальная: тестирование нового устройства. Вот только вопрос в том, тестированием какой реальности занимается этот новый Девайс?', '3.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (4, 'S432T5', 'Необыкновенное обыкновенное чудо. Школьные истории', 1, 549.00, 4, 2, 1, 15.00, 15, NULL, '4.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (5, 'F325D4', 'Чук и Гек', 1, 209.00, 5, 2, 1, 18.00, 3, 'В книгу вошли повести и рассказы Аркадия Петровича Гайдара: "Чук и Гек", "Горячий камень" и "Сказка о военной тайне, о Мальчише-Кибальчише и его твердом слове"', '5.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (6, 'G432G6', 'Информационная безопасность. Национальные стандарты Российской Федерации. 3-е издание. Учебное пособие', 1, 3899.00, 6, 3, 2, 22.00, 3, 'В учебном пособии рассмотрено более 300 действующих открытых документов национальной системы стандартизации Российской Федерации, включая международные и межгосударственные стандарты в области информационной безопасности по состоянию на начало 2023 года.', '6.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (7, 'H542F5', 'Linux. Командная строка. Лучшие практики', 1, 1799.00, 7, 3, 2, 4.00, 5, 'Перейдите на новый уровень работы в Linux! Если вы системный администратор, разработчик программного обеспечения, SRE-инженер или пользователь Linux, книга поможет вам работать быстрее, элегантнее и эффективнее.', '7.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (8, 'C346F5', 'Квантовые миры и возникновение пространства-времени', 1, 1349.00, 8, 3, 2, 5.00, 4, 'Шон Кэрролл — физик-теоретик и один из самых известных в мире популяризаторов науки — заставляет нас по-новому взглянуть на физику. Столкновение с главной загадкой квантовой механики полностью поменяет наши представления о пространстве и времени.', '8.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (9, 'F256G6', 'Вселенная. Происхождение жизни, смысл нашего существования и огромный космос', 1, 1799.00, 8, 3, 2, 6.00, 2, 'Знаменитый физик Шон Кэрролл в свойственной ему увлекательной манере объясняет принципы, которые лежат в основах научных революций от Дарвина до Эйнштейна, и показывает как невероятные научные открытия последнего столетия изменили наш мир.', '9.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (10, 'J532V5', 'Пушкин. Бродский. Империя и судьба. В 2-х томах (комплект из 2-х книг)', 1, 529.00, 9, 4, 3, 8.00, 6, 'Первая книга двухтомника «Пушкин. Бродский. Империя и судьба» пронизана пушкинской темой. Пушкин — «певец империи и свободы» — присутствует даже там, где он впрямую не упоминается, ибо его судьба, как и судьба других героев книги, органично связана с трагедией великой империи.', '10.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (11, 'G643F4', 'Иосиф Бродский. Избранные эссе (комплект из 6-ти книг)', 1, 4925.00, 10, 5, 3, 2.00, 24, 'Шесть сборников избранных эссе Иосифа Бродского (1940-1996), великого поэта, драматурга, мыслителя, лауреата Нобелевской премии по литературе (1987): «Будущее или далекое прошлое», «Верь своей боли», «Как читать книгу», «О русской литературе», «О тирании», «Путеводитель по переименованному городу». Все тексты представлены на английском языке и в переводе на русский и открывают автора не только как поэта, но как историка, критика, и глубокого и ироничного мыслителя.', '11.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (12, 'J326V5', 'Тысячелетие императорской керамикиv', 1, 2599.00, 11, 5, 3, 5.00, 4, 'Фарфор стал величайшим символом китайской культуры. Это одно из выдающихся изобретений, внесших неоценимый вклад в мировую цивилизацию.', '12.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (13, 'J632F6', 'Вечные спутники: Портреты из всемирной литературы', 1, 1599.00, 12, 5, 3, 0.00, 6, 'Книга "Вечные спутники" - это цикл критических очерков о культуре и великих литераторах, сопровождавших жизнь и творчество русского писателя, поэта, литературного критика и общественного деятеля Дмитрия Мережковского (1865–1941).', '13.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (1, 'А112Т4', 'Прокляты и убиты', 1, 585.00, 1, 1, 1, 25.00, 6, 'Роман-эпопею "Прокляты и убиты" Виктора Астафьева по праву считают одним из самых сильных и пронзительных произведений отечественной военной прозы.', '0a8a721130454fd09c30fd5f917abc37.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (14, 'G632H6', 'Формирование литературной репутации Н.Г.Чернышевского в ХIX-XXI веках', 1, 1349.00, 13, 6, 3, 2.00, 8, 'Монография Д. А. Щербакова - новаторская. Поэтапно рассмотрены не только многочисленные суждения известных отечественных и зарубежных критиков, литературоведов, философов и политиков, различным образом характеризовавших Н. Г. Чернышевского в связи и вне связи со знаменитым романом "Что делать?', '14.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (15, 'G543F5', 'Религиозные верования с древнейших времен до наших дней', 1, 879.00, 13, 7, 3, 4.00, 6, 'Настоящее издание представляет собой сборник переводов лекций по истории дохристианских и нехристианских религий, прочитанных в Лондоне в период с 1888 по 1891 гг. авторитетными исследователями данного раздела религиоведения.', '16.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (16, 'M642E5', 'Теория искусства. Краткий путеводитель', 1, 879.00, 14, 6, 3, 3.00, 2, NULL, '15.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (17, 'B653G6', 'Русский язык: Первые шаги. Часть 3. Учебное пособие', 1, 2699.00, 15, 8, 4, 8.00, 9, 'Пособие является завершающей частью учебного комплекса. Третья часть содержит 10 уроков (21-30, последний-повторительный). Усвоение лексико-грамматического материала рассчитано примерно на 200-240 часов аудиторных занятий.', '17.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (18, 'J735J7', 'Синтетический образ индивидуального психического мира', 1, 1099.00, 16, 8, 3, 9.00, 4, 'Психика подобна определенным объектам, это фиксируют сами люди в языке и искусстве. В данном исследовании рассматриваются в этом плане образы сосуда, воронки, дерева и крепости.', '18.jpg');
INSERT INTO public.products (id, article, name, unit_id, price, author_id, publisher_id, category_id, discount, stock_quantity, description, photo) VALUES (19, 'H436H7', 'Английский язык в спорте: Учебное пособие', 1, 1999.00, 17, 9, 4, 2.00, 0, 'Учебное пособие подготовлено для слушателей, изу чающих английский язык как язык специальности', '19.jpg');


--
-- TOC entry 5054 (class 0 OID 17707)
-- Dependencies: 234
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.publishers (id, name) VALUES (1, 'Яуза');
INSERT INTO public.publishers (id, name) VALUES (2, 'Т8 Издательские технологии');
INSERT INTO public.publishers (id, name) VALUES (3, 'Прогресс книга');
INSERT INTO public.publishers (id, name) VALUES (4, 'Время');
INSERT INTO public.publishers (id, name) VALUES (5, 'Лениздат');
INSERT INTO public.publishers (id, name) VALUES (6, 'Неолит');
INSERT INTO public.publishers (id, name) VALUES (7, 'Амрита-Русь');
INSERT INTO public.publishers (id, name) VALUES (8, 'Златоуст');
INSERT INTO public.publishers (id, name) VALUES (9, 'Аспект Пресс');
INSERT INTO public.publishers (id, name) VALUES (10, 'ВКН');


--
-- TOC entry 5040 (class 0 OID 17612)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles (id, name) VALUES (1, 'Администратор');
INSERT INTO public.roles (id, name) VALUES (2, 'Менеджер');
INSERT INTO public.roles (id, name) VALUES (3, 'Авторизированный клиент');


--
-- TOC entry 5046 (class 0 OID 17653)
-- Dependencies: 226
-- Data for Name: streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.streets (id, name) VALUES (1, 'ул. Вишневая');
INSERT INTO public.streets (id, name) VALUES (2, 'ул. Подгорная');
INSERT INTO public.streets (id, name) VALUES (3, 'ул. Шоссейная');
INSERT INTO public.streets (id, name) VALUES (4, 'ул. Зеленая');
INSERT INTO public.streets (id, name) VALUES (5, 'ул. Маяковского');
INSERT INTO public.streets (id, name) VALUES (6, 'ул. Светлая');
INSERT INTO public.streets (id, name) VALUES (7, 'ул. Цветочная');
INSERT INTO public.streets (id, name) VALUES (8, 'ул. Коммунистическая');
INSERT INTO public.streets (id, name) VALUES (9, 'ул. Спортивная');
INSERT INTO public.streets (id, name) VALUES (10, 'ул. Гоголя');
INSERT INTO public.streets (id, name) VALUES (11, 'ул. Северная');
INSERT INTO public.streets (id, name) VALUES (12, 'ул. Молодежная');
INSERT INTO public.streets (id, name) VALUES (13, 'ул. Новая');
INSERT INTO public.streets (id, name) VALUES (14, 'ул. Октябрьская');
INSERT INTO public.streets (id, name) VALUES (15, 'ул. Садовая');
INSERT INTO public.streets (id, name) VALUES (16, 'ул. Фрунзе');
INSERT INTO public.streets (id, name) VALUES (17, 'ул. Школьная');
INSERT INTO public.streets (id, name) VALUES (19, 'ул. 8 Марта');
INSERT INTO public.streets (id, name) VALUES (20, 'ул. Комсомольская');
INSERT INTO public.streets (id, name) VALUES (21, 'ул. Чехова');
INSERT INTO public.streets (id, name) VALUES (22, 'ул. Дзержинского');
INSERT INTO public.streets (id, name) VALUES (23, 'ул. Набережная');
INSERT INTO public.streets (id, name) VALUES (25, 'ул. Степная');
INSERT INTO public.streets (id, name) VALUES (27, 'ул. Солнечная');
INSERT INTO public.streets (id, name) VALUES (29, 'ул. Партизанская');
INSERT INTO public.streets (id, name) VALUES (30, 'ул. Победы');
INSERT INTO public.streets (id, name) VALUES (31, 'ул. Полевая');
INSERT INTO public.streets (id, name) VALUES (33, 'ул. Клубная');
INSERT INTO public.streets (id, name) VALUES (34, 'ул. Некрасова');
INSERT INTO public.streets (id, name) VALUES (36, 'ул. Мичурина');


--
-- TOC entry 5050 (class 0 OID 17685)
-- Dependencies: 230
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.units (id, name) VALUES (1, 'шт.');


--
-- TOC entry 5042 (class 0 OID 17623)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (1, 'Никифорова Анна Семеновна', '94d5ous@gmail.com', 'uzWC67', 1);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (2, 'Стелина Евгения Петровна', 'uth4iz@mail.com', '2L6KZG', 1);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (3, 'Михайлюк Анна Вячеславовна', '5d4zbu@tutanota.com', 'rwVDh9', 1);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (4, 'Ситдикова Елена Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos', 2);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (5, 'Ворсин Петр Евгеньевич', '1qz4kw@mail.com', 'gynQMT', 2);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (6, 'Старикова Елена Павловна', '4np6se@mail.com', 'AtnDjr', 2);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (7, 'Никифорова Весения Николаевна', 'yzls62@outlook.com', 'JlFRCZ', 3);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (8, 'Сазонов Руслан Германович', '1diph5e@tutanota.com', '8ntwUp', 3);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (9, 'Одинцов Серафим Артёмович', 'tjde7c@yahoo.com', 'YOyhfR', 3);
INSERT INTO public.users (id, full_name, login, password, role_id) VALUES (10, 'Степанов Михаил Артёмович', 'wpmrc3do@tutanota.com', 'RSbvHv', 3);


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 231
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 18, true);


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 235
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 4, true);


--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 223
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 1, true);


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 243
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 21, true);


--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 239
-- Name: order_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_statuses_id_seq', 2, true);


--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 241
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 11, true);


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 227
-- Name: pickup_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickup_points_id_seq', 36, true);


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 237
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 21, true);


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 233
-- Name: publishers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publishers_id_seq', 10, true);


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 225
-- Name: streets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.streets_id_seq', 36, true);


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 229
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.units_id_seq', 1, true);


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- TOC entry 4857 (class 2606 OID 17705)
-- Name: authors authors_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_name_key UNIQUE (name);


--
-- TOC entry 4859 (class 2606 OID 17703)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- TOC entry 4865 (class 2606 OID 17727)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4867 (class 2606 OID 17725)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4843 (class 2606 OID 17651)
-- Name: cities cities_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_key UNIQUE (name);


--
-- TOC entry 4845 (class 2606 OID 17649)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 4879 (class 2606 OID 17825)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4873 (class 2606 OID 17784)
-- Name: order_statuses order_statuses_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_name_key UNIQUE (name);


--
-- TOC entry 4875 (class 2606 OID 17782)
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY (id);


--
-- TOC entry 4877 (class 2606 OID 17798)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4851 (class 2606 OID 17673)
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- TOC entry 4869 (class 2606 OID 17753)
-- Name: products products_article_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_article_key UNIQUE (article);


--
-- TOC entry 4871 (class 2606 OID 17751)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 17716)
-- Name: publishers publishers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_name_key UNIQUE (name);


--
-- TOC entry 4863 (class 2606 OID 17714)
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 17621)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4837 (class 2606 OID 17619)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4847 (class 2606 OID 17662)
-- Name: streets streets_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_name_key UNIQUE (name);


--
-- TOC entry 4849 (class 2606 OID 17660)
-- Name: streets streets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (id);


--
-- TOC entry 4853 (class 2606 OID 17694)
-- Name: units units_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_name_key UNIQUE (name);


--
-- TOC entry 4855 (class 2606 OID 17692)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- TOC entry 4839 (class 2606 OID 17635)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 4841 (class 2606 OID 17633)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 17826)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4891 (class 2606 OID 17831)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4887 (class 2606 OID 17799)
-- Name: orders orders_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4888 (class 2606 OID 17804)
-- Name: orders orders_pickup_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_id_fkey FOREIGN KEY (pickup_point_id) REFERENCES public.pickup_points(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4889 (class 2606 OID 17809)
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_statuses(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4881 (class 2606 OID 17674)
-- Name: pickup_points pickup_points_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4882 (class 2606 OID 17679)
-- Name: pickup_points pickup_points_street_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4883 (class 2606 OID 17759)
-- Name: products products_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4884 (class 2606 OID 17769)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4885 (class 2606 OID 17764)
-- Name: products products_publisher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_publisher_id_fkey FOREIGN KEY (publisher_id) REFERENCES public.publishers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4886 (class 2606 OID 17754)
-- Name: products products_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4880 (class 2606 OID 17636)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-11-11 18:13:27

--
-- PostgreSQL database dump complete
--

\unrestrict R7yQ7TkHob8NHix4Xm1tCYoZJgeeUR6ae8o0P73PxX6mTh1ER9igbDOzZg7k7uB

