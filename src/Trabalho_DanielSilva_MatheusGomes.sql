-- Trabalho de Banco de Dados
-- Daniel Fernandes da Silva
-- Matheus Gomes Arante de Souza 

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DELIMITER ;;

DROP PROCEDURE IF EXISTS `testeSerializabilidadePorConflito`;;
CREATE PROCEDURE `testeSerializabilidadePorConflito`(OUT `resp` int)
BEGIN
    -- Estratégia considerada para inserção de arestas:
    -- Uma aresta Ti → Tj (i ≠ j) é inserida no grafo de precedência para qualquer 
    -- combinação de operações conflitantes em relação a um dado item, sendo que a 
    -- operação de Tj acontece depois da de Ti na linha do tempo

    DROP TABLE IF EXISTS arestas;
	CREATE TABLE IF NOT EXISTS arestas
		SELECT DISTINCT
            s1.`#t` as `s`,
            s2.`#t` as `t`,
            s1.`attr` as `attr`
        FROM 
            `Schedule` s1
            JOIN `Schedule` s2
            ON s1.`attr` = s2.`attr`
        WHERE
            (s1.`#t` != s2.`#t`)             AND -- Ignora linhas que envolvem a mesma transacao
            (s1.`time` < s2.`time`)          AND -- Apenas linhas onde s1 acontece antes (se usasse `!=` apareceriam linhas duplicadas)
            (s1.`op` = 'W' OR s2.`op` = 'W') AND -- Apenas linhas que envolvam operações de Write de algum lado
            (s1.`op` != 'C' AND s2.`op` != 'C'); -- Ignora linhas que envolvam commits


    -- Estratégia considerada para detecção de ciclo:
    -- Um ciclo é identificado somente quando suas arestas envolvem o mesmo item de dados
    
    -- Essa tabela retorna as linhas que formam ciclo, logo, se ela não tiver linhas,
    -- não existe ciclo e as transações são serializáveis por conflito
    SELECT COUNT(*) = 0 
    INTO `resp`
    FROM
        arestas P JOIN arestas Q
        ON P.s = Q.t AND P.t = Q.s AND P.attr = Q.attr; -- Encontra ciclos de tamanho 2 que envolvam o mesmo atributo
END;;
