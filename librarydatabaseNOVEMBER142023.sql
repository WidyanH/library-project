-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 14, 2023 at 10:19 PM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id21484403_librarydatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `alertID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `alertDate` datetime NOT NULL,
  `alertType` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `authorID` int(11) NOT NULL,
  `authorName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`authorID`, `authorName`) VALUES
(1, 'J.K. Rowling'),
(2, 'Stephen Chbosky'),
(3, 'Suzanne Collins\r\n'),
(8, 'Susan EE'),
(11, 'Jeff Kinney'),
(12, 'ONE'),
(13, 'test'),
(14, 'asda'),
(15, 'asdad'),
(16, 'Jinn');

-- --------------------------------------------------------

--
-- Table structure for table `bookcopy`
--

CREATE TABLE `bookcopy` (
  `bookID` int(11) NOT NULL,
  `bookCopyID` int(11) NOT NULL,
  `publishedDate` date NOT NULL,
  `addDate` datetime NOT NULL,
  `available` bit(1) NOT NULL DEFAULT b'1',
  `value` decimal(10,2) NOT NULL,
  `coverType` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookcopy`
--

INSERT INTO `bookcopy` (`bookID`, `bookCopyID`, `publishedDate`, `addDate`, `available`, `value`, `coverType`) VALUES
(1, 1, '1999-02-01', '2023-10-08 17:11:14', b'0', 10.66, 'Paperback'),
(1, 2, '1999-02-01', '2023-10-08 17:11:14', b'0', 10.66, 'Paperback'),
(2, 3, '2008-07-14', '2023-10-08 17:13:56', b'1', 21.50, 'Hardcover'),
(2, 4, '2008-07-14', '2023-10-08 17:13:56', b'1', 12.79, 'Paperback'),
(2, 5, '2008-07-14', '2023-10-08 17:13:56', b'1', 21.50, 'Hardcover'),
(2, 6, '2008-07-14', '2023-10-08 17:13:56', b'1', 12.79, 'Paperback'),
(3, 7, '1998-09-01', '2023-10-08 17:14:42', b'1', 15.45, 'Paperback'),
(3, 8, '1998-09-01', '2023-10-08 17:14:42', b'0', 15.45, 'Paperback'),
(6, 11, '2011-05-21', '2023-10-20 10:30:29', b'1', 10.99, 'paperback'),
(6, 12, '2011-05-21', '2023-10-20 10:30:29', b'1', 10.99, 'paperback'),
(8, 14, '2007-04-01', '2023-10-21 17:47:09', b'1', 25.99, 'hardback'),
(8, 15, '2007-04-01', '2023-10-21 17:47:09', b'1', 25.99, 'hardback'),
(12, 17, '2018-11-06', '2023-11-06 02:43:01', b'1', 11.99, 'paperback');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `bookID` int(11) NOT NULL,
  `publicationCompany` varchar(255) NOT NULL,
  `bookName` varchar(255) NOT NULL,
  `ISBN` varchar(13) NOT NULL,
  `coverFilePath` varchar(255) NOT NULL,
  `genre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`bookID`, `publicationCompany`, `bookName`, `ISBN`, `coverFilePath`, `genre`) VALUES
(1, 'Pocket Books', 'The Perks of Being a Wallflower', '9781451696196', '/main resources/item covers/bookCovers/thePerksOfBeingAWallflower.jpg', NULL),
(2, 'Scholastic', 'The Hunger Games', '9780439023481', '/main resources/item covers/bookCovers/theHungerGames.jpg', 'Action'),
(3, 'Scholastic', 'Harry Potter and the Sorcerer\'s Stone', '9780747532743', '/main resources/item covers/bookCovers/harryPotterAndTheSorcerersStone.jfif', NULL),
(6, 'Feral Dream', 'Angelfall', '9781501238109', '/main resources/item covers/bookCovers/angelfall.jpg', NULL),
(8, 'Amulet Books', 'Diary of a Wimpy Kid', '9781439582633', '/main resources/item covers/bookCovers/diary of a wimpy kid.jpg', NULL),
(12, 'Dark Horse Comics', 'Mob Psycho 100 Volume 1', '9781506709871', '/main resources/item covers/bookCovers/654852b56d95a.jpg', NULL);

