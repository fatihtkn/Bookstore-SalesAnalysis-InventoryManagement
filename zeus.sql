-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 29 Ara 2024, 13:29:01
-- Sunucu sürümü: 5.7.31
-- PHP Sürümü: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `zeus`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `InsertBook,Edition, author and genre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertBook,Edition, author and genre` (IN `bookTitle` VARCHAR(255), IN `bookYear` INT, IN `editionNumber` INT, IN `editionDate` DATE, IN `kitapeviid` INT, IN `sayfa` INT, IN `stok` INT, IN `bookAuthorname` VARCHAR(100), IN `bookAuthorsurname` VARCHAR(100), IN `bookGenre` VARCHAR(100))  BEGIN
   
    INSERT INTO kitaplar (kitap_adi, basimevi_id, yili,sayfa_sayisi)
    VALUES (bookTitle, kitapeviid, bookYear,sayfa);

    
    SET @kitap_id = LAST_INSERT_ID();

    
    INSERT INTO baski (baski_no, baski_tarih)
    VALUES (editionNumber, editionDate);

    
    SET @baski_id = LAST_INSERT_ID();

   
    INSERT INTO kitap_baski (kitap_id, baski_id, stok)
    VALUES (@kitap_id, @baski_id, stok);
    
    INSERT INTO yazarlar(adi, soyadi)
    VALUES(bookAuthorname, bookAuthorsurname);
    
    SET @yazar_id = LAST_INSERT_ID();
    
    INSERT INTO kitap_yazar (kitap_id, yazar_id)
    VALUES (@kitap_id, @yazar_id);
    
    INSERT INTO turler (tur_ad)
    VALUES(bookGenre);
    
    SET @tur_id = LAST_INSERT_ID();
    
    INSERT INTO kitap_tur (kitap_id, tur_id)
    VALUES (@kitap_id, @tur_id);
    
 
    
END$$

DROP PROCEDURE IF EXISTS `InsertBookAndEdition`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertBookAndEdition` (IN `bookTitle` VARCHAR(50), IN `bookYear` INT, IN `editionNumber` INT, IN `editionDate` DATE, IN `kitapeviid` INT, IN `stok` INT, IN `sayfa` INT, IN `yazar` INT, IN `tur` INT)  BEGIN
   
    INSERT INTO kitaplar (kitap_adi, basimevi_id, yili,sayfa_sayisi)
    VALUES (bookTitle, kitapeviid, bookYear,sayfa);

    
    SET @kitap_id = LAST_INSERT_ID();

    
    INSERT INTO baski (baski_no, baski_tarih)
    VALUES (editionNumber, editionDate);

    
    SET @baski_id = LAST_INSERT_ID();

   
    INSERT INTO kitap_baski (kitap_id, baski_id, stok)
    VALUES (@kitap_id, @baski_id, stok);   
    
 
    
   
    
    INSERT INTO kitap_yazar (kitap_id, yazar_id)
    VALUES (@kitap_id, yazar);
    
 
    
    INSERT INTO kitap_tur (kitap_id, tur_id)
    VALUES (@kitap_id, tur);
       
END$$

DROP PROCEDURE IF EXISTS `türsüz_kitap_ekleme`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `türsüz_kitap_ekleme` (IN `bookTitle` VARCHAR(100), IN `kitapeviid` INT, IN `bookYear` INT, IN `sayfa` INT, IN `editionNumber` INT, IN `editionDate` DATE, IN `stok` INT, IN `bookAuthorname` VARCHAR(100), IN `bookAuthorsurname` VARCHAR(100), IN `tur` INT)  BEGIN
   
    INSERT INTO kitaplar (kitap_adi, basimevi_id, yili,sayfa_sayisi)
    VALUES (bookTitle, kitapeviid, bookYear,sayfa);

    
    SET @kitap_id = LAST_INSERT_ID();

    
    INSERT INTO baski (baski_no, baski_tarih)
    VALUES (editionNumber, editionDate);

    
    SET @baski_id = LAST_INSERT_ID();

   
    INSERT INTO kitap_baski (kitap_id, baski_id, stok)
    VALUES (@kitap_id, @baski_id, stok);
    
    INSERT INTO yazarlar(adi, soyadi)
    VALUES(bookAuthorname, bookAuthorsurname);
    
    SET @yazar_id = LAST_INSERT_ID();
    
    INSERT INTO kitap_yazar (kitap_id, yazar_id)
    VALUES (@kitap_id, @yazar_id);
    
    
    INSERT INTO kitap_tur (kitap_id, tur_id)
    VALUES (@kitap_id, tur);
    
 
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `basimevi`
--

DROP TABLE IF EXISTS `basimevi`;
CREATE TABLE IF NOT EXISTS `basimevi` (
  `basimevi_id` int(11) NOT NULL,
  `basimevi_adi` varchar(30) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`basimevi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `basimevi`
