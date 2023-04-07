SELECT 
ban.nome_banco AS nome_do_banco,
LPAD(ban.codigo_banco::text, 3, '0'),
bol.codigo_barras AS linha_digitavel,
CONCAT(
	ass.nome, 
	', ', 
		CASE ass.tipo
        WHEN 'PF' THEN 'CPF '
        ELSE 'CNPJ '
    END,
	ass.cnpj_cpf,
	' ', 
	ass.endereco

) AS cedente,

bol.valor,
pag.data_documento,
bol.data_vencimento,
pag.numero_documento,
CONCAT(
	ass.nome, 
	', ', 
	ass.endereco

) AS sacado,
CONCAT(
		CASE ass.tipo
        WHEN 'PF' THEN 'CPF '
        ELSE 'CNPJ '
    END,
	ass.cnpj_cpf
) AS cnpj_cpf,
bol.qr_code
FROM boletos bol
INNER JOIN bancos ban ON ban.id = bol.id_banco
INNER JOIN associados ass ON ass.id = bol.id_associado
INNER JOIN pagamentos pag ON pag.id_boleto = bol.id;