--
-- Triggers `books`
--
DELIMITER $$
CREATE TRIGGER `before_insert_book` BEFORE INSERT ON `books` FOR EACH ROW BEGIN
    DECLARE isbn_count INT;
    
    -- Check if the ISBN already exists
    SELECT COUNT(*) INTO isbn_count FROM books WHERE ISBN = NEW.ISBN;
    
    -- If ISBN already exists, prevent the insert
    IF isbn_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ISBN already exists in the books table';
    END IF;
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `borrowed`
--

CREATE TABLE `borrowed` (
  `borrowID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `itemType` varchar(6) NOT NULL,
  `itemCopyID` int(11) NOT NULL,
  `borrowStatus` varchar(20) NOT NULL,
  `checkoutDate` datetime NOT NULL,
  `dueDate` datetime NOT NULL,
  `returnedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowed`
--

INSERT INTO `borrowed` (`borrowID`, `userID`, `itemType`, `itemCopyID`, `borrowStatus`, `checkoutDate`, `dueDate`, `returnedDate`) VALUES
(1, 1, 'book', 1, 'checked out', '2023-11-08 10:28:49', '2023-11-15 10:28:49', NULL),
(2, 1, 'movie', 2, 'returned', '2023-10-01 10:29:47', '2023-10-08 10:29:47', '2023-10-04 10:29:47'),
(3, 3, 'movie', 4, 'checked out', '2023-11-10 10:31:01', '2023-11-17 10:31:01', NULL),
(4, 3, 'book', 8, 'checked out', '2023-11-09 10:45:30', '2023-11-16 10:45:30', NULL),
(5, 3, 'movie', 4, 'checked out', '2023-11-10 10:31:01', '2023-11-17 10:31:01', NULL),
(6, 4, 'movie', 2, 'returned', '2023-09-18 21:23:40', '2023-09-25 21:23:40', '2023-09-21 21:23:40'),
(7, 4, 'movie', 3, 'returned', '2023-10-01 21:24:49', '2023-10-08 21:24:49', '2023-10-05 21:24:49'),
(8, 4, 'book', 3, 'checkedOut', '2023-11-13 20:02:55', '2023-11-20 20:02:55', NULL),
(9, 8, 'book', 12, 'returned', '2023-11-14 00:23:59', '2023-11-21 00:23:59', '2023-11-14 00:25:20'),
(10, 4, 'movie', 3, 'checked out', '2023-11-06 21:24:49', '2023-11-13 21:24:49', NULL),
(11, 1, 'movie', 2, 'returned', '2023-10-09 10:29:47', '2023-10-16 10:29:47', '2023-10-12 10:29:47');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `brandID` int(11) NOT NULL,
  `brandName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`brandID`, `brandName`) VALUES
(1, 'Lenovo'),
(2, ''),
(3, 'Dell'),
(4, 'Apple'),
(5, 'Samsung');

-- --------------------------------------------------------

--
-- Table structure for table `directedby`
--