--

INSERT INTO `basimevi` (`basimevi_id`, `basimevi_adi`) VALUES
(1, 'Zeus Kitabevi-Yayınevi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `baski`
--

DROP TABLE IF EXISTS `baski`;
CREATE TABLE IF NOT EXISTS `baski` (
  `baski_id` int(11) NOT NULL AUTO_INCREMENT,
  `baski_no` int(11) NOT NULL,
  `baski_tarih` date DEFAULT NULL,
  PRIMARY KEY (`baski_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `baski`
--

INSERT INTO `baski` (`baski_id`, `baski_no`, `baski_tarih`) VALUES
(1, 1, '2015-01-01'),
(5, 1, '2013-01-01'),
(6, 1, '2022-01-01'),
(7, 2, '2024-01-01'),
(8, 2, '2024-01-01'),
(9, 1, '2015-01-01'),
(10, 2, '2024-01-01'),
(11, 1, '2010-01-01'),
(12, 2, '2015-03-08'),
(13, 1, '2011-04-02'),
(14, 2, '2016-03-09'),
(15, 1, '2016-08-06'),
(16, 1, '2009-08-23'),
(17, 2, '2012-10-20'),
(18, 1, '2022-03-19'),
(19, 1, '2018-09-01'),
(20, 1, '2014-01-23'),
(21, 2, '2018-08-07'),
(22, 1, '2010-03-02'),
(23, 2, '2024-01-07'),
(24, 3, '2019-02-03'),
(25, 1, '2017-01-01'),
(26, 1, '2019-05-09'),
(27, 2, '2020-08-23'),
(28, 1, '2016-09-29'),
(29, 1, '2018-09-23'),
(30, 1, '2016-03-09'),
(31, 1, '2015-08-17'),
(32, 1, '2017-01-03'),
(33, 1, '2016-06-28'),
(34, 2, '2018-11-09'),
(35, 1, '2017-04-04'),
(36, 2, '2018-09-08'),
(37, 1, '2011-02-14'),
(38, 2, '2013-07-12'),
(39, 1, '2022-03-10'),
(40, 1, '2015-07-15'),
(41, 1, '2016-02-05'),
(42, 1, '2009-09-03'),
(43, 1, '2024-01-01'),
(44, 1, '2015-01-01'),
(45, 1, '2014-01-01'),
(46, 1, '2010-01-01'),
(47, 1, '2016-03-02'),
(48, 1, '2021-01-01'),
(49, 1, '2022-05-09'),
(50, 1, '2020-04-02'),
(51, 1, '2016-01-01'),
(52, 1, '2016-01-01');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kiralik`
--

DROP TABLE IF EXISTS `kiralik`;
CREATE TABLE IF NOT EXISTS `kiralik` (
  `kiralik_id` int(11) NOT NULL AUTO_INCREMENT,
  `kitap_id` int(11) NOT NULL,
  `baski_id` int(11) NOT NULL,
  `musteri_id` int(11) NOT NULL,
  `kiralama_tarihi` date NOT NULL,
  PRIMARY KEY (`kiralik_id`),
  KEY `musteri_id` (`musteri_id`),
  KEY `basim_id` (`baski_id`),
  KEY `kitap_id` (`kitap_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kiralik`
--

INSERT INTO `kiralik` (`kiralik_id`, `kitap_id`, `baski_id`, `musteri_id`, `kiralama_tarihi`) VALUES
(4, 1, 6, 5, '2024-12-25'),
(5, 14, 13, 3, '2024-12-18'),
(6, 17, 16, 9, '2024-12-25'),
(7, 20, 19, 7, '2024-12-12'),
(12, 1, 1, 1, '2024-12-29'),
(13, 1, 1, 1, '2024-12-29'),
(14, 1, 1, 1, '2024-12-29'),
(15, 1, 1, 1, '2024-12-29'),
(16, 1, 1, 1, '2024-12-29');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar`
--

DROP TABLE IF EXISTS `kitaplar`;
CREATE TABLE IF NOT EXISTS `kitaplar` (
  `kitap_id` int(11) NOT NULL AUTO_INCREMENT,
  `kitap_adi` varchar(100) COLLATE utf8_turkish_ci NOT NULL,
  `basimevi_id` int(11) NOT NULL,
  `yili` int(11) DEFAULT NULL,
  `sayfa_sayisi` int(11) DEFAULT NULL,
  PRIMARY KEY (`kitap_id`),
  KEY `basimevi_id` (`basimevi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitaplar`
--

INSERT INTO `kitaplar` (`kitap_id`, `kitap_adi`, `basimevi_id`, `yili`, `sayfa_sayisi`) VALUES
(1, '50 Soruda Milli Mücadele', 1, 2015, 363),
(6, 'A Contrastive Study on Turkish and English', 1, 2013, 605),
(7, 'Acar Baba Ve Leventleri', 1, 2022, 0),
(8, 'Acar Baba Ve Leventleri', 1, 2024, 350),
(9, 'A Contrastive Study on Turkish and English', 1, 2024, 605),
(10, 'Aklın Aptallığı', 1, 2015, 288),
(11, 'Aklın Aptallığı', 1, 2024, 289),
(12, 'Altı Hayat Üstü Sanat', 1, 2010, 278),
(13, 'Altı Hayat Üstü Sanat', 1, 2015, 280),
(14, 'Anılarla Yolculuk', 1, 2011, 303),
(15, 'Anılarla Yolculuk', 1, 2016, 295),
(16, 'Anneannemin Ketesi', 1, 2016, 48),
(17, 'Aşkın Büyüsü', 1, 2009, 200),
(18, 'Aşkın Büyüsü', 1, 2012, 230),
(19, 'Bahar', 1, 2022, 155),
(20, 'Benden Söylemesi', 1, 2018, 312),
(21, 'Berit\'in Gözyaşları', 1, 2014, 336),
(22, 'Berit\'in Gözyaşları', 1, 2018, 340),
(23, 'Bilgisayarlı Muhasebe', 1, 2010, 237),
(24, 'Bilgisayarlı Muhasebe', 1, 2014, 237),
(25, 'Bilgisayarlı Muhasebe', 1, 2019, 237),
(26, 'Bir Çözümleme Bir Sonuç', 1, 2017, 244),
(27, 'Blok', 1, 2019, 176),
(28, 'Blok', 1, 2020, 180),
(29, 'Büyümeyen Bebek', 1, 2016, 136),
(30, 'Camdan Gökyüzü', 1, 2018, 112),
(31, 'Canım Yanıyor', 1, 2016, 130),
(32, 'Demiryolu Palas Oteli`nden Şiirler', 1, 2015, 80),
(33, 'Denizyoluna Turkuaz Gölgeli Dizeler', 1, 2017, 114),
(34, 'Doğmayan Güneş', 1, 2016, 206),
(35, 'Doğmayan Güneş', 1, 2018, 210),
(36, 'Dünyada Türk Olmak Zor', 1, 2017, 584),
(37, 'Dünyada Türk Olmak Zor', 1, 2018, 584),
(38, 'Ekonomiye Giriş', 1, 2011, 250),
(39, 'Ekonomiye Giriş', 1, 2013, 245),
(40, 'Elli\'nin Kiri', 1, 2022, 120),
(41, 'Etik', 1, 2015, 256),
(42, 'Feray\'ın Düşü', 1, 2016, 136),
(43, 'Genel ve Teknik İletişim', 1, 2009, 254),
(44, 'Gökyüzünün Efendileri', 1, 2024, 288),
(45, 'Gurbet Gazileri', 1, 2015, 280),
(46, 'Hiçbiryerde', 1, 2014, 178),
(47, 'İçimdeki Bir Işık', 1, 2003, 271),
(48, 'İnsan Terk Ettiğine Ağlar mı Hiç', 1, 2016, 82),
(49, 'İş Dünyasında Başarı İçin Çalışanların ve Liderlerin Rolü', 1, 2021, 240),
(50, 'İstanbul\'da Bir Amerikan Zırhlısı', 1, 2022, 150),
(51, 'Kardelen ile Turna Kuşu', 1, 2020, 64),
(52, 'Kırık Tebessüm', 1, 2016, 192),
(53, 'Limanı Gören Bir Çatı Katından Şiirler', 1, 2016, 80);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_baski`
--

DROP TABLE IF EXISTS `kitap_baski`;
CREATE TABLE IF NOT EXISTS `kitap_baski` (
  `kitap_id` int(11) NOT NULL,
  `baski_id` int(11) NOT NULL,
  `stok` int(11) DEFAULT NULL,
  PRIMARY KEY (`kitap_id`,`baski_id`),
  KEY `baski_id` (`baski_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_baski`
--

INSERT INTO `kitap_baski` (`kitap_id`, `baski_id`, `stok`) VALUES
(1, 1, 98),
(6, 5, 100),
(7, 6, 100),
(8, 7, 99),
(9, 8, 100),
(10, 9, 94),
(11, 10, 77),
(12, 11, 18),
(13, 12, 72),
(14, 13, 53),
(15, 14, 99),
(16, 15, 70),
(17, 16, 3),
(18, 17, 42),
(19, 18, 79),
(20, 19, 65),
(21, 20, 16),
(22, 21, 56),
(23, 22, 8),
(24, 23, 19),
(25, 24, 65),
(26, 25, 86),
(27, 26, 12),
(28, 27, 35),
(29, 28, 70),
(30, 29, 19),
(31, 30, 31),
(32, 31, 92),
(33, 32, 92),
(34, 33, 12),
(35, 34, 72),
(36, 35, 5),
(37, 36, 8),
(38, 37, 11),
(39, 38, 27),
(40, 39, 35),
(41, 40, 85),
(42, 41, 42),
(43, 42, 24),
(44, 43, 95),
(45, 44, 30),
(46, 45, 11),
(47, 46, 63),
(48, 47, 86),
(49, 48, 87),
(50, 49, 73),
(51, 50, 78),
(52, 51, 43),
(53, 52, 90);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_site_fiyat`
--

DROP TABLE IF EXISTS `kitap_site_fiyat`;
CREATE TABLE IF NOT EXISTS `kitap_site_fiyat` (
  `kitap_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `fiyat` decimal(11,3) NOT NULL,
  KEY `kitap_id` (`kitap_id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_site_fiyat`
--

INSERT INTO `kitap_site_fiyat` (`kitap_id`, `site_id`, `fiyat`) VALUES
(1, 1, '170.000'),
(1, 2, '180.000'),
(1, 3, '190.000'),
(1, 4, '170.000'),
(1, 5, '170.000'),
(1, 6, '190.000'),
(1, 7, '180.000'),
(6, 1, '266.000'),
(6, 2, '266.000'),
(6, 3, '250.000'),
(6, 4, '266.000'),
(6, 5, '267.000'),
(6, 6, '261.000'),
(6, 7, '266.000'),
(8, 1, '140.000'),
(8, 2, '149.000'),
(8, 3, '142.000'),
(8, 4, '143.000'),
(8, 5, '147.000'),
(8, 6, '145.000'),
(8, 7, '143.000'),
(11, 1, '143.000'),
(11, 2, '149.000'),
(11, 3, '142.000'),
(11, 4, '143.000'),
(11, 5, '147.000'),
(11, 6, '145.000'),
(11, 7, '143.000'),
(13, 1, '252.230'),
(13, 2, '250.000'),
(13, 3, '258.280'),
(13, 4, '257.230'),
(13, 5, '252.230'),
(13, 6, '254.530'),
(13, 7, '252.230'),
(15, 1, '143.280'),
(15, 2, '141.280'),
(15, 3, '140.280'),
(15, 4, '143.820'),
(15, 5, '146.460'),
(15, 6, '142.520'),
(15, 7, '143.320'),
(16, 1, '69.080'),
(16, 2, '54.080'),
(16, 3, '74.080'),
(16, 4, '70.080'),
(16, 5, '64.500'),
(16, 6, '64.500'),
(16, 7, '64.000'),
(18, 1, '129.900'),
(18, 2, '122.100'),
(18, 3, '123.000'),
(18, 4, '126.000'),
(18, 5, '120.000'),
(18, 6, '126.500'),
(18, 7, '126.000'),
(19, 1, '139.990'),
(19, 2, '149.990'),
(19, 3, '140.490'),
(19, 4, '140.440'),
(19, 5, '140.500'),
(19, 6, '142.400'),
(19, 7, '145.400'),
(20, 1, '139.990'),
(20, 2, '149.990'),
(20, 3, '140.490'),
(20, 4, '140.440'),
(20, 5, '140.500'),
(20, 6, '142.400'),
(20, 7, '145.400'),
(22, 1, '235.990'),
(22, 2, '239.990'),
(22, 3, '240.000'),
(22, 4, '234.100'),
(22, 5, '240.500'),
(22, 6, '238.400'),
(22, 7, '243.400'),
(25, 1, '143.280'),
(25, 2, '144.000'),
(25, 3, '143.520'),
(25, 4, '143.000'),
(25, 5, '139.280'),
(25, 6, '143.380'),
(25, 7, '145.280'),
(26, 1, '157.790'),
(26, 2, '145.680'),
(26, 3, '157.680'),
(26, 4, '150.680'),
(26, 5, '160.680'),
(26, 6, '159.680'),
(26, 7, '165.680'),
(28, 1, '130.790'),
(28, 2, '133.680'),
(28, 3, '126.680'),
(28, 4, '130.680'),
(28, 5, '135.680'),
(28, 6, '133.680'),
(28, 7, '133.680'),
(29, 1, '64.790'),
(29, 2, '64.680'),
(29, 3, '65.680'),
(29, 4, '70.680'),
(29, 5, '60.680'),
(29, 6, '63.680'),
(29, 7, '60.680'),
(30, 1, '111.790'),
(30, 2, '110.680'),
(30, 3, '115.680'),
(30, 4, '111.680'),
(30, 5, '120.680'),
(30, 6, '111.680'),
(30, 7, '109.680'),
(31, 1, '54.790'),
(31, 2, '50.680'),
(31, 3, '55.680'),
(31, 4, '56.680'),
(31, 5, '54.680'),
(31, 6, '58.680'),
(31, 7, '50.680'),
(32, 1, '72.790'),
(32, 2, '71.680'),
(32, 3, '70.680'),
(32, 4, '75.680'),
(32, 5, '74.680'),
(32, 6, '70.680'),
(32, 7, '70.680'),
(33, 1, '72.790'),
(33, 2, '71.680'),
(33, 3, '70.680'),
(33, 4, '75.680'),
(33, 5, '74.680'),
(33, 6, '70.680'),
(33, 7, '70.680'),
(35, 1, '149.790'),
(35, 2, '151.680'),
(35, 3, '152.680'),
(35, 4, '150.680'),
(35, 5, '154.680'),
(35, 6, '149.680'),
(35, 7, '153.680'),
(37, 1, '234.790'),
(37, 2, '239.680'),
(37, 3, '229.680'),
(37, 4, '230.680'),
(37, 5, '234.680'),
(37, 6, '235.680'),
(37, 7, '230.680'),
(39, 1, '249.790'),
(39, 2, '251.680'),
(39, 3, '252.680'),
(39, 4, '250.680'),
(39, 5, '254.680'),
(39, 6, '249.680'),
(39, 7, '253.680'),
(40, 1, '108.790'),
(40, 2, '110.680'),
(40, 3, '112.680'),
(40, 4, '113.680'),
(40, 5, '116.680'),
(40, 6, '120.680'),
(40, 7, '124.680'),
(41, 1, '158.790'),
(41, 2, '160.680'),
(41, 3, '162.680'),
(41, 4, '163.680'),
(41, 5, '166.680'),
(41, 6, '170.680'),
(41, 7, '174.680');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_tur`
--

DROP TABLE IF EXISTS `kitap_tur`;
CREATE TABLE IF NOT EXISTS `kitap_tur` (
  `kitap_id` int(11) NOT NULL,
  `tur_id` int(11) NOT NULL,
  KEY `kitap_id` (`kitap_id`),
  KEY `tur_id` (`tur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_tur`
--

INSERT INTO `kitap_tur` (`kitap_id`, `tur_id`) VALUES
(6, 4),
(1, 1),
(7, 5),
(10, 8),
(12, 10),
(8, 5),
(9, 4),
(11, 8),
(13, 10),
(14, 11),
(15, 11),
(16, 5),
(17, 5),
(18, 5),
(19, 5),
(20, 8),
(21, 16),
(22, 16),
(23, 17),
(24, 17),
(25, 17),
(26, 18),
(27, 1),
(28, 1),
(29, 16),
(30, 19),
(31, 5),
(32, 19),
(33, 19),
(34, 20),
(35, 20),
(36, 1),
(37, 1),
(38, 17),
(39, 17),
(40, 5),
(41, 21),
(42, 5),
(43, 17),
(44, 8),
(45, 8),
(46, 20),
(47, 22),
(48, 19),
(49, 23),
(50, 1),
(51, 5),
(52, 8),
(53, 19);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_yazar`
--

DROP TABLE IF EXISTS `kitap_yazar`;
CREATE TABLE IF NOT EXISTS `kitap_yazar` (
  `kitap_id` int(11) NOT NULL,
  `yazar_id` int(11) NOT NULL,
  KEY `kitap_id` (`kitap_id`),
  KEY `yazar_id` (`yazar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_yazar`
--

INSERT INTO `kitap_yazar` (`kitap_id`, `yazar_id`) VALUES
(6, 4),
(1, 1),
(7, 5),
(10, 8),
(12, 10),
(13, 10),
(14, 11),
(15, 11),
(16, 12),
(17, 13),
(18, 13),
(19, 14),
(20, 15),
(21, 16),
(22, 16),
(23, 17),
(24, 17),
(25, 17),
(26, 18),
(27, 19),
(28, 19),
(29, 20),
(30, 21),
(31, 12),
(32, 22),
(33, 22),
(34, 23),
(35, 23),
(36, 18),
(37, 18),
(38, 24),
(39, 24),
(40, 25),
(41, 26),
(42, 12),
(43, 27),
(44, 28),
(45, 15),
(46, 29),
(47, 30),
(48, 31),
(49, 32),
(50, 33),
(51, 34),
(52, 35),
(53, 22);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `musteri`
--

DROP TABLE IF EXISTS `musteri`;
CREATE TABLE IF NOT EXISTS `musteri` (
  `musteri_id` int(11) NOT NULL AUTO_INCREMENT,
  `adi` varchar(45) COLLATE utf8_turkish_ci NOT NULL,
  `soyadi` varchar(45) COLLATE utf8_turkish_ci NOT NULL,
  `tel_no` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `tc_no` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `adres` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`musteri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `musteri`
--

INSERT INTO `musteri` (`musteri_id`, `adi`, `soyadi`, `tel_no`, `tc_no`, `adres`) VALUES
(1, 'Dilek', 'Arslan', '+90 533 424 17 96', '15920477870', 'Sokak: ZİYAPAŞA BULVARI N 1013, Kurtuluş\r\nŞehir: Seyhan\r\nEyalet/il/alan: Adana\r\nTelefon numarası: 322 4576624\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(2, 'Gülsüm', 'Tarçın', '+90 509 552 81 63', '59322136270', 'Sokak: Öveçler\r\nŞehir: Çankaya\r\nEyalet/il/alan: Ankara\r\nTelefon numarası: 312 4794329\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(3, 'Songül', 'Köse', '+90 543 665 47 62', '92389859980', 'Sokak: İnönü cad no 5 altıntaş izmir, 35500\r\nŞehir: Konak\r\nEyalet/il/bölge: İzmir\r\nTelefon numarası: 035 2622326\r\nÜlke telefon kodu: +90\r\nÜlke: Türkiye'),
(4, 'Kübra', 'Çakır', '+90 503 463 13 70', '49986883566', 'Sokak: BAĞLARBAŞI C N 107/C, Abidinpaşa\r\nŞehir: Mamak\r\nEyalet/il/bölge: Ankara\r\nTelefon numarası: 312 3658686\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(5, 'Halime', 'Can', '+90 539 788 89 88', '60784282580', 'Sokak: Pınarbaşı\r\nŞehir: Bornova\r\nEyalet/il/alan: İzmir\r\nTelefon numarası: 232 4790432\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(6, 'Döndü', 'Taş', '+90 532 421 10 36', '97464193676', 'Sokak: 851 S N 6/106, Kemeraltı\r\nŞehir: Konak\r\nEyalet/il/bölge: İzmir\r\nTelefon numarası: 232 4847591\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(7, 'Mustafa', 'Korkmaz', '+90 536 906 50 61', '73890540680', 'Sokak: ÇUKURBAĞ YARIMADASI\r\nŞehir: Kaş\r\nEyalet/il/alan: Antalya\r\nTelefon numarası: 242 8363816\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(8, 'Kemal', 'Kara', '+90 558 117 60 74', '30096113902', 'Sokak: Elmadağ\r\nŞehir: Şişli\r\nEyalet/il/alan: İstanbul\r\nTelefon numarası: 2415314\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(9, 'İsmail', 'Arslan', '+90 559 654 98 40', '14035971426', 'Sokak: BAĞLAR C N 153/A, Küçükesat\r\nŞehir: Çankaya\r\nEyalet/il/bölge: Ankara\r\nTelefon numarası: 312 4476395\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye'),
(10, 'Kerem', 'Özdemir', '+90 552 674 80 36', '43843099190', 'Sokak: Yenişehir\r\nŞehir: Konak\r\nEyalet/il/alan: İzmir\r\nTelefon numarası: 232 4490445\r\nÜlke arama kodu: +90\r\nÜlke: Türkiye');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `satislar`
--

DROP TABLE IF EXISTS `satislar`;
CREATE TABLE IF NOT EXISTS `satislar` (
  `satis_id` int(11) NOT NULL AUTO_INCREMENT,
  `kitap_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `adet` int(11) NOT NULL,
  `satis_tarihi` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`satis_id`),
  KEY `kitap_id` (`kitap_id`),
  KEY `site_id` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `satislar`
--

INSERT INTO `satislar` (`satis_id`, `kitap_id`, `site_id`, `adet`, `satis_tarihi`) VALUES
(8, 8, 6, 1, '2024-12-28 11:17:17'),
(9, 21, 1, 1, '2024-10-17 21:00:00'),
(10, 28, 6, 2, '2024-06-20 21:00:00'),
(11, 43, 1, 10, '2024-10-14 21:00:00'),
(12, 11, 6, 6, '2024-12-23 21:00:00'),
(13, 16, 3, 5, '2024-07-09 21:00:00'),
(14, 13, 3, 8, '2024-04-15 21:00:00'),
(15, 30, 1, 8, '2024-09-10 21:00:00'),
(16, 41, 5, 4, '2024-01-18 21:00:00'),
(18, 21, 1, 1, '2024-10-17 21:00:00'),
(19, 28, 6, 2, '2024-06-20 21:00:00'),
(20, 43, 1, 10, '2024-10-14 21:00:00'),
(21, 11, 6, 6, '2024-12-23 21:00:00'),
(22, 16, 3, 5, '2024-07-09 21:00:00'),
(23, 13, 3, 8, '2024-04-15 21:00:00'),
(24, 30, 1, 8, '2024-09-10 21:00:00'),
(25, 41, 5, 4, '2024-01-18 21:00:00'),
(26, 50, 3, 2, '2024-09-30 21:00:00'),
(27, 18, 2, 6, '2024-02-25 21:00:00'),
(28, 25, 7, 5, '2024-12-26 21:00:00'),
(29, 44, 1, 2, '2024-01-13 21:00:00'),
(31, 21, 1, 1, '2024-10-17 21:00:00'),
(32, 28, 6, 2, '2024-06-20 21:00:00'),
(33, 43, 1, 10, '2024-10-14 21:00:00'),
(34, 11, 6, 6, '2024-12-23 21:00:00'),
(35, 16, 3, 5, '2024-07-09 21:00:00'),
(36, 13, 3, 8, '2024-04-15 21:00:00'),
(37, 30, 1, 8, '2024-09-10 21:00:00'),
(38, 41, 5, 4, '2024-01-18 21:00:00'),
(39, 50, 3, 2, '2024-09-30 21:00:00'),
(40, 18, 2, 6, '2024-02-25 21:00:00'),
(41, 25, 7, 5, '2024-12-26 21:00:00'),
(42, 44, 1, 2, '2024-01-13 21:00:00'),
(43, 34, 4, 5, '2024-09-07 21:00:00'),
(44, 15, 7, 1, '2024-06-06 21:00:00'),
(45, 26, 5, 4, '2024-04-08 21:00:00'),
(46, 20, 4, 9, '2024-05-23 21:00:00'),
(47, 12, 2, 3, '2024-11-09 21:00:00'),
(48, 36, 6, 6, '2024-08-22 21:00:00'),
(49, 38, 2, 5, '2024-03-12 21:00:00'),
(50, 27, 3, 2, '2024-04-30 21:00:00'),
(51, 19, 5, 8, '2024-11-01 21:00:00'),
(52, 32, 4, 7, '2024-03-21 21:00:00'),
(53, 49, 2, 1, '2024-07-27 21:00:00'),
(54, 29, 6, 10, '2024-05-02 21:00:00'),
(55, 14, 7, 4, '2024-08-05 21:00:00'),
(56, 22, 6, 8, '2024-12-05 21:00:00'),
(57, 46, 5, 9, '2024-01-26 21:00:00'),
(58, 45, 3, 4, '2024-03-04 21:00:00'),
(59, 37, 6, 7, '2024-11-20 21:00:00'),
(60, 24, 4, 5, '2024-10-10 21:00:00'),
(61, 42, 5, 8, '2024-02-06 21:00:00'),
(62, 17, 1, 7, '2024-03-25 21:00:00'),
(63, 10, 7, 6, '2024-04-17 21:00:00'),
(64, 39, 6, 10, '2024-07-02 21:00:00'),
(65, 40, 2, 5, '2024-10-01 21:00:00'),
(66, 33, 7, 6, '2024-09-12 21:00:00'),
(67, 23, 1, 4, '2024-05-15 21:00:00'),
(68, 48, 5, 3, '2024-10-23 21:00:00'),
(69, 31, 4, 8, '2024-03-07 21:00:00'),
(70, 30, 6, 7, '2024-11-15 21:00:00'),
(71, 13, 2, 4, '2024-09-29 21:00:00'),
(72, 28, 7, 2, '2024-12-04 21:00:00'),
(73, 47, 1, 6, '2024-02-18 21:00:00'),
(74, 11, 5, 5, '2024-07-17 21:00:00'),
(75, 50, 2, 8, '2024-04-25 21:00:00'),
(76, 22, 3, 9, '2024-08-11 21:00:00'),
(77, 12, 6, 2, '2024-06-14 21:00:00');

--
-- Tetikleyiciler `satislar`
--
DROP TRIGGER IF EXISTS `update_stock_after_sale`;
DELIMITER $$
CREATE TRIGGER `update_stock_after_sale` AFTER INSERT ON `satislar` FOR EACH ROW BEGIN
  -- Update the stock of the corresponding book
  UPDATE kitap_baski
  SET stok = stok - NEW.adet
  WHERE kitap_id = NEW.kitap_id;

  -- Optional: Check if stock goes negative
  IF (SELECT stok FROM kitap_baski WHERE kitap_id = NEW.kitap_id) < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Stock cannot be negative.';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `siteler`
--

DROP TABLE IF EXISTS `siteler`;
CREATE TABLE IF NOT EXISTS `siteler` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_adi` varchar(50) COLLATE utf8_turkish_ci DEFAULT NULL,
  `site_url` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `siteler`
--

INSERT INTO `siteler` (`site_id`, `site_adi`, `site_url`) VALUES
(1, 'Nadir Kitap', 'www.nadirkitap.com'),
(2, 'hepsiburada', 'www.hepsiburada.com'),
(3, 'idefix', 'www.idefix.com'),
(4, 'BKM Kitap', 'www.bkmkitap.com'),
(5, 'YAYBİR', 'www.yaybir.org.tr'),
(6, 'Pandora', 'www.pandora.com.tr'),
(7, 'Babil', 'www.babil.com'),
(8, 'Dükkandan Satış', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `turler`
--

DROP TABLE IF EXISTS `turler`;
CREATE TABLE IF NOT EXISTS `turler` (
  `tur_id` int(11) NOT NULL AUTO_INCREMENT,
  `tur_ad` varchar(100) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`tur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `turler`
--

INSERT INTO `turler` (`tur_id`, `tur_ad`) VALUES
(1, 'Tarih Araştırma ve İnceleme Kitapları'),
(4, 'Referans ve Kaynak Kitapları'),
(5, 'Öykü Kitapları'),
(8, 'Roman'),
(10, 'Genel Sanat ve Mimarlık Kitapları'),
(11, 'Genel Spor Kitapları'),
(16, 'Anı-Mektup-Günlük kitapları'),
(17, 'Akademik Kitaplar'),
(18, 'Güncel Siyaset Kitapları'),
(19, 'Şiir Kitapları'),
(20, 'Türk Edebiyatı Romanları'),
(21, 'Etik Kitaplar'),
(22, 'Denemeler'),
(23, 'İş Dünyası Kitapları');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yazarlar`
--

DROP TABLE IF EXISTS `yazarlar`;
CREATE TABLE IF NOT EXISTS `yazarlar` (
  `yazar_id` int(11) NOT NULL AUTO_INCREMENT,
  `adi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `soyadi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`yazar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yazarlar`
--

INSERT INTO `yazarlar` (`yazar_id`, `adi`, `soyadi`) VALUES
(1, 'Ahmet', 'Hür'),
(4, 'Alaaddin', 'Turgut'),
(5, 'Mustafa', 'Zengin'),
(8, 'Mehmet Ziya', 'Eriş'),
(10, 'Taner', 'Arda'),
(11, 'Muzaffer K', 'Sarvan'),
(12, 'İlhan', 'Soytürk'),
(13, 'Cengiz', 'Çetin'),
(14, 'Ayşe Ceylin', 'Üzel'),
(15, 'Yavuz', 'Atıl'),
(16, 'Osman', 'Gökçe'),
(17, 'Ali', 'Özdemir'),
(18, 'Uğur', 'Belger'),
(19, 'Bayram ', 'Ömeroğlu'),
(20, 'İzzet Akın', 'Tütüncüler'),
(21, 'Leytun', 'Kaplan'),
(22, 'Güntürk', 'Üstün'),
(23, 'Hüseyin', 'Kırıcı'),
(24, 'Tevfik', ' Pekin'),
(25, 'Ayşegül Gümrah', 'Tuncel'),
(26, 'Kolektif', ''),
(27, 'Ahmet ', 'Kaya'),
(28, 'Atalay', 'Budakcı'),
(29, 'Hakan', 'Kiper'),
(30, 'Esin Emin', 'Üstün'),
(31, 'Nagihan', 'Akbalık'),
(32, 'Gonca', 'Elibol'),
(33, 'Ömer Oğuzhan', 'Dosti'),
(34, 'Münevver', 'Ergin'),
(35, 'Nuran', 'Benli');

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `kiralik`
--
ALTER TABLE `kiralik`
  ADD CONSTRAINT `kiralik_ibfk_1` FOREIGN KEY (`musteri_id`) REFERENCES `musteri` (`musteri_id`),
  ADD CONSTRAINT `kiralik_ibfk_3` FOREIGN KEY (`baski_id`) REFERENCES `baski` (`baski_id`),
  ADD CONSTRAINT `kiralik_ibfk_4` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitaplar`
--
ALTER TABLE `kitaplar`
  ADD CONSTRAINT `kitaplar_ibfk_1` FOREIGN KEY (`basimevi_id`) REFERENCES `basimevi` (`basimevi_id`);

--
-- Tablo kısıtlamaları `kitap_baski`
--
ALTER TABLE `kitap_baski`
  ADD CONSTRAINT `kitap_baski_ibfk_2` FOREIGN KEY (`baski_id`) REFERENCES `baski` (`baski_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kitap_baski_ibfk_3` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitap_site_fiyat`
--
ALTER TABLE `kitap_site_fiyat`
  ADD CONSTRAINT `kitap_site_fiyat_ibfk_3` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kitap_site_fiyat_ibfk_4` FOREIGN KEY (`site_id`) REFERENCES `siteler` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitap_tur`
--
ALTER TABLE `kitap_tur`
  ADD CONSTRAINT `kitap_tur_ibfk_2` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kitap_tur_ibfk_3` FOREIGN KEY (`tur_id`) REFERENCES `turler` (`tur_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitap_yazar`
--
ALTER TABLE `kitap_yazar`
  ADD CONSTRAINT `kitap_yazar_ibfk_3` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kitap_yazar_ibfk_4` FOREIGN KEY (`yazar_id`) REFERENCES `yazarlar` (`yazar_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `satislar`
--
ALTER TABLE `satislar`
  ADD CONSTRAINT `satislar_ibfk_3` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `satislar_ibfk_4` FOREIGN KEY (`site_id`) REFERENCES `siteler` (`site_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
