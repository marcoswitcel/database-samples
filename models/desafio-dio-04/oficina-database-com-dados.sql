-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Tempo de geração: 24/09/2022 às 00:58
-- Versão do servidor: 8.0.30
-- Versão do PHP: 8.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `mydb`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `tipo` enum('cpf','cnpj') NOT NULL,
  `identificacao` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id`, `nome`, `tipo`, `identificacao`) VALUES
(1, 'João Testador', 'cpf', 'abcdabcdabc');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cobranca`
--

CREATE TABLE `cobranca` (
  `id` int NOT NULL,
  `valor` float NOT NULL,
  `data_limite_pagamento` date NOT NULL,
  `data_pagamento_realizado` date DEFAULT NULL,
  `ordem_de_servico_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `cobranca`
--

INSERT INTO `cobranca` (`id`, `valor`, `data_limite_pagamento`, `data_pagamento_realizado`, `ordem_de_servico_id`) VALUES
(1, 100, '2022-09-03', '2022-09-22', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `deixado_para_analise`
--

CREATE TABLE `deixado_para_analise` (
  `id` int NOT NULL,
  `status` enum('pendente','os-aberta','sem-os') NOT NULL,
  `equipe_id` int NOT NULL,
  `veiculo_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `deixado_para_analise`
--

INSERT INTO `deixado_para_analise` (`id`, `status`, `equipe_id`, `veiculo_id`) VALUES
(1, 'pendente', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `deixado_para_analise_tem_tipo_do_servico_requisitado`
--

CREATE TABLE `deixado_para_analise_tem_tipo_do_servico_requisitado` (
  `deixado_para_analise_id` int NOT NULL,
  `tipo_do_servico_requisitado_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `deixado_para_analise_tem_tipo_do_servico_requisitado`
--

INSERT INTO `deixado_para_analise_tem_tipo_do_servico_requisitado` (`deixado_para_analise_id`, `tipo_do_servico_requisitado_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `equipe`
--

CREATE TABLE `equipe` (
  `id` int NOT NULL,
  `identificacao` varchar(125) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `equipe`
--

INSERT INTO `equipe` (`id`, `identificacao`) VALUES
(1, 'Melhor equipe');

-- --------------------------------------------------------

--
-- Estrutura para tabela `mecanico`
--

CREATE TABLE `mecanico` (
  `id` int NOT NULL,
  `nome` varchar(125) NOT NULL,
  `endereco` varchar(150) NOT NULL,
  `especialidade` varchar(75) NOT NULL,
  `equipe_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `mecanico`
--

INSERT INTO `mecanico` (`id`, `nome`, `endereco`, `especialidade`, `equipe_id`) VALUES
(1, 'Marcos', 'casa', 'carros', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordem_de_servico`
--

CREATE TABLE `ordem_de_servico` (
  `id` int NOT NULL,
  `deixado_para_analise_id` int NOT NULL,
  `status` enum('pendente-aprovacao','aprovado','realizado','cancelado') NOT NULL,
  `numero_os` varchar(30) NOT NULL,
  `data_emissao` date NOT NULL,
  `data_de_entrega` date NOT NULL,
  `valor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `ordem_de_servico`
--

INSERT INTO `ordem_de_servico` (`id`, `deixado_para_analise_id`, `status`, `numero_os`, `data_emissao`, `data_de_entrega`, `valor`) VALUES
(1, 1, 'realizado', 'os-abcd', '2022-09-01', '2022-09-01', 100);

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordem_de_servico_relacao_pecas_material`
--

CREATE TABLE `ordem_de_servico_relacao_pecas_material` (
  `ordem_de_servico_id` int NOT NULL,
  `pecas_material_id` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordem_de_servico_relacao_servico`
--

CREATE TABLE `ordem_de_servico_relacao_servico` (
  `ordem_de_servico_id` int NOT NULL,
  `servico_id` int NOT NULL,
  `status` enum('realizado','pendente') NOT NULL,
  `valor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `ordem_de_servico_relacao_servico`
--

INSERT INTO `ordem_de_servico_relacao_servico` (`ordem_de_servico_id`, `servico_id`, `status`, `valor`) VALUES
(1, 1, 'realizado', 100);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pecas_material`
--

CREATE TABLE `pecas_material` (
  `id` int NOT NULL,
  `nome` varchar(125) NOT NULL,
  `descricao` varchar(250) NOT NULL,
  `valor` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `servico`
--

CREATE TABLE `servico` (
  `id` int NOT NULL,
  `nome` varchar(125) NOT NULL,
  `descricao` varchar(250) NOT NULL,
  `valor` float NOT NULL,
  `tipo_do_servico_requisitado_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `servico`
--

INSERT INTO `servico` (`id`, `nome`, `descricao`, `valor`, `tipo_do_servico_requisitado_id`) VALUES
(1, 'Revisão de rotina', 'Revisão de rotina', 100, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_do_servico_requisitado`
--

CREATE TABLE `tipo_do_servico_requisitado` (
  `id` int NOT NULL,
  `nome` varchar(125) NOT NULL,
  `descricao` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `tipo_do_servico_requisitado`
--

INSERT INTO `tipo_do_servico_requisitado` (`id`, `nome`, `descricao`) VALUES
(1, 'Revisão', 'Revisão');

-- --------------------------------------------------------

--
-- Estrutura para tabela `veiculo`
--

CREATE TABLE `veiculo` (
  `id` int NOT NULL,
  `placa` varchar(45) NOT NULL,
  `cliente_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Despejando dados para a tabela `veiculo`
--

INSERT INTO `veiculo` (`id`, `placa`, `cliente_id`) VALUES
(1, 'placa-abcd', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identificacao_UNIQUE` (`identificacao`);

--
-- Índices de tabela `cobranca`
--
ALTER TABLE `cobranca`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ordem_de_servico_id_UNIQUE` (`ordem_de_servico_id`),
  ADD KEY `fk_cobranca_ordem_de_servico1_idx` (`ordem_de_servico_id`);

--
-- Índices de tabela `deixado_para_analise`
--
ALTER TABLE `deixado_para_analise`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_deixado_para_analise_equipe1_idx` (`equipe_id`),
  ADD KEY `fk_deixado_para_analise_veiculo1_idx` (`veiculo_id`);

--
-- Índices de tabela `deixado_para_analise_tem_tipo_do_servico_requisitado`
--
ALTER TABLE `deixado_para_analise_tem_tipo_do_servico_requisitado`
  ADD PRIMARY KEY (`deixado_para_analise_id`,`tipo_do_servico_requisitado_id`),
  ADD KEY `fk_deixado_para_analise_has_tipo_do_servico_requisitado_tip_idx` (`tipo_do_servico_requisitado_id`),
  ADD KEY `fk_deixado_para_analise_has_tipo_do_servico_requisitado_dei_idx` (`deixado_para_analise_id`);

--
-- Índices de tabela `equipe`
--
ALTER TABLE `equipe`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `mecanico`
--
ALTER TABLE `mecanico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mecanico_equipe1_idx` (`equipe_id`);

--
-- Índices de tabela `ordem_de_servico`
--
ALTER TABLE `ordem_de_servico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ordem_de_servico_deixado_para_analise1_idx` (`deixado_para_analise_id`);

--
-- Índices de tabela `ordem_de_servico_relacao_pecas_material`
--
ALTER TABLE `ordem_de_servico_relacao_pecas_material`
  ADD PRIMARY KEY (`ordem_de_servico_id`,`pecas_material_id`),
  ADD KEY `fk_ordem_de_servico_has_pecas_material_pecas_material1_idx` (`pecas_material_id`),
  ADD KEY `fk_ordem_de_servico_has_pecas_material_ordem_de_servico1_idx` (`ordem_de_servico_id`);

--
-- Índices de tabela `ordem_de_servico_relacao_servico`
--
ALTER TABLE `ordem_de_servico_relacao_servico`
  ADD PRIMARY KEY (`ordem_de_servico_id`,`servico_id`),
  ADD KEY `fk_ordem_de_servico_has_servico_servico1_idx` (`servico_id`),
  ADD KEY `fk_ordem_de_servico_has_servico_ordem_de_servico1_idx` (`ordem_de_servico_id`);

--
-- Índices de tabela `pecas_material`
--
ALTER TABLE `pecas_material`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `servico`
--
ALTER TABLE `servico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_servico_tipo_do_servico_requisitado1_idx` (`tipo_do_servico_requisitado_id`);

--
-- Índices de tabela `tipo_do_servico_requisitado`
--
ALTER TABLE `tipo_do_servico_requisitado`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `veiculo`
--
ALTER TABLE `veiculo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_veiculo_cliente_idx` (`cliente_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `cobranca`
--
ALTER TABLE `cobranca`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `deixado_para_analise`
--
ALTER TABLE `deixado_para_analise`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `equipe`
--
ALTER TABLE `equipe`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `mecanico`
--
ALTER TABLE `mecanico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `ordem_de_servico`
--
ALTER TABLE `ordem_de_servico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pecas_material`
--
ALTER TABLE `pecas_material`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `servico`
--
ALTER TABLE `servico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tipo_do_servico_requisitado`
--
ALTER TABLE `tipo_do_servico_requisitado`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `veiculo`
--
ALTER TABLE `veiculo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `cobranca`
--
ALTER TABLE `cobranca`
  ADD CONSTRAINT `fk_cobranca_ordem_de_servico1` FOREIGN KEY (`ordem_de_servico_id`) REFERENCES `ordem_de_servico` (`id`);

--
-- Restrições para tabelas `deixado_para_analise`
--
ALTER TABLE `deixado_para_analise`
  ADD CONSTRAINT `fk_deixado_para_analise_equipe1` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`id`),
  ADD CONSTRAINT `fk_deixado_para_analise_veiculo1` FOREIGN KEY (`veiculo_id`) REFERENCES `veiculo` (`id`);

--
-- Restrições para tabelas `deixado_para_analise_tem_tipo_do_servico_requisitado`
--
ALTER TABLE `deixado_para_analise_tem_tipo_do_servico_requisitado`
  ADD CONSTRAINT `fk_deixado_para_analise_has_tipo_do_servico_requisitado_deixa1` FOREIGN KEY (`deixado_para_analise_id`) REFERENCES `deixado_para_analise` (`id`),
  ADD CONSTRAINT `fk_deixado_para_analise_has_tipo_do_servico_requisitado_tipo_1` FOREIGN KEY (`tipo_do_servico_requisitado_id`) REFERENCES `tipo_do_servico_requisitado` (`id`);

--
-- Restrições para tabelas `mecanico`
--
ALTER TABLE `mecanico`
  ADD CONSTRAINT `fk_mecanico_equipe1` FOREIGN KEY (`equipe_id`) REFERENCES `equipe` (`id`);

--
-- Restrições para tabelas `ordem_de_servico`
--
ALTER TABLE `ordem_de_servico`
  ADD CONSTRAINT `fk_ordem_de_servico_deixado_para_analise1` FOREIGN KEY (`deixado_para_analise_id`) REFERENCES `deixado_para_analise` (`id`);

--
-- Restrições para tabelas `ordem_de_servico_relacao_pecas_material`
--
ALTER TABLE `ordem_de_servico_relacao_pecas_material`
  ADD CONSTRAINT `fk_ordem_de_servico_has_pecas_material_ordem_de_servico1` FOREIGN KEY (`ordem_de_servico_id`) REFERENCES `ordem_de_servico` (`id`),
  ADD CONSTRAINT `fk_ordem_de_servico_has_pecas_material_pecas_material1` FOREIGN KEY (`pecas_material_id`) REFERENCES `pecas_material` (`id`);

--
-- Restrições para tabelas `ordem_de_servico_relacao_servico`
--
ALTER TABLE `ordem_de_servico_relacao_servico`
  ADD CONSTRAINT `fk_ordem_de_servico_has_servico_ordem_de_servico1` FOREIGN KEY (`ordem_de_servico_id`) REFERENCES `ordem_de_servico` (`id`),
  ADD CONSTRAINT `fk_ordem_de_servico_has_servico_servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`);

--
-- Restrições para tabelas `servico`
--
ALTER TABLE `servico`
  ADD CONSTRAINT `fk_servico_tipo_do_servico_requisitado1` FOREIGN KEY (`tipo_do_servico_requisitado_id`) REFERENCES `tipo_do_servico_requisitado` (`id`);

--
-- Restrições para tabelas `veiculo`
--
ALTER TABLE `veiculo`
  ADD CONSTRAINT `fk_veiculo_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