CREATE TABLE `directedby` (
  `movieID` int(11) NOT NULL,
  `directorID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `directedby`
--

INSERT INTO `directedby` (`movieID`, `directorID`) VALUES
(1, 2),
(2, 1),
(25, 11),
(26, 12),
(29, 15),
(30, 15),
(31, 14),
(32, 14),
(1, 2),
(2, 1),
(25, 11),
(26, 12),
(1, 2),
(2, 1),
(25, 11),
(26, 12),
(3, 13);

-- --------------------------------------------------------

--
-- Table structure for table `directors`
--

CREATE TABLE `directors` (
  `directorID` int(11) NOT NULL,
  `directorName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `directors`
--

INSERT INTO `directors` (`directorID`, `directorName`) VALUES
(1, 'James Wan'),
(2, 'Bong Joon-ho'),
(11, 'Tony Bancroft'),
(12, 'Carlos López Estrada'),
(13, 'Leigh Whannell'),
(14, 'Ghibli'),
(15, 'Gary Ross');

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `fineID` int(11) NOT NULL,
  `borrowID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `fineAmount` decimal(10,2) NOT NULL,
  `havePaid` varchar(6) NOT NULL DEFAULT 'No',
  `type` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`fineID`, `borrowID`, `userID`, `fineAmount`, `havePaid`, `type`) VALUES
(1, 4, 4, 5.00, 'No', 'lost'),
(2, 1, 2, 10.66, 'Yes', 'lost'),
(3, 3, 4, 5.00, 'Yes', 'late'),
(4, 1, 1, 5.00, 'No', 'lost'),
(5, 2, 1, 5.00, 'No', 'lost'),
(10, 7, 4, 5.00, 'Waived', 'late'),
(15, 5, 3, 5.00, 'Waived', 'lost'),
(16, 6, 4, 5.00, 'Waived', 'lost'),
(18, 3, 3, 20.99, 'No', 'lost'),
(19, 10, 4, 25.99, 'Yes', 'lost');

--
-- Triggers `fines`
--
DELIMITER $$
CREATE TRIGGER `update_canBorrow_if_paid` AFTER INSERT ON `fines` FOR EACH ROW BEGIN
    -- Check if all fines for this user have been paid or waived
    DECLARE total_fines INT;
    DECLARE paid_fines INT;
 
    SELECT COUNT(*) INTO total_fines FROM fines WHERE userID = NEW.userID;
    SELECT COUNT(*) INTO paid_fines FROM fines WHERE userID = NEW.userID AND havePaid IN ('Yes', 'Waived');
 
    IF total_fines = paid_fines THEN
        -- All fines have been paid or waived, update canBorrow to 1
        UPDATE users
        SET canBorrow = 1
        WHERE userID = NEW.userID;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_canBorrow_if_unpaid` AFTER UPDATE ON `fines` FOR EACH ROW BEGIN
    -- Check if there are any unpaid fines for this user
    DECLARE unpaid_fines INT;

    SELECT COUNT(*) INTO unpaid_fines FROM fines WHERE userID = NEW.userID AND havePaid NOT IN ('Yes', 'Waived');

    -- Check if there are any unpaid fines
    IF unpaid_fines > 0 THEN
        -- There are unpaid fines, update canBorrow to 0
        UPDATE users
        SET canBorrow = 0
        WHERE userID = NEW.userID;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `holds`
--

CREATE TABLE `holds` (
  `holdID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `itemType` varchar(6) NOT NULL,
  `itemID` int(11) NOT NULL,
  `requestDate` datetime NOT NULL,
  `requestStatus` varchar(20) NOT NULL,
  `itemCopyID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `holds`
--

INSERT INTO `holds` (`holdID`, `userID`, `itemType`, `itemID`, `requestDate`, `requestStatus`, `itemCopyID`) VALUES
(1, 2, 'movie', 2, '2023-10-06 20:06:40', 'pickedUp', NULL),
(2, 2, 'book', 2, '2023-10-08 07:42:44', 'pickedUp', NULL),
(3, 3, 'book', 8, '2023-10-01 20:06:40', 'readyForPickUp', NULL),
(4, 5, 'book', 6, '2023-10-31 11:18:33', 'denied', NULL),
(5, 5, 'tech', 3, '2023-11-01 05:25:29', 'pending', NULL),
(8, 5, 'movie', 25, '2023-11-03 00:00:00', 'pickedUp', NULL),
(9, 5, 'book', 8, '2023-11-03 20:49:52', 'pickedUp', NULL),
(10, 8, 'book', 12, '2023-11-06 04:20:54', 'pending', NULL),
(11, 8, 'movie', 31, '2023-11-06 04:21:17', 'pending', NULL),
(12, 8, 'tech', 4, '2023-11-06 04:21:48', 'pending', NULL),
(13, 4, 'book', 2, '2023-11-10 06:03:49', 'pickedUp', 3),
(14, 2, 'book', 2, '2023-11-13 19:47:03', 'pickedUp', NULL),
(15, 2, 'book', 8, '2023-11-13 19:53:39', 'pickedUp', NULL);

--
-- Triggers `holds`
--
DELIMITER $$
CREATE TRIGGER `prevent_hold_insert` BEFORE INSERT ON `holds` FOR EACH ROW BEGIN
  DECLARE hold_count INT;
  DECLARE borrow_count INT;

  -- Count the number of pending holds for the user
  SELECT COUNT(*) INTO hold_count
  FROM holds
  WHERE userID = NEW.userID AND requestStatus = 'pending';

  -- Count the number of checked-out items for the user
  SELECT COUNT(*) INTO borrow_count
  FROM borrowed
  WHERE userID = NEW.userID AND borrowStatus = 'checked out';

  -- Check the condition before allowing the insertion
  IF (hold_count + borrow_count) >= 5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'You have exceeded the number of requests you can make. Please return some of your items or cancel any of your pending reservations.';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item_description`
--

CREATE TABLE `item_description` (
  `itemType` varchar(6) DEFAULT NULL,
  `itemID` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item_description`
--

INSERT INTO `item_description` (`itemType`, `itemID`, `description`) VALUES
('book', 1, 'Set in the early 1990s, the novel follows Charlie, an introverted and observant teenager, through his freshman year of high school in a Pittsburgh suburb. The novel details Charlie\'s unconventional style of thinking as he navigates between the worlds of adolescence and adulthood, and attempts to deal with poignant questions spurred by his interactions with both his friends and family.'),
('book', 2, 'In the ruins of a place once known as North America lies the nation of Panem, a shining Capitol surrounded by twelve outlying districts. The Capitol is harsh and cruel and keeps the districts in line by forcing them all to send one boy and one girl between the ages of twelve and eighteen to participate in the annual Hunger Games, a fight to the death on live TV'),
('book', 3, 'Harry Potter thinks he is an ordinary boy - until he is rescued by an owl, taken to Hogwarts School of Witchcraft and Wizardry, learns to play Quidditch and does battle in a deadly duel. The Reason ... HARRY POTTER IS A WIZARD!'),
('book', 6, 'It\'s been six weeks since angels of the apocalypse descended to demolish the modern world. Street gangs rule the day while fear and superstition rule the night. When warrior angels fly away with a helpless little girl, her seventeen-year-old sister Penryn will do anything to get her back.\n\nAnything, including making a deal with an enemy angel'),
('book', 8, 'Greg Heffley finds himself thrust into a new year and a new school where undersize weaklings share the corridors with kids who are taller, meaner and already shaving.\n\nDesperate to prove his new found maturity, which only going up a grade can bring, Greg is happy to have his not-quite-so-cool sidekick, Rowley, along for the ride. But when Rowley\'s star starts to rise, Greg tries to use his best friend\'s popularity to his own advantage. Recorded in his diary with comic pictures and his very own words, this test of Greg and Rowley\'s friendship unfolds with hilarious results'),
('movie', 2, 'Survivors of Earth\'s second ice age live out their days on a luxury train that ploughs through snow and ice. The train\'s poorest residents, who live in the squalid caboose, plan to improve their lot by taking over the engine room.'),
('movie', 3, 'In 1970, paranormal investigators and demonologists Lorraine and Ed Warren are summoned to the home of Carolyn and Roger Perron. The Perrons and their five daughters have recently moved into a secluded farmhouse, where a supernatural presence has made itself known. Though the manifestations are relatively benign at first, events soon escalate in horrifying fashion, especially after the Warrens discover the house\'s macabre history.'),
('movie', 25, 'Fearful that her ailing father will be drafted into the Chinese military, Mulan takes his spot -- though, as a girl living under a patriarchal regime, she is technically unqualified to serve. She cleverly impersonates a man and goes off to train with fellow recruits. Accompanied by her dragon, Mushu, she uses her smarts to help ward off a Hun invasion, falling in love with a dashing captain along the way.'),
('movie', 26, 'Long ago, in the fantasy world of Kumandra, humans and dragons lived together in harmony. However, when sinister monsters known as the Druun threatened the land, the dragons sacrificed themselves to save humanity. Now, 500 years later, those same monsters have returned, and it\'s up to a lone warrior to track down the last dragon and stop the Druun for good.'),
('book', 13, 'asdad');

-- --------------------------------------------------------

--
-- Table structure for table `manufacturedby`
--

CREATE TABLE `manufacturedby` (
  `techID` int(11) NOT NULL,
  `brandID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `manufacturedby`
--

INSERT INTO `manufacturedby` (`techID`, `brandID`) VALUES
(1, 1),
(2, 3),
(3, 4),
(5, 5),
(1, 1),
(2, 3),
(3, 4),
(1, 1),
(2, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `moviecopy`
--

CREATE TABLE `moviecopy` (
  `movieCopyID` int(11) NOT NULL,
  `movieID` int(11) NOT NULL,
  `addDate` datetime NOT NULL,
  `available` bit(1) DEFAULT b'1',
  `value` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moviecopy`
--

INSERT INTO `moviecopy` (`movieCopyID`, `movieID`, `addDate`, `available`, `value`) VALUES
(2, 3, '2023-10-08 17:21:37', b'1', 15.42),
(3, 3, '2023-10-08 17:21:37', b'1', 15.42),
(4, 2, '2023-10-08 17:22:17', b'0', 15.50),
(6, 25, '2023-10-21 17:41:27', b'1', 19.99),
(7, 25, '2023-10-21 17:41:27', b'1', 19.99),
(8, 26, '2023-10-21 17:43:12', b'1', 19.99),
(9, 26, '2023-10-21 17:43:12', b'1', 19.99),
(10, 27, '2023-10-31 17:08:24', b'1', 19.99),
(11, 27, '2023-10-31 17:08:24', b'1', 19.99),
(12, 30, '2023-11-02 20:23:53', b'1', 19.99),
(13, 30, '2023-11-02 20:23:53', b'1', 19.99),
(14, 30, '2023-11-02 20:23:53', b'1', 19.99),
(15, 31, '2023-11-02 20:30:00', b'1', 6.99),
(16, 31, '2023-11-02 20:30:00', b'1', 6.99),
(17, 32, '2023-11-02 20:31:22', b'1', 5.99),
(18, 32, '2023-11-02 20:31:22', b'1', 5.99);

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `movieID` int(11) NOT NULL,
  `movieName` varchar(255) NOT NULL,
  `publishedDate` date NOT NULL,
  `productionCompany` varchar(255) NOT NULL,
  `coverFilePath` varchar(255) NOT NULL,
  `distributedBy` varchar(255) NOT NULL,
  `genre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`movieID`, `movieName`, `publishedDate`, `productionCompany`, `coverFilePath`, `distributedBy`, `genre`) VALUES
(2, 'Snowpiercer', '2013-08-01', 'CJ Entertainment', '/main resources/item covers/movieCovers/snowpiercer.jpg', 'CJ Entertainment', NULL),
(3, 'The Conjuring', '2013-07-15', 'New Line Cinema', '/main resources/item covers/movieCovers/theConjuring.jfif', 'Warner Bros. Pictures', NULL),
(25, 'Mulan', '1998-06-05', 'Walt Disney Pictures', '/main resources/item covers/movieCovers/mulan.jpeg', 'Walt Disney Pictures', NULL),
(26, 'Raya and the Last Dragon', '2021-03-05', 'Walt Disney Pictures', '/main resources/item covers/movieCovers/raya.jpeg', 'Walt Disney Pictures', NULL),
(30, 'The Hunger Games', '2012-03-23', 'Lionsgate', '/main resources/item covers/movieCovers/6544055960706.jpg', 'Lionsgate', NULL),
(31, 'Spirited Away', '2018-01-02', 'Ghibli', '/main resources/item covers/movieCovers/654406c821d51.jpg', 'Ghibli', NULL),
(32, 'Princess Mononoke', '2016-02-02', 'Ghibli', '/main resources/item covers/movieCovers/6544071ac50b5.jpg', 'Ghibli', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tech`
--

CREATE TABLE `tech` (
  `techID` int(11) NOT NULL,
  `publishedDate` date NOT NULL,
  `techName` varchar(255) NOT NULL,
  `coverFilePath` varchar(255) NOT NULL,
  `modelNumber` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tech`
--

INSERT INTO `tech` (`techID`, `publishedDate`, `techName`, `coverFilePath`, `modelNumber`) VALUES
(1, '2018-02-01', 'Lenovo ThinkPad T480s', '/main resources/item covers/techCovers/lenovoThinkPadT480sLaptop.jfif', 'ThinkPad T480s'),
(2, '2021-02-01', 'Dell Chromebook 3110', '/main resources/item covers/techCovers/tech2.jpg', '11\" 3110'),
(3, '2020-01-01', 'Apple 2020 MacBook Air', '/main resources/item covers/techCovers/tech3.jfif', 'MacBook Air'),
(4, '2021-07-08', 'iPad Air Wi-Fi 64GB - Rose Gold (4th Generation)', '/main resources/item covers/techCovers/654407e30594f.jpg', 'I1234568'),
(5, '2021-06-01', 'Samsung - 15.6\" Chromebook - Intel Celeron', '/main resources/item covers/techCovers/65440b2933f52.jpg', 'XE350XBA-K02USSKU');

-- --------------------------------------------------------

--
-- Table structure for table `techcopy`
--

CREATE TABLE `techcopy` (
  `techCopyID` int(11) NOT NULL,
  `techID` int(11) NOT NULL,
  `addDate` datetime NOT NULL,
  `available` bit(1) NOT NULL DEFAULT b'1',
  `serialNumber` varchar(255) NOT NULL,
  `value` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `techcopy`
--

INSERT INTO `techcopy` (`techCopyID`, `techID`, `addDate`, `available`, `serialNumber`, `value`) VALUES
(2, 1, '2023-10-08 17:26:12', b'1', '000000001', 0.00),
(3, 1, '2023-10-08 17:26:12', b'1', '000000002', 0.00),
(4, 2, '2023-10-21 18:13:36', b'1', '202020220', 250.00),
(5, 3, '2023-10-21 18:15:46', b'1', '1111111111', 800.00),
(6, 3, '2023-10-21 18:15:46', b'1', '1111111111', 800.00),
(7, 5, '2023-11-02 20:48:41', b'1', '99999999999', 219.00),
(8, 4, '2023-11-02 20:48:41', b'1', '555555555', 300.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `uhID` int(11) NOT NULL,
  `userType` varchar(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(25) NOT NULL,
  `borrowLimit` int(11) NOT NULL DEFAULT 7,
  `canBorrow` bit(1) DEFAULT b'1',
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `securityQ1` varchar(50) NOT NULL,
  `securityQ2` varchar(50) NOT NULL,
  `securityQ3` varchar(50) NOT NULL,
  `securityA1` varchar(50) NOT NULL,
  `securityA2` varchar(50) NOT NULL,
  `securityA3` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `uhID`, `userType`, `email`, `password`, `borrowLimit`, `canBorrow`, `firstName`, `lastName`, `securityQ1`, `securityQ2`, `securityQ3`, `securityA1`, `securityA2`, `securityA3`) VALUES
(2, 1954549, 'student', 'tpha@uh.edu', 'admin', 7, b'1', 'Jinn', 'Ha', 'What is your favorite food?', 'What is your first pet\'s name?', 'What is your favorite fruit?', 'Sushi', 'Max', 'Mangos'),
(3, 1234567, 'faculty', 'faculty1@uh.edu', 'admin', 14, b'0', 'John', 'Smith', 'What school do you go to?', 'What is your favorite color?', 'What is your pet\'s name?', 'University of Houston', 'Red', 'Bob'),
(4, 1111111, 'student', 'badstudent@uh.edu', 'admin', 7, b'0', 'Jane', 'Doe', 'What is your favorite food?', 'What is your favorite color?', 'What is your favorite fruit?', 'Pizza', 'Pink', 'Apples'),
(5, 9999999, 'management', 'manager@uh.edu', 'admin', 14, b'1', 'Manny', 'Managerial', 'What is your favorite food?', 'lobster', 'What is your favorite color?', 'blue', 'What is your favorite fruit?', 'kiwi'),
(8, 2222222, 'Student', 'wmhss@gmail.com', 'admin', 7, b'1', 'Widyan', 'Hussien', 'What is the name of your first pet?', 'What is your favorite food?', 'What was the first concert you attended?', 'Capoochi', 'Pizza', 'Russel Peters');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `before_insert_users` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    DECLARE uhid_count INT;

    -- Check if the UHID already exists
    SELECT COUNT(*) INTO uhid_count
    FROM users
    WHERE UHID = NEW.UHID;

    -- If the UHID already exists, raise an error
    IF uhid_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: UHID already exists.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `writtenby`
--

CREATE TABLE `writtenby` (
  `writtenByID` int(11) NOT NULL,
  `bookID` int(11) NOT NULL,
  `authorID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `writtenby`
--

INSERT INTO `writtenby` (`writtenByID`, `bookID`, `authorID`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 1),
(6, 6, 8),
(8, 8, 11),
(9, 11, 13),
(10, 12, 12),
(11, 13, 16);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`alertID`);

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`authorID`);

--
-- Indexes for table `bookcopy`
--
ALTER TABLE `bookcopy`
  ADD PRIMARY KEY (`bookCopyID`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`bookID`);

--
-- Indexes for table `borrowed`
--
ALTER TABLE `borrowed`
  ADD PRIMARY KEY (`borrowID`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brandID`);

--
-- Indexes for table `directors`
--
ALTER TABLE `directors`
  ADD PRIMARY KEY (`directorID`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`fineID`);

--
-- Indexes for table `holds`
--
ALTER TABLE `holds`
  ADD PRIMARY KEY (`holdID`);

--
-- Indexes for table `moviecopy`
--
ALTER TABLE `moviecopy`
  ADD PRIMARY KEY (`movieCopyID`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`movieID`);

--
-- Indexes for table `tech`
--
ALTER TABLE `tech`
  ADD PRIMARY KEY (`techID`);

--
-- Indexes for table `techcopy`
--
ALTER TABLE `techcopy`
  ADD PRIMARY KEY (`techCopyID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- Indexes for table `writtenby`
--
ALTER TABLE `writtenby`
  ADD PRIMARY KEY (`writtenByID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alerts`
--
ALTER TABLE `alerts`
  MODIFY `alertID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `authorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `bookcopy`
--
ALTER TABLE `bookcopy`
  MODIFY `bookCopyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `bookID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `borrowed`
--
ALTER TABLE `borrowed`
  MODIFY `borrowID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brandID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `directors`
--
ALTER TABLE `directors`
  MODIFY `directorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `fineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `holds`
--
ALTER TABLE `holds`
  MODIFY `holdID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `moviecopy`
--
ALTER TABLE `moviecopy`
  MODIFY `movieCopyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `movieID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `tech`
--
ALTER TABLE `tech`
  MODIFY `techID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `techcopy`
--
ALTER TABLE `techcopy`
  MODIFY `techCopyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `writtenby`
--
ALTER TABLE `writtenby`
  MODIFY `writtenByID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`id21484403_root`@`%` EVENT `generate_fines_event` ON SCHEDULE EVERY 10 MINUTE STARTS '2023-10-31 18:00:31' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Check for overdue items and generate fines
    INSERT INTO fines (borrowID, userID, fineAmount, type)
    SELECT b.borrowID, b.userID, DATEDIFF(NOW(), b.dueDate) * 1.00, b.itemType
    FROM borrowed b
    WHERE NOW() > b.dueDate
    AND NOT EXISTS (
        SELECT 1
        FROM fines f
        WHERE f.borrowID = b.borrowID AND f.userID = b.userID
    );
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
