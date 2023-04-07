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
    cnpj_cpf VARCHAR(20) NOT NULL UNIQUE,
    data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
    ultima_atualizacao TIMESTAMP,
    contato VARCHAR(100)
);
```

2. Execute o seguinte comando SQL para criar a tabela "boletos":
```
CREATE TABLE boletos (
id SERIAL PRIMARY KEY,
numero_boleto VARCHAR(20) NOT NULL,
valor DECIMAL(10, 2) NOT NULL,
data_vencimento DATE NOT NULL,
codigo_barras VARCHAR(100) NOT NULL,
qr_code VARCHAR(500) NOT NULL,
id_associado INTEGER NOT NULL REFERENCES associados(id) ON DELETE CASCADE
);
```
3. Execute o comando SQL para criar a tabela "pagamentos":
```
CREATE TABLE pagamentos (
id SERIAL PRIMARY KEY,
data_pagamento DATE NOT NULL,
valor DECIMAL(10, 2) NOT NULL,
forma_pagamento VARCHAR(20) NOT NULL,
status_pagamento VARCHAR(20) NOT NULL,
numero_documento VARCHAR(20) NOT NULL,
id_associado INTEGER NOT NULL REFERENCES associados(id) ON DELETE CASCADE,
id_boleto INTEGER REFERENCES boletos(id)
);
```
## Inserindo dados.

1. Execute o seguinte comando SQL para inserir dados de teste na tabela "associados":
 ```  
INSERT INTO associados (nome, endereco, telefone, email, tipo, cnpj_cpf, contato)
VALUES ('Empresa LTDA', 'Avenida logo ali, 999', '(11) 8888-8888', 'contato@empresa.xyz', 'PJ', '12.345.678/0001-90', 'Genrente um');

INSERT INTO associados (nome, endereco, telefone, email, tipo, cnpj_cpf, contato)
VALUES ('Alberto A', 'Rua A, 456', '(71) 9999-9999', 'alberto@email.com', 'PF', '987.654.321-00', '');

INSERT INTO associados (nome, endereco, telefone, email, tipo, cnpj_cpf, contato)
VALUES ('Empresa S/A', 'Rua logo depois, 9998', '(88) 9999-6666', 'contato@empresa.com', 'PJ', '98.765.432/0001-21', 'Contador dois');
```

2. Execute o comando SQL para inserir dados de teste na tabela "pagamentos":

```
INSERT INTO pagamentos (data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-03-15', 350.00, 'Cartão de Crédito', 'Pago', '123457', 1, null);

INSERT INTO pagamentos (data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-03-30', 250.00, 'Dinheiro', 'Pago', '', 2, null);

INSERT INTO pagamentos (data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-02-05', 700.00, 'Boleto/PIX', 'Pendente', '324235', 1, null);

INSERT INTO pagamentos (data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-04-01', 1000.00, 'Boleto', 'Pago', '54353', 3, null);

INSERT INTO pagamentos (data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-04-20', 1200.00, 'Boleto', 'Pendente', '635463', 3, null);
```

3. Execute o comando SQL para inserir dados de teste na tabela "boletos":

```
INSERT INTO boletos (numero_boleto, valor, data_vencimento, codigo_barras, qr_code, id_associado)
VALUES ('34252524', 700.00, '2023-02-05', '12.345.678/0001-90', 'data:image/png;base64,iVBORw0Kzmksmmv', 1);

INSERT INTO boletos (numero_boleto, valor, data_vencimento, codigo_barras, qr_code, id_associado)
VALUES ('00004202', 1000.00, '2023-04-01', '98.765.432/0001-21', 'data:image/png;base64,iVBORw0Kzmksmmv', 3);

INSERT INTO boletos (numero_boleto, valor, data_vencimento, codigo_barras, qr_code, id_associado)
VALUES ('000524003', 1200.00, '2023-04-20', '98.765.432/0001-21', 'data:image/png;base64,iVBORw0Kzmksmmv', 3);
```
4. Execute o comando SQL para atualizar o relacionamento entre o pagamento e o boleto gerado:
```
UPDATE pagamentos SET id_boleto = 1 WHERE id = 3;
UPDATE pagamentos SET id_boleto = 2 WHERE id = 4;
UPDATE pagamentos SET id_boleto = 3 WHERE id = 5;
```

## Testando relacionamentos.

 1. Execute-o o comando SQL para verificar o relacionamento entre as tabelas "associados" e "pagamentos"
```
SELECT * FROM associados INNER JOIN pagamentos ON associados.id = pagamentos.id_associado;
```
 2. Execute-o o comando SQL para verificar o relacionamento entre as tabelas "associados", "pagamentos" e "boletos";
```
SELECT * FROM associados 
INNER JOIN pagamentos ON associados.id = pagamentos.id_associado
LEFT JOIN boletos ON boletos.id = pagamentos.id_boleto
```
3. Execute-o o comando SQL para verificar quais os pagamentos foram pagos utilizando a função Boleto com PIX;
```
SELECT * FROM associados 
INNER JOIN pagamentos ON associados.id = pagamentos.id_associado
LEFT JOIN boletos ON boletos.id = pagamentos.id_boleto
WHERE pagamentos.forma_pagamento = 'Boleto/PIX'
```
4. Execute-o o comando SQL para verificar quais os pagamentos festão pendentes;
```
SELECT * FROM associados 
INNER JOIN pagamentos ON associados.id = pagamentos.id_associado
LEFT JOIN boletos ON boletos.id = pagamentos.id_boleto
WHERE pagamentos.status_pagamento = 'Pendente'
```