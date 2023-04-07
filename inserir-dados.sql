
INSERT INTO associados (nome, endereco, telefone, email, tipo, cnpj_cpf, contato)
VALUES ('Empresa LTDA', 'Avenida logo ali, 999', '(11) 8888-8888', 'contato@empresa.xyz', 'PJ', '12.345.678/0001-90', 'Genrente um');

INSERT INTO associados (nome, endereco, telefone, email, tipo, cnpj_cpf, contato)
VALUES ('Alberto A', 'Rua A, 456', '(71) 9999-9999', 'alberto@email.com', 'PF', '987.654.321-00', '');

INSERT INTO associados (nome, endereco, telefone, email, tipo, cnpj_cpf, contato)
VALUES ('Empresa S/A', 'Rua logo depois, 9998', '(88) 9999-6666', 'contato@empresa.com', 'PJ', '98.765.432/0001-21', 'Contador dois');

INSERT INTO pagamentos (data_documento, data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-03-10', '2023-03-15', 350.00, 'Cartão de Crédito', 'Pago', '123457', 1, null);

INSERT INTO pagamentos (data_documento, data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-03-20','2023-03-30', 250.00, 'Dinheiro', 'Pago', '', 2, null);

INSERT INTO pagamentos (data_documento, data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-02-01','2023-02-05', 700.00, 'Boleto/PIX', 'Pendente', '324235', 1, null);

INSERT INTO pagamentos (data_documento, data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-03-15', '2023-04-01', 1000.00, 'Boleto', 'Pago', '54353', 3, null);

INSERT INTO pagamentos (data_documento, data_pagamento, valor, forma_pagamento, status_pagamento, numero_documento, id_associado, id_boleto)
VALUES ('2023-03-15','2023-04-20', 1200.00, 'Boleto', 'Pendente', '635463', 3, null);

INSERT INTO bancos (codigo_banco, nome_banco, carteira, agencia, conta, digito_verificador)
VALUES 
('001', 'BB', '175', '0123', '12345-6', '7');

INSERT INTO boletos (valor, data_vencimento, codigo_barras, qr_code, id_associado, id_banco)
VALUES ( 700.00, '2023-02-05','00190.123 12345.12345 12345.123456 7 1000100070000', 'data:image/png;base64,iVBORw0Kzmksmmv', 1, 1);

INSERT INTO boletos (valor, data_vencimento, codigo_barras, qr_code, id_associado, id_banco)
VALUES (1000.00, '2023-04-01', '00190.123 12345.12345 12345.123456 7 1000100100000', 'data:image/png;base64,iVBORw0Kzmksmmv', 3, 1);

INSERT INTO boletos (valor, data_vencimento, codigo_barras, qr_code, id_associado, id_banco)
VALUES (1200.00, '2023-04-20', '00190.123 12345.12345 12345.123456 7 1000100120000', 'data:image/png;base64,iVBORw0Kzmksmmv', 3, 1);

UPDATE pagamentos SET id_boleto = 1 WHERE id = 3;
UPDATE pagamentos SET id_boleto = 2 WHERE id = 4;
UPDATE pagamentos SET id_boleto = 3 WHERE id = 5;
