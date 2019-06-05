CREATE TABLE "estados" (
	"id_estados" smallint NOT NULL,
	"nome" char(20) NOT NULL,
	"uf" char(2) NOT NULL,
	PRIMARY KEY ( "id_estados" )
) IN "db_cadas";
COMMENT ON TABLE  "estados" IS 'Registros de Estados';
COMMENT ON COLUMN "estados"."id_estados" IS 'C�digo do Estado';
COMMENT ON COLUMN "estados"."nome" IS 'Nome';
COMMENT ON COLUMN "estados"."uf" IS 'unidade federativa';

CREATE TABLE "cidades" ( 
	"id_cidades" integer NOT NULL, 
	"id_estados" smallint NULL, 
	"nome" char(50) NOT NULL,
	"cod_siafi" integer NULL,
	PRIMARY KEY ( "id_cidades" )
);
COMMENT ON TABLE  "cidades" IS 'Registros de Cidades';
COMMENT ON COLUMN "cidades"."id_cidades" IS 'C�digo da Cidade'; 
COMMENT ON COLUMN "cidades"."id_estados" IS 'Sigla do Estado'; 
COMMENT ON COLUMN "cidades"."nome" IS 'Descri��o'; 
COMMENT ON COLUMN "cidades"."cod_siafi" IS 'C�digo no SIAFI'; 
ALTER TABLE "cidades" ADD FOREIGN KEY "fk_bairros_reference_cidades" ( "id_estados" )  REFERENCES "estados"  ( "id_estados" ); 

CREATE TABLE "bairros"(
	"id_bairros" integer NOT NULL, 
   "id_cidades" integer NOT NULL, 
	"nome" char(50)      NOT NULL,
	PRIMARY KEY ( "id_bairros" )
) IN "db_cadas";
COMMENT ON TABLE  "bairros" IS 'Registros de Bairros';
COMMENT ON COLUMN "bairros"."id_bairros" IS 'C�digo do Bairro';
COMMENT ON COLUMN "bairros"."nome" IS 'Descri��o';
COMMENT ON COLUMN "bairros"."id_cidades" IS 'C�digo da Cidade';
ALTER TABLE "bairros" ADD FOREIGN KEY "fk_bairros_reference_cidades" ( "id_cidades" )  REFERENCES "cidades"  ( "id_cidades" ); 

CREATE TABLE "ruas" (
	"id_ruas" integer    NOT NULL,
	"id_cidades" integer NOT NULL,
	"nome" char(50)      NOT NULL,
	"cep" char(8)        NULL,
	PRIMARY KEY ( "id_ruas" ) 
);
COMMENT ON TABLE  "ruas" IS 'Registros de Ruas';
COMMENT ON COLUMN "ruas"."id_ruas" IS 'C�digo da Rua';
COMMENT ON COLUMN "ruas"."id_cidades" IS 'C�digo da Cidade';
COMMENT ON COLUMN "ruas"."nome" IS 'Nome';
COMMENT ON COLUMN "ruas"."cep" IS 'CEP';
ALTER TABLE "ruas" ADD FOREIGN KEY "fk_ruas_reference_cidades" ( "id_cidades" )  REFERENCES "cidades"  ( "id_cidades" ); 

CREATE TABLE pessoas(
	"id_pessoas"     integer NOT NULL,
	"nome"           char(60) NOT NULL,
   "Documento"      char(11) NULL,
	"ddd"            char(2)  NULL,
	"telefone"       char(9)  NULL,
	"ddd_cel"        char(2)  NULL,
	"celular"        char(9)  NULL,
	"email"          char(60) NULL,
	PRIMARY KEY ( "id_pessoas" )
);

COMMENT ON TABLE pessoas IS 'Registros de Pessoas';
COMMENT ON COLUMN pessoas.id_pessoas IS 'C�digo da Pessoa';
COMMENT ON COLUMN pessoas.nome IS 'Nome';
COMMENT ON COLUMN pessoas.Documento  IS 'Documento';
COMMENT ON COLUMN pessoas.ddd IS 'DDD';
COMMENT ON COLUMN pessoas.telefone IS 'Telefone';
COMMENT ON COLUMN pessoas.ddd_cel IS 'DDD do celular';
COMMENT ON COLUMN pessoas.celular IS 'Celular';
COMMENT ON COLUMN pessoas.email IS 'Email';

CREATE TABLE "pessoas_enderecos"(
	"id_pessoas"     integer  NOT NULL,
	"tipo_endereco"  char(1)  NOT NULL,
	"id_ruas"        integer  NULL,
	"id_bairros"     integer  NULL,
	"complemento"    char(50) NULL,
	"numero"         char(8)  NULL,
	PRIMARY KEY ( "id_pessoas", "tipo_endereco" )
);
COMMENT ON TABLE  "pessoas_enderecos" IS 'Registros de Endere�os das Pessoas';
COMMENT ON COLUMN "pessoas_enderecos"."id_pessoas" IS 'C�digo da Pessoa';
COMMENT ON COLUMN "pessoas_enderecos"."tipo_endereco" IS 'Tipo do endere�o (P-Pessoal, C-Correspond�ncia, S-Servi�o)';
COMMENT ON COLUMN "pessoas_enderecos"."id_ruas" IS 'C�digo da Rua'; 
COMMENT ON COLUMN "pessoas_enderecos"."id_bairros" IS 'C�digo do Bairro';
COMMENT ON COLUMN "pessoas_enderecos"."complemento" IS 'Complemento';
COMMENT ON COLUMN "pessoas_enderecos"."numero" IS 'N�mero';

