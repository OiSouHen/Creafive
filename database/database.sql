--
-- Banco de dados: `creative`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_accounts`
--

DROP TABLE IF EXISTS `summerz_accounts`;
CREATE TABLE IF NOT EXISTS `summerz_accounts` (
  `whitelist` tinyint(1) NOT NULL DEFAULT '0',
  `chars` int(10) NOT NULL DEFAULT '1',
  `gems` int(20) NOT NULL DEFAULT '0',
  `premium` int(20) NOT NULL DEFAULT '0',
  `priority` int(3) NOT NULL DEFAULT '0',
  `discord` varchar(50) NOT NULL DEFAULT '0',
  `steam` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`steam`) USING BTREE,
  KEY `steam` (`steam`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_bank`
--

DROP TABLE IF EXISTS `summerz_bank`;
CREATE TABLE IF NOT EXISTS `summerz_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL DEFAULT '0',
  `value` int(20) NOT NULL DEFAULT '0',
  `mode` varchar(50) DEFAULT 'Private',
  `owner` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_banneds`
--

DROP TABLE IF EXISTS `summerz_banneds`;
CREATE TABLE IF NOT EXISTS `summerz_banneds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) NOT NULL,
  `time` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_characters`
--

DROP TABLE IF EXISTS `summerz_characters`;
CREATE TABLE IF NOT EXISTS `summerz_characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(50) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `serial` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `blood` int(1) NOT NULL DEFAULT '1',
  `fines` int(20) NOT NULL DEFAULT '0',
  `garage` int(3) NOT NULL DEFAULT '3',
  `prison` int(11) NOT NULL DEFAULT '0',
  `port` int(1) NOT NULL DEFAULT '0',
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_chests`
--

DROP TABLE IF EXISTS `summerz_chests`;
CREATE TABLE IF NOT EXISTS `summerz_chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT '0',
  `perm` varchar(50) NOT NULL,
  `logs` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `summerz_chests`
--

INSERT INTO `summerz_chests` (`id`, `name`, `weight`, `perm`, `logs`) VALUES
(1, 'State', 500, 'State', 1),
(2, 'Corrections', 500, 'Corrections', 1),
(3, 'Ranger', 500, 'Ranger', 1),
(4, 'Lspd', 500, 'Lspd', 1),
(5, 'Sheriff', 500, 'Sheriff', 1),
(6, 'Paramedic', 250, 'Paramedic', 1),
(7, 'Aztecas', 250, 'Aztecas', 0),
(8, 'Bloods', 250, 'Bloods', 0),
(9, 'Ballas', 250, 'Ballas', 0),
(10, 'Vagos', 250, 'Vagos', 0),
(11, 'Families', 250, 'Families', 0),
(12, 'TheLost', 250, 'TheLost', 0),
(13, 'Mechanic', 250, 'Mechanic', 0),
(14, 'MotoClub', 250, 'MotoClub', 0),
(15, 'Vanilla', 250, 'Vanilla', 0),
(16, 'Triads', 250, 'Triads', 0),
(17, 'Arcade', 250, 'Arcade', 0),
(18, 'Desserts', 250, 'Desserts', 0),
(19, 'Vinhedo', 250, 'Vinhedo', 0),
(20, 'Playboy', 250, 'Playboy', 0),
(21, 'EastSide', 250, 'EastSide', 0),
(22, 'Salieris', 250, 'Salieris', 0),
(23, 'trayShot', 10, 'trayShot', 0),
(24, 'trayDesserts', 10, 'trayDesserts', 0),
(25, 'trayPops', 10, 'trayPops', 0),
(26, 'trayPizza', 10, 'trayPizza', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_entitydata`
--

DROP TABLE IF EXISTS `summerz_entitydata`;
CREATE TABLE IF NOT EXISTS `summerz_entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`dkey`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_fidentity`
--

DROP TABLE IF EXISTS `summerz_fidentity`;
CREATE TABLE IF NOT EXISTS `summerz_fidentity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `name2` varchar(50) NOT NULL DEFAULT '',
  `locate` varchar(10) NOT NULL DEFAULT 'Sul',
  `port` int(1) NOT NULL DEFAULT '1',
  `blood` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_playerdata`
--

DROP TABLE IF EXISTS `summerz_playerdata`;
CREATE TABLE IF NOT EXISTS `summerz_playerdata` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `user_id` (`user_id`),
  KEY `dkey` (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_prison`
--

DROP TABLE IF EXISTS `summerz_prison`;
CREATE TABLE IF NOT EXISTS `summerz_prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT '0',
  `services` int(11) NOT NULL DEFAULT '0',
  `fines` int(20) NOT NULL DEFAULT '0',
  `text` longtext,
  `date` text,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_propertys`
--

DROP TABLE IF EXISTS `summerz_propertys`;
CREATE TABLE IF NOT EXISTS `summerz_propertys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT 'Homes0001',
  `interior` varchar(50) NOT NULL DEFAULT 'Middle',
  `tax` int(20) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `price` int(20) NOT NULL DEFAULT '0',
  `residents` int(1) NOT NULL DEFAULT '1',
  `vault` int(10) NOT NULL DEFAULT '1',
  `fridge` int(10) NOT NULL DEFAULT '1',
  `owner` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_races`
--

DROP TABLE IF EXISTS `summerz_races`;
CREATE TABLE IF NOT EXISTS `summerz_races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raceid` int(3) NOT NULL DEFAULT '0',
  `user_id` int(5) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT 'Individuo Indigente',
  `vehicle` varchar(50) NOT NULL DEFAULT 'Sultan RS',
  `points` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_vehicles`
--

DROP TABLE IF EXISTS `summerz_vehicles`;
CREATE TABLE IF NOT EXISTS `summerz_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `tax` int(20) NOT NULL DEFAULT '0',
  `plate` varchar(20) DEFAULT NULL,
  `rental` int(20) NOT NULL DEFAULT '0',
  `rendays` int(11) NOT NULL DEFAULT '0',
  `arrest` int(20) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT '1000',
  `body` int(4) NOT NULL DEFAULT '1000',
  `fuel` int(3) NOT NULL DEFAULT '100',
  `nitro` int(3) NOT NULL DEFAULT '0',
  `work` varchar(5) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  PRIMARY KEY (`user_id`,`vehicle`),
  KEY `user_id` (`user_id`),
  KEY `vehicle` (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
COMMIT;