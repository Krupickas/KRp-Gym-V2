CREATE TABLE IF NOT EXISTS `player_skills` (
  `identifier` varchar(46) NOT NULL,
  `strength` int(11) DEFAULT 0,
  `stamina` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
