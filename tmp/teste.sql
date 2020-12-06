DROP TABLE IF EXISTS `st_1`;
CREATE TABLE `st_1` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_1` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'W',	'Y'),
(3,	1,	'W',	'X'),
(4,	2,	'C',	''),
(5,	1,	'C',	'');
-- Sim

DROP TABLE IF EXISTS `st_2`;
CREATE TABLE `st_2` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_2` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'W',	'X'),
(3,	1,	'W',	'X'),
(4,	2,	'C',	''),
(5,	1,	'C',	'');
-- Não

DROP TABLE IF EXISTS `st_3`;
CREATE TABLE `st_3` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_3` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'W',	'X'),
(3,	3,	'R',	'X'),
(4,	4,	'W',	'X'),
(5,	1,	'R',	'X');
-- Não

DROP TABLE IF EXISTS `st_4`;
CREATE TABLE `st_4` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_4` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'W',	'X'),
(3,	3,	'R',	'X'),
(4,	1,	'W',	'X');
-- Não

DROP TABLE IF EXISTS `st_5`;
CREATE TABLE `st_5` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_5` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'W',	'X'),
(3,	2,	'W',	'Y'),
(4,	3,	'R',	'Y'),
(5,	1,	'W',	'Y');
-- Não // Sim no nosso

DROP TABLE IF EXISTS `st_6`;
CREATE TABLE `st_6` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_6` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'R',	'X'),
(3,	3,	'R',	'X'),
(4,	2,	'W',	'X'),
(5,	1,	'W',	'X'),
(6,	2,	'C',	''),
(7,	1,	'C',	'');
-- Não

DROP TABLE IF EXISTS `st_7`;
CREATE TABLE `st_7` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_7` (`time`, `#t`, `op`, `attr`) VALUES
(1,    2,    'R',    'Y'),
(2,    3,    'R',    'Y'),
(4,    3,    'W',    'Y'),
(5,    2,    'C',    ''),
(6,    5,    'R',    'Y'),
(9,    7,    'W',    'Y'),
(12,   7,    'W',    'Y'),
(13,   1,    'C',    ''),
(14,  10,    'W',    'Y'),
(18,   5,    'C',    ''),
(19,   4,    'W',    'Y'),
(20,  13,    'C',    ''),
(21,  11,    'C',    ''),
(22,   7,    'C',    ''),
(23,  12,    'C',    ''),
(25,  19,    'C',    ''),
(26,   9,    'R',    'Y'),
(28,   9,    'C',    ''),
(29,   4,    'C',    ''),
(30,   3,    'C',    ''),
(5,    3,    'R',    'Y'),
(8,    7,    'R',    'Y'),
(15,   3,    'R',    'Y'),
(16,  42,    'R',    'Y'),
(17,  53,    'R',    'Y');
-- Não

DROP TABLE IF EXISTS `st_8`;
CREATE TABLE `st_8` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_8` (`time`, `#t`, `op`, `attr`) VALUES
(1,	1,	'R',	'X'),
(2,	2,	'R',	'X'),
(3,	2,	'W',	'X'),
(4,	3,	'R',	'X'),
(5,	2,	'W',	'X'),
(6,	1,	'W',	'X'),
(7,	2,	'C',	''),
(8,	1,	'C',	'');
-- Não

DROP TABLE IF EXISTS `st_9`;
CREATE TABLE `st_9` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_9` (`time`, `#t`, `op`, `attr`) VALUES
(1,	2,	'R',	'A'),
(2,	2,	'W',	'A'),
(3,	1,	'R',	'A'),
(4,	1,	'W',	'A'),
(5,	1,	'W',	'B'),
(6,	2,	'R',	'B'),
(7,	2,	'W',	'B'),
(8,	1,	'C',	''),
(8,	2,	'C',	'');
-- Não // Sim no nosso

DROP TABLE IF EXISTS `st_10`;
CREATE TABLE `st_10` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_10` (`time`, `#t`, `op`, `attr`) VALUES
(1,  1,	'R',	'A'),
(2,  2,	'R',	'A'),
(3,  3,	'R',	'A'),
(4,  4,	'R',	'A'),
(5,  5,	'R',	'A'),
(6,  6,	'R',	'A'),
(7,  7,	'W',	'A'),
(8,  1,	'C',	 ''),
(9,	 2,	'C',	 ''),
(10, 3,	'C',	 ''),
(11, 4,	'C',	 ''),
(12, 5,	'C',	 ''),
(13, 6,	'C',	 ''),
(14, 7,	'C',	 '');
-- Sim

DROP TABLE IF EXISTS `st_11`;
CREATE TABLE `st_11` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_11` (`time`, `#t`, `op`, `attr`) VALUES
(1,  1,	'R',	'A'),
(2,  2,	'W',	'A'),
(3,  2,	'R',	'B'),
(4,  1,	'W',	'B'),
(5,  1,	'C',	 ''),
(6,	 2,	'C',	 '');
-- Não // Sim no nosso

DROP TABLE IF EXISTS `st_12`;
CREATE TABLE `st_12` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_12` (`time`, `#t`, `op`, `attr`) VALUES
(1,  1,	'R',	'A'),
(2,  2,	'W',	'A'),
(3,  2,	'R',	'B'),
(4,  1,	'W',	'B'),
(5,  1,	'C',	 ''),
(6,	 2,	'C',	 '');
-- Não

DROP TABLE IF EXISTS `st_13`;
CREATE TABLE `st_13` (
  `time` int(11) NOT NULL,
  `#t` int(11) NOT NULL,
  `op` char(1) NOT NULL,
  `attr` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `st_13` (`time`, `#t`, `op`, `attr`) VALUES
(2,  1, 'W', 'A'),
(3,  2, 'W', 'A'),
(4,  2, 'W', 'B'),
(5,  3, 'W', 'B'),
(6,  3, 'W', 'C'),
(7,  4, 'W', 'C'),
(8,  4, 'W', 'D'),
(9,  1, 'W', 'D');
-- Não // Sim no nosso