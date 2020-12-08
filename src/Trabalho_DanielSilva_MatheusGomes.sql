-- Trabalho de Banco de Dados
-- Daniel Fernandes da Silva
-- Matheus Gomes Arante de Souza 

-- Estratégia considerada para inserção de arestas:
-- Uma aresta T_i → T_j (i ≠ j) é inserida no grafo de precedência para qualquer 
-- combinação de operações conflitantes em relação a um dado item, sendo que a 
-- operação de T_j acontece depois da de T_i na linha do tempo

-- Estratégia considerada para detecção de ciclo:
-- Um ciclo é identificado somente quando suas arestas envolvem o mesmo item de dados

DELIMITER ;;

DROP PROCEDURE IF EXISTS `testeSerializabilidadePorConflito`;;
CREATE PROCEDURE `testeSerializabilidadePorConflito`(OUT `resp` int)
BEGIN
    -- Geração da tabela de arestas

    DROP TABLE IF EXISTS arestas;
	CREATE TABLE IF NOT EXISTS arestas
		SELECT DISTINCT
            Ti.`#t` as `s`,
            Tj.`#t` as `t`,
            Ti.`attr` as `attr`
        FROM 
            `Schedule` Ti
            JOIN `Schedule` Tj
            ON Ti.`attr` = Tj.`attr`             -- Gera as combinações de comandos que envolvam o mesmo atributo
        WHERE
            (Ti.`#t`  != Tj.`#t`)            AND -- Ignora linhas que envolvam a mesma transacao (não existe aresta para si mesmo)
            (Ti.`time` < Tj.`time`)          AND -- Apenas linhas onde T_j acontece depois de T_i
            (Ti.`op` = 'W' OR Tj.`op` = 'W') AND -- Apenas linhas que envolvam operações de Write de algum lado
            (Ti.`op` != 'C' AND Tj.`op` != 'C'); -- Ignora linhas que envolvam commits

    -- Verificando se existe ciclo

    -- Essa tabela retornaria as linhas que formam ciclos de tamanho 2, logo, se ela não tiver linhas,
    -- não existe ciclos de tamanho 2 (e consequentemente nenhum outro ciclo) e as transações são serializáveis por conflito
    SELECT COUNT(*) = 0 
    INTO `resp`
    FROM
        arestas P JOIN arestas Q
        ON P.s = Q.t AND P.t = Q.s AND P.attr = Q.attr; -- Identifica ciclos de tamanho 2 que envolvam o mesmo atributo
    
    DROP TABLE IF EXISTS arestas;
END;;

DELIMITER ;

-- ---------------------------------------------------------------------------------
-- Exemplo de chamada do procedure (Considerando que a tabela `Schedule` já existe)
-- SET @resp = 1; 
-- CALL `testeSerializabilidadePorConflito`(@resp);
-- SELECT @resp;

-- -------------------------------- Exemplos ---------------------------------------

-- ---------------------------------------------------------------------------------
-- Não é serializável por conflito (resp = 0) - Tempos 1, 2 e 4
DROP TABLE IF EXISTS `Schedule`;
CREATE TABLE `Schedule` (
  `time` int(11) NOT NULL,
  `#t`   int(11) NOT NULL,
  `op`   char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1, 'R', 'A'),
