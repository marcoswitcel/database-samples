select * from cobranca INNER JOIN ordem_de_servico on ordem_de_servico.id = cobranca.id;

-- Calcula o valor total a ser cobrado para os serviços prestados à uma dada ordem de serviço
SELECT COUNT(*) AS numero_de_servicos, SUM(valor) AS valor_total
    FROM `ordem_de_servico_relacao_servico`
    WHERE ordem_de_servico_id = 1
        AND status = 'realizado';

-- Calcula o valor total das peças a serem cobradas para uma dada ordem de serviço
SELECT COUNT(*) AS numero_de_servicos, SUM(quantidade) AS quantidade_de_pecas, SUM(valor) AS valor_total
    FROM `ordem_de_servico_relacao_pecas_material`
    WHERE ordem_de_servico_id = 1;
