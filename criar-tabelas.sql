DROP TABLE IF EXISTS public.pagamentos; 
DROP TABLE IF EXISTS public.boletos;
DROP TABLE IF EXISTS public.bancos;
DROP TABLE IF EXISTS public.associados;

CREATE TABLE associados (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    tipo VARCHAR(2) NOT NULL,
    cnpj_cpf VARCHAR(20) NOT NULL UNIQUE,
    data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
    ultima_atualizacao TIMESTAMP,
    contato VARCHAR(100)
);

CREATE TABLE bancos (
    id SERIAL PRIMARY KEY,
    codigo_banco VARCHAR(3),
    nome_banco VARCHAR(50),
    carteira VARCHAR(10),
    agencia VARCHAR(10),
    conta VARCHAR(20),
    digito_verificador VARCHAR(5)
);

CREATE TABLE boletos (
id SERIAL PRIMARY KEY,
valor DECIMAL(10, 2) NOT NULL,
data_vencimento DATE NOT NULL,
codigo_barras VARCHAR(100) NOT NULL,
qr_code VARCHAR(500) NOT NULL,
id_associado INTEGER NOT NULL REFERENCES associados(id) ON DELETE CASCADE,
id_banco INTEGER NOT NULL REFERENCES bancos(id) ON DELETE CASCADE
);
 
CREATE TABLE pagamentos (
id SERIAL PRIMARY KEY,
data_documento DATE NOT NULL,
data_pagamento DATE NOT NULL,
valor DECIMAL(10, 2) NOT NULL,
forma_pagamento VARCHAR(20) NOT NULL,
status_pagamento VARCHAR(20) NOT NULL,
numero_documento VARCHAR(20) NOT NULL,
id_associado INTEGER NOT NULL REFERENCES associados(id) ON DELETE CASCADE,
id_boleto INTEGER REFERENCES boletos(id)
);
 