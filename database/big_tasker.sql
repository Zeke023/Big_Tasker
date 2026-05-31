--
-- PostgreSQL database dump
--

\restrict I43dVoZ6atbWVNe56UsjxnNyIMeHRCboRUFVZXiWyPtDlxODNhWCYV4brhrWdYl

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: administradores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administradores (
    id integer NOT NULL,
    nome character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    senha character varying(255) NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.administradores OWNER TO postgres;

--
-- Name: administradores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administradores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administradores_id_seq OWNER TO postgres;

--
-- Name: administradores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administradores_id_seq OWNED BY public.administradores.id;


--
-- Name: alerta_anti_fraudes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alerta_anti_fraudes (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    adm_responsavel integer,
    quantia_tarefas_suspeitas integer DEFAULT 0,
    intervalo_total interval,
    status character varying(50),
    data_alerta timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.alerta_anti_fraudes OWNER TO postgres;

--
-- Name: alerta_anti_fraudes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alerta_anti_fraudes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alerta_anti_fraudes_id_seq OWNER TO postgres;

--
-- Name: alerta_anti_fraudes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alerta_anti_fraudes_id_seq OWNED BY public.alerta_anti_fraudes.id;


--
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    icone text,
    descricao text,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_id_seq OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- Name: competicoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competicoes (
    id integer NOT NULL,
    nome character varying(150) NOT NULL,
    inicio timestamp without time zone,
    fim timestamp without time zone,
    status character varying(50),
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.competicoes OWNER TO postgres;

--
-- Name: competicoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.competicoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.competicoes_id_seq OWNER TO postgres;

--
-- Name: competicoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.competicoes_id_seq OWNED BY public.competicoes.id;


--
-- Name: conquistas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conquistas (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo character varying(100),
    nome character varying(150) NOT NULL,
    descricao_objetivo text,
    valor_necessario integer,
    xp_de_resgate integer,
    arte text,
    ativa boolean DEFAULT true
);


ALTER TABLE public.conquistas OWNER TO postgres;

--
-- Name: conquistas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conquistas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conquistas_id_seq OWNER TO postgres;

--
-- Name: conquistas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conquistas_id_seq OWNED BY public.conquistas.id;


--
-- Name: niveis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveis (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    xp_minimo integer NOT NULL,
    xp_maximo integer NOT NULL,
    arte text
);


ALTER TABLE public.niveis OWNER TO postgres;

--
-- Name: niveis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.niveis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.niveis_id_seq OWNER TO postgres;

--
-- Name: niveis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.niveis_id_seq OWNED BY public.niveis.id;


--
-- Name: notificacoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notificacoes (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo character varying(100),
    titulo character varying(200),
    mensagem text,
    tipo_relacao character varying(100),
    id_relacao integer,
    data_notificacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notificacoes OWNER TO postgres;

--
-- Name: notificacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notificacoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificacoes_id_seq OWNER TO postgres;

--
-- Name: notificacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notificacoes_id_seq OWNED BY public.notificacoes.id;


--
-- Name: postagens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postagens (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    id_tarefa integer,
    url_imagem text,
    legenda text,
    status character varying(50),
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.postagens OWNER TO postgres;

--
-- Name: postagens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.postagens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.postagens_id_seq OWNER TO postgres;

--
-- Name: postagens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.postagens_id_seq OWNED BY public.postagens.id;


--
-- Name: ranking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ranking (
    id integer NOT NULL,
    id_competicao integer NOT NULL,
    id_usuario integer NOT NULL,
    tarefas_concluidas integer DEFAULT 0,
    xp_obtido integer DEFAULT 0,
    posicao integer,
    premio_xp integer DEFAULT 0,
    participacao_ativa boolean DEFAULT true
);


ALTER TABLE public.ranking OWNER TO postgres;

--
-- Name: ranking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ranking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ranking_id_seq OWNER TO postgres;

--
-- Name: ranking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ranking_id_seq OWNED BY public.ranking.id;


--
-- Name: reacoes_postagens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reacoes_postagens (
    id integer NOT NULL,
    id_post integer NOT NULL,
    id_usuario integer NOT NULL,
    tipo_reacao character varying(50),
    alteracao_score integer DEFAULT 0,
    data_reacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.reacoes_postagens OWNER TO postgres;

--
-- Name: reacoes_postagens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reacoes_postagens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reacoes_postagens_id_seq OWNER TO postgres;

--
-- Name: reacoes_postagens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reacoes_postagens_id_seq OWNED BY public.reacoes_postagens.id;


--
-- Name: score_reputacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.score_reputacao (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    origem character varying(100),
    id_origem integer,
    alteracao_score integer,
    score_anterior integer,
    novo_score integer,
    data_alteracao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.score_reputacao OWNER TO postgres;

--
-- Name: score_reputacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.score_reputacao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.score_reputacao_id_seq OWNER TO postgres;

--
-- Name: score_reputacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.score_reputacao_id_seq OWNED BY public.score_reputacao.id;


--
-- Name: status_tarefa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_tarefa (
    id integer NOT NULL,
    id_tarefa integer NOT NULL,
    status_anterior character varying(50),
    novo_status character varying(50),
    data_alteracao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.status_tarefa OWNER TO postgres;

--
-- Name: status_tarefa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_tarefa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_tarefa_id_seq OWNER TO postgres;

--
-- Name: status_tarefa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.status_tarefa_id_seq OWNED BY public.status_tarefa.id;


--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarefas (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    id_categoria integer NOT NULL,
    titulo character varying(200) NOT NULL,
    descricao text,
    prazo timestamp without time zone,
    dificuldade character varying(50),
    status character varying(50),
    xp_base integer DEFAULT 0,
    xp_final integer DEFAULT 0,
    esta_atrasada boolean DEFAULT false,
    data_conclusao timestamp without time zone,
    data_atraso timestamp without time zone,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ultima_atualizacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tarefas OWNER TO postgres;

--
-- Name: tarefas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarefas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tarefas_id_seq OWNER TO postgres;

--
-- Name: tarefas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarefas_id_seq OWNED BY public.tarefas.id;


--
-- Name: transacoes_xp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transacoes_xp (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    id_tarefa integer,
    origem character varying(100),
    id_origem integer,
    quantia_xp integer NOT NULL,
    data_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    motivo text,
    data_transacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transacoes_xp OWNER TO postgres;

--
-- Name: transacoes_xp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transacoes_xp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transacoes_xp_id_seq OWNER TO postgres;

--
-- Name: transacoes_xp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transacoes_xp_id_seq OWNED BY public.transacoes_xp.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    id_nivel integer,
    nome character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    senha character varying(255) NOT NULL,
    foto text,
    biografia text,
    score integer DEFAULT 0,
    xp_total integer DEFAULT 0,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    data_ultima_atualizacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: administradores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administradores ALTER COLUMN id SET DEFAULT nextval('public.administradores_id_seq'::regclass);


--
-- Name: alerta_anti_fraudes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerta_anti_fraudes ALTER COLUMN id SET DEFAULT nextval('public.alerta_anti_fraudes_id_seq'::regclass);


--
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- Name: competicoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competicoes ALTER COLUMN id SET DEFAULT nextval('public.competicoes_id_seq'::regclass);


--
-- Name: conquistas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conquistas ALTER COLUMN id SET DEFAULT nextval('public.conquistas_id_seq'::regclass);


--
-- Name: niveis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveis ALTER COLUMN id SET DEFAULT nextval('public.niveis_id_seq'::regclass);


--
-- Name: notificacoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacoes ALTER COLUMN id SET DEFAULT nextval('public.notificacoes_id_seq'::regclass);


--
-- Name: postagens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postagens ALTER COLUMN id SET DEFAULT nextval('public.postagens_id_seq'::regclass);


--
-- Name: ranking id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking ALTER COLUMN id SET DEFAULT nextval('public.ranking_id_seq'::regclass);


--
-- Name: reacoes_postagens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacoes_postagens ALTER COLUMN id SET DEFAULT nextval('public.reacoes_postagens_id_seq'::regclass);


--
-- Name: score_reputacao id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score_reputacao ALTER COLUMN id SET DEFAULT nextval('public.score_reputacao_id_seq'::regclass);


--
-- Name: status_tarefa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_tarefa ALTER COLUMN id SET DEFAULT nextval('public.status_tarefa_id_seq'::regclass);


--
-- Name: tarefas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarefas ALTER COLUMN id SET DEFAULT nextval('public.tarefas_id_seq'::regclass);


--
-- Name: transacoes_xp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacoes_xp ALTER COLUMN id SET DEFAULT nextval('public.transacoes_xp_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Name: administradores administradores_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administradores
    ADD CONSTRAINT administradores_email_key UNIQUE (email);


--
-- Name: administradores administradores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administradores
    ADD CONSTRAINT administradores_pkey PRIMARY KEY (id);


--
-- Name: alerta_anti_fraudes alerta_anti_fraudes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerta_anti_fraudes
    ADD CONSTRAINT alerta_anti_fraudes_pkey PRIMARY KEY (id);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: competicoes competicoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competicoes
    ADD CONSTRAINT competicoes_pkey PRIMARY KEY (id);


--
-- Name: conquistas conquistas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conquistas
    ADD CONSTRAINT conquistas_pkey PRIMARY KEY (id);


--
-- Name: niveis niveis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveis
    ADD CONSTRAINT niveis_pkey PRIMARY KEY (id);


--
-- Name: notificacoes notificacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacoes
    ADD CONSTRAINT notificacoes_pkey PRIMARY KEY (id);


--
-- Name: postagens postagens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postagens
    ADD CONSTRAINT postagens_pkey PRIMARY KEY (id);


--
-- Name: ranking ranking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking
    ADD CONSTRAINT ranking_pkey PRIMARY KEY (id);


--
-- Name: reacoes_postagens reacoes_postagens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacoes_postagens
    ADD CONSTRAINT reacoes_postagens_pkey PRIMARY KEY (id);


--
-- Name: score_reputacao score_reputacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score_reputacao
    ADD CONSTRAINT score_reputacao_pkey PRIMARY KEY (id);


--
-- Name: status_tarefa status_tarefa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_tarefa
    ADD CONSTRAINT status_tarefa_pkey PRIMARY KEY (id);


--
-- Name: tarefas tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: transacoes_xp transacoes_xp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacoes_xp
    ADD CONSTRAINT transacoes_xp_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: idx_notificacoes_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notificacoes_usuario ON public.notificacoes USING btree (id_usuario);


--
-- Name: idx_postagens_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_postagens_usuario ON public.postagens USING btree (id_usuario);


--
-- Name: idx_ranking_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ranking_usuario ON public.ranking USING btree (id_usuario);


--
-- Name: idx_reacoes_post; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reacoes_post ON public.reacoes_postagens USING btree (id_post);


--
-- Name: idx_tarefas_categoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tarefas_categoria ON public.tarefas USING btree (id_categoria);


--
-- Name: idx_tarefas_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tarefas_usuario ON public.tarefas USING btree (id_usuario);


--
-- Name: alerta_anti_fraudes fk_alerta_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerta_anti_fraudes
    ADD CONSTRAINT fk_alerta_admin FOREIGN KEY (adm_responsavel) REFERENCES public.administradores(id);


--
-- Name: alerta_anti_fraudes fk_alerta_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alerta_anti_fraudes
    ADD CONSTRAINT fk_alerta_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: conquistas fk_conquista_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conquistas
    ADD CONSTRAINT fk_conquista_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: notificacoes fk_notificacao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notificacoes
    ADD CONSTRAINT fk_notificacao_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: postagens fk_post_tarefa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postagens
    ADD CONSTRAINT fk_post_tarefa FOREIGN KEY (id_tarefa) REFERENCES public.tarefas(id);


--
-- Name: postagens fk_post_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postagens
    ADD CONSTRAINT fk_post_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: ranking fk_ranking_competicao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking
    ADD CONSTRAINT fk_ranking_competicao FOREIGN KEY (id_competicao) REFERENCES public.competicoes(id);


--
-- Name: ranking fk_ranking_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking
    ADD CONSTRAINT fk_ranking_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: reacoes_postagens fk_reacao_post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacoes_postagens
    ADD CONSTRAINT fk_reacao_post FOREIGN KEY (id_post) REFERENCES public.postagens(id);


--
-- Name: reacoes_postagens fk_reacao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reacoes_postagens
    ADD CONSTRAINT fk_reacao_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: score_reputacao fk_score_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score_reputacao
    ADD CONSTRAINT fk_score_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: status_tarefa fk_status_tarefa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_tarefa
    ADD CONSTRAINT fk_status_tarefa FOREIGN KEY (id_tarefa) REFERENCES public.tarefas(id);


--
-- Name: tarefas fk_tarefa_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_tarefa_categoria FOREIGN KEY (id_categoria) REFERENCES public.categorias(id);


--
-- Name: tarefas fk_tarefa_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_tarefa_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- Name: usuarios fk_usuario_nivel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_nivel FOREIGN KEY (id_nivel) REFERENCES public.niveis(id);


--
-- Name: transacoes_xp fk_xp_tarefa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacoes_xp
    ADD CONSTRAINT fk_xp_tarefa FOREIGN KEY (id_tarefa) REFERENCES public.tarefas(id);


--
-- Name: transacoes_xp fk_xp_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transacoes_xp
    ADD CONSTRAINT fk_xp_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id);


--
-- PostgreSQL database dump complete
--

\unrestrict I43dVoZ6atbWVNe56UsjxnNyIMeHRCboRUFVZXiWyPtDlxODNhWCYV4brhrWdYl

