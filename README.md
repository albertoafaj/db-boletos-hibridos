# Estrutura de DB para gerenciamento de boletos híbridos.

Este repositório tem como objetivo criar uma estrutura de banco de dados com três tabelas relacionadas para gerenciamento de informações de associados, pagamentos e boletos híbridos.Este DB poderá ser usado para armazenar, gerenciar e consultar informações de associados e pagamentos, bem como para gerar boletos híbridos com códigos de barras e QR Codes.

## Instalação do PostgreSQL:

1. Faça o download do PostgreSQL em https://www.postgresql.org/download/

2. Siga as instruções de instalação padrão para o seu sistema operacional e defina uma senha para o usuário "postgres".

## Instalação do pgAdmin:

1. Faça o download do pgAdmin na versão mais recente para o seu sistema operacional em https://www.pgadmin.org/download/

```
O pgAdmin é o aplicativo cliente com  interface gráfica para gerenciamento de bancos de dados PostgreSQL. Atravé dele será possível executar consultas SQL, criar e editar tabelas, e gerenciar backups e restaurações de bancos de dados.
```
## Criação do banco de dados:

1. Abra o pgAdmin e faça login com o usuário "postgres" e a senha definida durante a instalação.
2. Clique com o "Object" e selecione "Create" > "Server Group..." e dê um nome ao grupo de servidor. "app-financeiro".
3. Clique novamente em "Object" e selecione "Register" > "Server...". Na aba "General" dê um nome ao servidor ("boletos_hibridos") e selecione o Server group ("app-financeiro").
4. Na aba "Connection", insira o nome do host (localhost), o número da porta (5432), o nome do banco de dados ("postgres") e senha do usuário posgres definida na instalação. Clique em "Save".
5. Clique com o botão direito do mouse em "Databases" e selecione "Create" > "Database...". Dê um nome ao banco de dados ("base_prod") e selecione o servidor que acabou de criar. Clique em "Save". 
   
## Criação das tabelas e relacionamentos:

1. Na janela queryTool do pgAdmin, "Tools" > "Query tool" >  execute o comando SQL para criar a tabela "associados":
```
CREATE TABLE associados (
id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
endereco VARCHAR(200) NOT NULL,
telefone VARCHAR(20),
email VARCHAR(100),
tipo VARCHAR(2) NOT NULL,
cnpj_cpf VARCHAR(20) NOT NULL,
data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
ultima_atualizacao TIMESTAMP,
contato VARCHAR(100)
);
```

2. Adicione uma restrição de unicidade para o campo cnpj_cpf para garantir que não haja mais de um associado com o mesmo CNPJ/CPF:
```
ALTER TABLE associados ADD CONSTRAINT uk_cnpj_cpf UNIQUE (cnpj_cpf);
```

3. Execute o comando SQL para criar a tabela "pagamentos":

CREATE TABLE pagamentos (
id SERIAL PRIMARY KEY,
data_pagamento DATE NOT NULL,
valor DECIMAL(10, 2) NOT NULL,
forma_pagamento VARCHAR(20) NOT NULL,
status_pagamento VARCHAR(20) NOT NULL,
numero_documento VARCHAR(20) NOT NULL,
id_associado INTEGER NOT NULL REFERENCES associados(id) ON DELETE CASCADE
);

4. Execute o seguinte comando SQL para criar a tabela "boletos":

CREATE TABLE boletos (
id SERIAL PRIMARY KEY,
numero_boleto VARCHAR(20) NOT NULL,
valor DECIMAL(10, 2) NOT NULL,
data_vencimento DATE NOT NULL,
codigo_barras VARCHAR(100) NOT NULL,
url_qr_code VARCHAR(500) NOT NULL,
id_associado INTEGER NOT NULL REFERENCES associados(id) ON DELETE CASCADE
);