ALTER TABLE "pessoas_enderecos" ADD FOREIGN KEY "fk_pessoas_enderecos_reference_ruas"    ( "id_ruas" )    REFERENCES "ruas"    ( "id_ruas" ); 
ALTER TABLE "pessoas_enderecos" ADD FOREIGN KEY "fk_pessoas_enderecos_reference_bairros" ( "id_bairros" ) REFERENCES "bairros" ( "id_bairros" );
ALTER TABLE "pessoas_enderecos" ADD FOREIGN KEY "fk_pessoas_enderecos_reference_pessoas" ( "id_pessoas" ) REFERENCES "pessoas" ( "id_pessoas" );
ALTER TABLE "pessoas_enderecos" ALTER "tipo_endereco" ADD CONSTRAINT "ASA9206" check(tipo_endereco in( 'P','C','S') and(ascii(tipo_endereco) < 97));


CREATE TABLE "pontos_acessos"(
	"id_ponto"     integer      NOT NULL,
   "Nome"         char(50)     NOT NULL,
	"Descricao"    varchar(254) NULL,
	"numero"       Smallint     NULL,
	PRIMARY KEY ( "id_ponto")
);
COMMENT ON TABLE  "pontos_acessos" IS 'Registros dos pontos de acessos da entidade';
COMMENT ON COLUMN "pontos_acessos"."id_ponto"  IS 'C�digo do Ponto';
COMMENT ON COLUMN "pontos_acessos"."Nome"      IS 'Nome do Ponto de acesso';
COMMENT ON COLUMN "pontos_acessos"."Descricao" IS 'Descri��o para detalhamento do Ponto de acesso';
COMMENT ON COLUMN "pontos_acessos"."numero"    IS 'N�mero';

CREATE TABLE "permicoes_acessos"(
	"id_permiss�o"  integer   NOT NULL,
   "id_ponto"      integer   NOT NULL,
   "id_pessoas"    integer   NOT NULL,
   "inicio_acesso" timestamp NOT NULL,
   "fim_acesso"    timestamp NULL, 
	PRIMARY KEY ( "id_permiss�o")
);
COMMENT ON TABLE  "permicoes_acessos" IS 'Registros de permiss�es de acessos da entidade';
COMMENT ON COLUMN "permicoes_acessos"."id_permiss�o"  IS 'C�digo da Permiss�o';
COMMENT ON COLUMN "permicoes_acessos"."id_pessoas"    IS 'C�digo da Pessoa';
COMMENT ON COLUMN "permicoes_acessos"."id_ponto"      IS 'C�digo do Ponto';
COMMENT ON COLUMN "permicoes_acessos"."inicio_acesso" IS 'Inicio do Acesso';
COMMENT ON COLUMN "permicoes_acessos"."fim_acesso"    IS 'Final do Acesso';

ALTER TABLE "permicoes_acessos" ADD FOREIGN KEY "fk_permicoes_acessos_reference_pontos_acessos" ("id_ponto")   REFERENCES "pontos_acessos"  ( "id_ponto" ); 
ALTER TABLE "permicoes_acessos" ADD FOREIGN KEY "fk_permicoes_acessos_reference_pessoas"        ("id_pessoas") REFERENCES "pessoas" ( "id_pessoas" );

CREATE TABLE "acessos"(
   "id_acesso"  integer   NOT NULL,
   "id_ponto"   integer   NOT NULL,
   "id_pessoas" integer   NOT NULL,
   "marcacao"   timestamp NOT NULL,
	PRIMARY KEY ("id_ponto")
);
COMMENT ON TABLE  "acessos" IS 'Registros de marca��es de acessos a entidade';
COMMENT ON COLUMN "acessos"."id_acesso"     IS 'C�digo do Acesso';
COMMENT ON COLUMN "acessos"."id_pessoas"    IS 'C�digo da Pessoa';
COMMENT ON COLUMN "acessos"."id_ponto"      IS 'C�digo do Ponto';
COMMENT ON COLUMN "acessos"."marcacao"      IS 'Marca��o de acesso';

ALTER TABLE "acessos" ADD FOREIGN KEY "fk_acessos_reference_pontos_acessos" ( "id_ponto" )   REFERENCES "pontos_acessos"  ( "id_ponto" ); 
ALTER TABLE "acessos" ADD FOREIGN KEY "fk_acessos_reference_pessoas"        ( "id_pessoas" ) REFERENCES "pessoas" ( "id_pessoas" );