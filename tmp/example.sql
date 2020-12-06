-- Adminer 4.7.7 MySQL dump

-- Para executar o código (após carregar o arquivo example.sql):
-- SET @resp = 1; 
-- CALL `testeSerializabilidadePorConflito`(@resp);
-- SELECT @resp;
-- SELECT * FROM vertices;

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DELIMITER ;;

DROP PROCEDURE IF EXISTS `testeSerializabilidadePorConflito`;;
CREATE PROCEDURE `testeSerializabilidadePorConflito`(OUT `resp` tinyint)
BEGIN

	# Refs:
	# 	https://www.mysqltutorial.org/mysql-cursor/
	# 	https://stackoverflow.com/questions/1745165/looping-over-result-sets-in-mysql
 	#  	https://stackoverflow.com/questions/1361340/how-to-insert-if-not-exists-in-mysql

	DECLARE finished INT DEFAULT 0;
	DECLARE curr_t INT;

	-- declare cursor to iterate over transitions
	DECLARE curs CURSOR FOR SELECT `#t` FROM Schedule;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	-- create temporary table to store vertices
	DROP TEMPORARY TABLE IF EXISTS vertices;
	CREATE TEMPORARY TABLE IF NOT EXISTS vertices  (
		id INT PRIMARY KEY
	);

	OPEN curs;

	-- build vertices' list
	processSchedule: LOOP

		-- set variable curr_t
		FETCH curs INTO curr_t;

		-- loop break condition
		IF finished = 1 THEN 
			LEAVE processSchedule;
		END IF;

		-- insert into vertices' table, if not already there
		INSERT INTO vertices (id) VALUES (curr_t) ON DUPLICATE KEY UPDATE id=id;

	END LOOP processSchedule;

	CLOSE curs;

	-- TODO
	SET resp = 0;

	-- clean up
	-- DROP TEMPORARY TABLE IF EXISTS vertices;

END;;

DELIMITER ;

DROP TABLE IF EXISTS `Schedule`;
CREATE TABLE `Schedule` (
  `time` int(11)     NOT NULL,
  `#t`   int(11)     NOT NULL,
  `op`   char(1)     NOT NULL,
  `attr` varchar(10) NOT NULL,
  PRIMARY KEY (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'R',	'X'),
(3,	2,	'W',	'X'),
(4,	1,	'W',	'X'),
(5,	2,	'C',	'-'),
(6,	1,	'C',	'-');

-- 2020-12-01 12:38:46

-- INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
(7,	3,	'R',	'X'),
(8,	3,	'R',	'Y'),
(9,	4,	'R',	'X'),
(10, 3,	'W',	'Y'),
(11, 4,	'C',	'-'),
(12, 3,	'C',	'-');

SELECT COUNT(*)
FROM
    (SELECT DISTINCT
        -- s1.`time` as `time1`, 
        -- s2.`time` as `time2`,
        s1.`#t` as `s`, -- `#t1`,
        s2.`#t` as `t` -- `#t2`
        -- s1.`op` as `op1`,
        -- s2.`op` as `op2`,
        -- s1.`attr` as `attr1`,
        -- s2.`attr` as `attr2`
    FROM 
        `Schedule` s1
        JOIN `Schedule` s2
        ON s1.`attr` = s2.`attr`
    WHERE
        (s1.`time` < s2.`time`) AND
        (s1.`op` != 'C' AND s2.`op` != 'C') AND -- Remove linhas com commits
        (s1.`#t` != s2.`#t`) AND -- Remove linhas referentes a mesma transacao
        (
        (s1.`op` = 'R' AND s2.`op` = 'W') OR
        (s1.`op` = 'W' AND s2.`op` = 'R') OR
        (s1.`op` = 'W' AND s2.`op` = 'W')
        ) -- Mantém linhas com operações conflitantes
    ) P
    JOIN
    (SELECT DISTINCT
        -- s1.`time` as `time1`, 
        -- s2.`time` as `time2`,
        s1.`#t` as `s`, -- `#t1`,
        s2.`#t` as `t` -- `#t2`
        -- s1.`op` as `op1`,
        -- s2.`op` as `op2`,
        -- s1.`attr` as `attr1`,
        -- s2.`attr` as `attr2`
    FROM 
        `Schedule` s1
        JOIN `Schedule` s2
        ON s1.`attr` = s2.`attr`
    WHERE
        (s1.`time` < s2.`time`) AND
        (s1.`op` != 'C' AND s2.`op` != 'C') AND -- Remove linhas com commits
        (s1.`#t` != s2.`#t`) AND -- Remove linhas referentes a mesma transacao
        (
        (s1.`op` = 'R' AND s2.`op` = 'W') OR
        (s1.`op` = 'W' AND s2.`op` = 'R') OR
        (s1.`op` = 'W' AND s2.`op` = 'W')
        ) -- Mantém linhas com operações conflitantes
    ) Q
    ON P.s = Q.t AND P.t = Q.s
;