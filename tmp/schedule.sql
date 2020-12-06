DROP TABLE IF EXISTS `Schedule`;
CREATE TABLE `Schedule` (
  `time` int(11)     NOT NULL,
  `#t`   int(11)     NOT NULL,
  `op`   char(1)     NOT NULL,
  `attr` varchar(10) NOT NULL,
  PRIMARY KEY (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Schedule` (`time`, `#t`, `op`, `attr`) VALUES
(10,	1,	'R',	'X'),
(20,	2,	'W',	'X'),
(30,	2,	'W',	'Y'),
(40,	3,	'R',	'Y'),
(50,	1,	'W',	'Y'),
(1,	1,	'R',	'X'),
(2,	2,	'W',	'X'),
(3,	1,	'W',	'X'),
(4,	2,	'C',	''),
(5,	1,	'C',	'');