(2,	2, 'W', 'A'),
(3,	3, 'R', 'A'),
(4,	1, 'W', 'A'),
(5,	1, 'C',  ''),
(7,	1, 'C',  '');
-- ---------------------------------------------------------------------------------
-- Serializável por conflito (resp = 1)
-- DROP TABLE IF EXISTS `Schedule`;
-- CREATE TABLE `Schedule` (
--   `time` int(11) NOT NULL,
--   `#t`   int(11) NOT NULL,
--   `op`   char(1) NOT NULL,
--   `attr` char(1) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
-- (1,  1,	'R', 'A'),
-- (2,  2,	'W', 'A'),
-- (3,  2,	'R', 'B'),
-- (4,  1,	'W', 'B'),
-- (5,  1,	'C',  ''),
-- (6,	 2,	'C',  '');
-- ---------------------------------------------------------------------------------
-- Não é serializável por conflito (resp = 0) - Tempos 2, 3 e 5
-- DROP TABLE IF EXISTS Schedule;
-- CREATE TABLE Schedule (
--   `time` int(11) NOT NULL,
--   `#t`   int(11) NOT NULL,
--   `op`   char(1) NOT NULL,
--   `attr` char(1) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- INSERT INTO Schedule (`time`, `#t`, `op`, `attr`) VALUES
-- (0, 2, 'R', 'Z'),
-- (1, 2, 'R', 'X'),
-- (2, 2, 'W', 'Z'),
-- (3, 1, 'W', 'Z'),
-- (4, 2, 'W', 'Y'),
-- (5, 2, 'R', 'Z'),
-- (6, 1, 'W', 'Z'),
-- (7, 1, 'C', ''),
-- (8, 2, 'C', ''),
-- (9, 3, 'C', '');
-- ---------------------------------------------------------------------------------
-- Não é serializável por conflito (resp = 0) - Tempos 1, 2 e 3
-- DROP TABLE IF EXISTS `Schedule`;
-- CREATE TABLE `Schedule` (
--   `time` int(11) NOT NULL,
--   `#t`   int(11) NOT NULL,
--   `op`   char(1) NOT NULL,
--   `attr` char(1) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
-- (0, 2, 'R', 'X'),
-- (1, 2, 'W', 'Y'),
-- (2, 1, 'R', 'Y'),
-- (3, 2, 'W', 'Y'),
-- (4, 2, 'R', 'X'),
-- (5, 1, 'C', ''),
-- (6, 2, 'C', '');
-- ---------------------------------------------------------------------------------
-- Não é serializável por conflito (resp = 0) - Tempos 1, 7, 8
-- DROP TABLE IF EXISTS `Schedule`;
-- CREATE TABLE `Schedule` (
--   `time` int(11) NOT NULL,
--   `#t`   int(11) NOT NULL,
--   `op`   char(1) NOT NULL,
--   `attr` char(1) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
-- (0, 1, 'W', 'Y'),
-- (1, 4, 'W', 'X'),
-- (2, 2, 'W', 'Y'),
-- (3, 2, 'R', 'X'),
-- (4, 2, 'R', 'X'),
-- (5, 4, 'W', 'Z'),
-- (6, 3, 'R', 'X'),
-- (7, 1, 'W', 'X'),
-- (8, 4, 'R', 'X'),
-- (9, 4, 'W', 'Z'),
-- (10, 1, 'C', ''),
-- (11, 2, 'C', ''),
-- (12, 3, 'C', ''),
-- (13, 4, 'C', '');
-- ---------------------------------------------------------------------------------
-- Serializável por conflito (resp = 1)
-- DROP TABLE IF EXISTS `Schedule`;
-- CREATE TABLE `Schedule` (
--   `time` int(11) NOT NULL,
--   `#t`   int(11) NOT NULL,
--   `op`   char(1) NOT NULL,
--   `attr` char(1) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
-- (0, 2, 'R', 'X'),
-- (1, 1, 'R', 'Y'),
-- (2, 2, 'R', 'Y'),
-- (3, 1, 'W', 'Y'),
-- (4, 1, 'C', ''),
-- (5, 2, 'C', '');
-- ---------------------------------------------------------------------------------
-- Não é serializável por conflito (resp = 0) - Tempos (1, 2, 3) e (4, 5, 6)
-- DROP TABLE IF EXISTS `Schedule`;
-- CREATE TABLE `Schedule` (
--   `time` int(11) NOT NULL,
--   `#t`   int(11) NOT NULL,
--   `op`   char(1) NOT NULL,
--   `attr` char(1) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
-- (1,	1, 'R', 'A'),
-- (2,	2, 'W', 'A'),
-- (3,	1, 'R', 'A'),
-- (4,	3, 'R', 'B'),
-- (5,	4, 'W', 'B'),
-- (6,	3, 'R', 'B'),
-- (7,	1, 'C',  ''),
-- (8,	1, 'C',  '');
-- ---------------------------------------------------------------------------------