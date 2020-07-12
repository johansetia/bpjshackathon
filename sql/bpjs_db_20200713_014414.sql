-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- CREATE DATABASE "bpjs_db" -------------------------------
CREATE DATABASE IF NOT EXISTS `bpjs_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bpjs_db`;
-- ---------------------------------------------------------


-- CREATE TABLE "analysis" -------------------------------------
CREATE TABLE `analysis` ( 
	`idanalysis` Int( 10 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`main_bpjs_number` VarChar( 15 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`provinsi` VarChar( 50 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`salary_grade` Enum( 'A', 'B', 'C', 'D', 'E', 'F' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'F = 1jt-2jt
E = 2jt-3jt
D = 3jt-4jt
C = 4jt-5jt
B = 5jt-10jt
A = >10jt',
	`kelas` Enum( '1', '2', '3' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`work` Enum( 'PENSIUN', 'NEGERI', 'SWASTA' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`total_menunggak` Int( 10 ) NOT NULL DEFAULT 0,
	`overlap` Enum( '1', '0' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '1 = tidak menerima rekomendasi
0 = menerima rekomendasi',
	`level` Enum( 'LOW', 'MEDIUM', 'HARD', 'FREEZE' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	PRIMARY KEY ( `idanalysis` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB
AUTO_INCREMENT = 150;
-- -------------------------------------------------------------


-- CREATE TABLE "billing_payment" ------------------------------
CREATE TABLE `billing_payment` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`nama` VarChar( 100 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
	`mainBilllingNumber` VarChar( 100 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
	`transactionId` VarChar( 100 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
	`billAmount` Double( 22, 0 ) NOT NULL DEFAULT 0,
	`periode` VarChar( 9 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
	`biayaAdmin` Double( 22, 0 ) NULL,
	`paymentDate` DateTime NULL,
	`status` Enum( '0', '1', '2' ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT '0 = pending, 1 = success, 2 = failed',
	`retryCount` TinyInt( 2 ) NOT NULL DEFAULT 0,
	`createdDate` DateTime NULL,
	`updatedDate` Timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY ( `id`, `mainBilllingNumber` ) )
CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "fingerprint" ----------------------------------
CREATE TABLE `fingerprint` ( 
	`id` Int( 11 ) NOT NULL,
	`bpjs_number` VarChar( 45 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
	`finger_id` VarChar( 9999 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`mainBilllingNumber` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`billingNumber` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`kelas` VarChar( 2 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`nama` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	PRIMARY KEY ( `billingNumber` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "gamification" ---------------------------------
CREATE TABLE `gamification` ( 
	`id` Int( 10 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`bpjs_number` VarChar( 45 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`status` Enum( 'IN', 'OUT' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`amount` Int( 11 ) NOT NULL,
	`title` VarChar( 50 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`note` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
	`created_at` DateTime NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "payment_log" ----------------------------------
CREATE TABLE `payment_log` ( 
	`mainBilllingNumber` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`jumlahTagihan` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`jumlahBulanTagihan` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`nama` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`nomorReferensi` VarChar( 99 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`payment_date` DateTime NOT NULL,
	PRIMARY KEY ( `mainBilllingNumber` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "reasoning_report" -----------------------------
CREATE TABLE `reasoning_report` ( 
	`id` Int( 10 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`bpjs_number` VarChar( 45 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`reason` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`freeze_accept` Enum( '1', '0' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`created_at` DateTime NOT NULL,
	PRIMARY KEY ( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB
AUTO_INCREMENT = 1;
-- -------------------------------------------------------------


-- CREATE TABLE "ref_error_codes" ------------------------------
CREATE TABLE `ref_error_codes` ( 
	`code` Char( 3 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT 'Error codes',
	`message` VarChar( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'Message of error',
	`messageID` VarChar( 255 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
	`description` Text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL COMMENT 'Description',
	`created_date` DateTime NULL,
	`created_by` Int( 11 ) NOT NULL DEFAULT 1,
	`updated_date` Timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`updated_by` Int( 11 ) NOT NULL DEFAULT 1,
	PRIMARY KEY ( `code` ) )
CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
ENGINE = InnoDB;
-- -------------------------------------------------------------


-- CREATE TABLE "user" -----------------------------------------
CREATE TABLE `user` ( 
	`id` Int( 10 ) UNSIGNED AUTO_INCREMENT NOT NULL,
	`finger_id` VarChar( 9999 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`main_bpjs_number` VarChar( 15 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`bpjs_number` VarChar( 15 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`first_name` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`last_name` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
	`picture` VarChar( 100 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
	`kelas` Enum( '1', '2', '3' ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`phone` VarChar( 15 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`salary` VarChar( 45 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
	`username` VarChar( 200 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`password` VarChar( 200 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`join_date` DateTime NOT NULL,
	`point` Int( 11 ) NOT NULL DEFAULT 0,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `bpjs_number_UNIQUE` UNIQUE( `bpjs_number` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB
AUTO_INCREMENT = 3;
-- -------------------------------------------------------------


-- Dump data of "analysis" ---------------------------------
INSERT INTO `analysis`(`idanalysis`,`main_bpjs_number`,`provinsi`,`salary_grade`,`kelas`,`work`,`total_menunggak`,`overlap`,`level`) VALUES 
( '1', '1', 'DIY', 'D', '1', 'NEGERI', '0', '0', 'LOW' ),
( '2', '2', 'JATENG', 'E', '2', 'SWASTA', '4', '1', 'LOW' ),
( '3', '3', 'JATIM', 'D', '1', 'SWASTA', '5', '1', 'MEDIUM' ),
( '4', '4', 'SUMBAR', 'E', '3', 'SWASTA', '10', '0', 'FREEZE' ),
( '5', '5', 'SUMUT', 'D', '1', 'PENSIUN', '6', '1', 'MEDIUM' ),
( '6', '6', 'JATIM', 'D', '1', 'PENSIUN', '6', '1', 'MEDIUM' ),
( '7', '7', 'JATIM', 'D', '1', 'PENSIUN', '2', '1', 'LOW' ),
( '8', '8', 'JABAR', 'A', '1', 'PENSIUN', '0', '0', 'LOW' ),
( '9', '9', 'BANTEN', 'B', '1', 'NEGERI', '2', '1', 'LOW' ),
( '10', '10', 'DIY', 'C', '3', 'SWASTA', '4', '0', 'MEDIUM' ),
( '11', '11', 'DIY', 'D', '2', 'SWASTA', '2', '1', 'LOW' ),
( '12', '12', 'JABAR', 'E', '3', 'SWASTA', '4', '0', 'MEDIUM' ),
( '13', '13', 'SUMBAR', 'F', '3', 'SWASTA', '2', '1', 'LOW' ),
( '14', '15', 'SUMUT', 'A', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '15', '16', 'SUMSEL', 'B', '1', 'SWASTA', '2', '1', 'LOW' ),
( '16', '17', 'DIY', 'C', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '17', '18', 'DIY', 'D', '1', 'SWASTA', '2', '1', 'LOW' ),
( '18', '19', 'DKI', 'A', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '19', '20', 'JATIM', 'B', '1', 'SWASTA', '2', '1', 'LOW' ),
( '20', '14', 'JABAR', 'C', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '21', '15', 'JATENG', 'D', '1', 'SWASTA', '2', '1', 'LOW' ),
( '22', '16', 'JATENG', 'A', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '23', '17', 'DIY', 'B', '1', 'SWASTA', '2', '1', 'LOW' ),
( '24', '18', 'DIY', 'C', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '25', '19', 'DIY', 'D', '1', 'SWASTA', '2', '1', 'LOW' ),
( '26', '20', 'JATIM', 'A', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '27', '21', 'JABAR', 'C', '1', 'SWASTA', '2', '1', 'LOW' ),
( '28', '22', 'JABAR', 'C', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '29', '23', 'JATIM', 'C', '1', 'SWASTA', '2', '1', 'LOW' ),
( '30', '24', 'BANTEN', 'C', '1', 'SWASTA', '3', '0', 'MEDIUM' ),
( '31', '25', 'BANTEN', 'E', '1', 'SWASTA', '2', '1', 'LOW' ),
( '32', '26', 'DIY', 'E', '2', 'SWASTA', '5', '0', 'MEDIUM' ),
( '33', '27', 'DIY', 'E', '2', 'SWASTA', '2', '1', 'LOW' ),
( '34', '28', 'DIY', 'C', '1', 'SWASTA', '4', '0', 'MEDIUM' ),
( '35', '29', 'DKI', 'B', '1', 'PENSIUN', '2', '1', 'LOW' ),
( '36', '30', 'DKI', 'B', '1', 'PENSIUN', '4', '1', 'MEDIUM' ),
( '37', '31', 'JABAR', 'C', '2', 'SWASTA', '0', '1', 'LOW' ),
( '38', '32', 'DKI', 'C', '2', 'SWASTA', '4', '1', 'MEDIUM' ),
( '39', '33', 'JABAR', 'C', '3', 'SWASTA', '0', '1', 'LOW' ),
( '40', '34', 'JATIM', 'C', '2', 'PENSIUN', '0', '0', 'LOW' ),
( '41', '35', 'BANTEN', 'C', '1', 'NEGERI', '0', '1', 'LOW' ),
( '42', '36', 'DKI', 'B', '2', 'SWASTA', '0', '0', 'LOW' ),
( '43', '37', 'SUMBAR', 'C', '2', 'SWASTA', '0', '0', 'LOW' ),
( '44', '38', 'SUMSEL', 'B', '1', 'PENSIUN', '0', '0', 'LOW' ),
( '45', '39', 'SUMUT', 'B', '1', 'PENSIUN', '0', '0', 'LOW' ),
( '46', '40', 'JABAR', 'B', '1', 'SWASTA', '0', '1', 'LOW' ),
( '47', '1', 'JATIM', 'C', '2', 'PENSIUN', '0', '1', 'LOW' ),
( '48', '1', 'BANTEN', 'C', '1', 'SWASTA', '1', '1', 'LOW' ),
( '49', '1', 'DKI', 'B', '1', 'SWASTA', '0', '0', 'LOW' ),
( '50', '1', 'SUMBAR', 'C', '1', 'SWASTA', '0', '0', 'LOW' ),
( '51', '1', 'SUMSEL', 'B', '1', 'PENSIUN', '0', '0', 'LOW' ),
( '52', '1', 'SUMUT', 'A', '1', 'PENSIUN', '1', '1', 'LOW' ),
( '53', '1', 'JABAR', 'A', '1', 'NEGERI', '2', '1', 'LOW' ),
( '54', '1', 'JATIM', 'C', '2', 'PENSIUN', '0', '1', 'LOW' ),
( '55', '1', 'BANTEN', 'C', '1', 'SWASTA', '1', '1', 'LOW' ),
( '56', '1', 'DKI', 'B', '1', 'SWASTA', '0', '0', 'LOW' ),
( '57', '1', 'SUMBAR', 'B', '1', 'SWASTA', '1', '1', 'LOW' ),
( '58', '1', 'SUMSEL', 'A', '1', 'PENSIUN', '0', '0', 'LOW' ),
( '59', '1', 'SUMUT', 'A', '1', 'PENSIUN', '1', '1', 'LOW' ),
( '60', '1', 'JABAR', 'A', '1', 'NEGERI', '4', '1', 'MEDIUM' ),
( '61', '1', 'JATIM', 'C', '2', 'PENSIUN', '5', '1', 'MEDIUM' ),
( '62', '1', 'BANTEN', 'C', '1', 'SWASTA', '5', '1', 'MEDIUM' ),
( '63', '1', 'JABAR', 'B', '1', 'NEGERI', '8', '1', 'HARD' ),
( '64', '1', 'JATIM', 'C', '2', 'PENSIUN', '7', '1', 'HARD' ),
( '65', '1', 'BANTEN', 'C', '1', 'SWASTA', '7', '1', 'HARD' ),
( '66', '1', 'JABAR', 'C', '2', 'NEGERI', '7', '1', 'FREEZE' ),
( '67', '1', 'JATIM', 'C', '2', 'PENSIUN', '7', '1', 'FREEZE' ),
( '68', '1', 'BANTEN', 'C', '1', 'SWASTA', '9', '1', 'FREEZE' ),
( '69', '1', 'DKI', 'B', '1', 'SWASTA', '7', '1', 'FREEZE' ),
( '70', '1', 'SUMBAR', 'B', '1', 'SWASTA', '6', '1', 'FREEZE' ),
( '71', '1', 'SUMSEL', 'B', '1', 'PENSIUN', '8', '0', 'FREEZE' ),
( '72', '1', 'SUMUT', 'C', '1', 'PENSIUN', '7', '1', 'FREEZE' ),
( '73', '1', 'DIY', 'F', '2', 'PENSIUN', '8', '1', 'FREEZE' ),
( '74', '1', 'JABAR', 'B', '2', 'PENSIUN', '7', '1', 'HARD' ),
( '75', '1', 'JATIM', 'C', '2', 'PENSIUN', '7', '1', 'HARD' ),
( '76', '1', 'BANTEN', 'C', '2', 'PENSIUN', '9', '1', 'HARD' ),
( '77', '1', 'DKI', 'B', '2', 'PENSIUN', '7', '1', 'HARD' ),
( '78', '1', 'SUMBAR', 'B', '2', 'PENSIUN', '6', '1', 'HARD' ),
( '79', '1', 'SUMSEL', 'B', '2', 'PENSIUN', '8', '0', 'HARD' ),
( '80', '1', 'SUMUT', 'C', '2', 'PENSIUN', '7', '1', 'HARD' ),
( '81', '1', 'DIY', 'F', '2', 'PENSIUN', '8', '1', 'HARD' ),
( '82', '1', 'JABAR', 'C', '3', 'PENSIUN', '1', '0', 'LOW' ),
( '83', '1', 'JATIM', 'C', '3', 'PENSIUN', '0', '1', 'LOW' ),
( '84', '1', 'BANTEN', 'C', '3', 'PENSIUN', '2', '0', 'LOW' ),
( '85', '1', 'DKI', 'C', '3', 'PENSIUN', '3', '1', 'LOW' ),
( '86', '1', 'SUMBAR', 'C', '3', 'PENSIUN', '1', '1', 'LOW' ),
( '87', '1', 'SUMSEL', 'C', '3', 'PENSIUN', '2', '0', 'LOW' ),
( '88', '1', 'SUMUT', 'C', '3', 'PENSIUN', '3', '1', 'LOW' ),
( '89', '1', 'DIY', 'E', '2', 'PENSIUN', '1', '1', 'LOW' ),
( '90', '1', 'JABAR', 'A', '3', 'SWASTA', '1', '0', 'LOW' ),
( '91', '1', 'JATIM', 'A', '3', 'SWASTA', '0', '1', 'LOW' ),
( '92', '1', 'BANTEN', 'A', '3', 'SWASTA', '2', '0', 'LOW' ),
( '93', '1', 'DKI', 'A', '3', 'PENSIUN', '3', '1', 'LOW' ),
( '94', '1', 'SUMBAR', 'A', '3', 'NEGERI', '1', '1', 'LOW' ),
( '95', '1', 'SUMSEL', 'A', '3', 'NEGERI', '2', '0', 'LOW' ),
( '96', '1', 'SUMUT', 'A', '3', 'NEGERI', '3', '1', 'LOW' ),
( '97', '1', 'DIY', 'A', '2', 'PENSIUN', '1', '1', 'LOW' ),
( '98', '1', 'JABAR', 'A', '3', 'SWASTA', '6', '0', 'MEDIUM' ),
( '99', '1', 'JATIM', 'A', '3', 'SWASTA', '6', '1', 'MEDIUM' ),
( '100', '1', 'BANTEN', 'A', '3', 'SWASTA', '7', '0', 'MEDIUM' ),
( '101', '1', 'DKI', 'A', '3', 'PENSIUN', '7', '1', 'MEDIUM' ),
( '102', '1', 'SUMBAR', 'A', '3', 'NEGERI', '8', '1', 'MEDIUM' ),
( '103', '1', 'SUMSEL', 'A', '3', 'NEGERI', '8', '0', 'MEDIUM' ),
( '104', '1', 'SUMUT', 'A', '3', 'NEGERI', '5', '1', 'MEDIUM' ),
( '105', '1', 'DIY', 'A', '2', 'PENSIUN', '9', '1', 'MEDIUM' ),
( '106', '1', 'JABAR', 'B', '3', 'SWASTA', '6', '0', 'MEDIUM' ),
( '107', '1', 'JATIM', 'B', '3', 'SWASTA', '6', '1', 'MEDIUM' ),
( '108', '1', 'BANTEN', 'B', '3', 'SWASTA', '6', '0', 'MEDIUM' ),
( '109', '1', 'DKI', 'B', '3', 'PENSIUN', '6', '1', 'MEDIUM' ),
( '110', '1', 'SUMBAR', 'B', '3', 'NEGERI', '7', '1', 'MEDIUM' ),
( '111', '1', 'SUMSEL', 'B', '3', 'NEGERI', '7', '0', 'MEDIUM' ),
( '112', '1', 'SUMUT', 'B', '3', 'NEGERI', '6', '1', 'MEDIUM' ),
( '113', '1', 'DIY', 'B', '2', 'PENSIUN', '5', '1', 'MEDIUM' ),
( '114', '1', 'JABAR', 'A', '3', 'SWASTA', '7', '0', 'HARD' ),
( '115', '1', 'JATIM', 'A', '3', 'SWASTA', '6', '1', 'HARD' ),
( '116', '1', 'BANTEN', 'A', '3', 'SWASTA', '7', '0', 'HARD' ),
( '117', '1', 'DKI', 'A', '3', 'PENSIUN', '7', '1', 'HARD' ),
( '118', '1', 'SUMBAR', 'A', '3', 'NEGERI', '8', '1', 'HARD' ),
( '119', '1', 'SUMSEL', 'A', '3', 'NEGERI', '8', '0', 'HARD' ),
( '120', '1', 'SUMUT', 'A', '3', 'NEGERI', '9', '1', 'HARD' ),
( '121', '1', 'DIY', 'A', '2', 'PENSIUN', '9', '1', 'HARD' ),
( '122', '1', 'JABAR', 'A', '3', 'SWASTA', '3', '0', 'LOW' ),
( '123', '1', 'JATIM', 'A', '3', 'SWASTA', '4', '1', 'LOW' ),
( '124', '1', 'BANTEN', 'A', '3', 'SWASTA', '3', '0', 'LOW' ),
( '125', '1', 'DKI', 'A', '3', 'PENSIUN', '3', '1', 'LOW' ),
( '126', '1', 'SUMBAR', 'A', '3', 'NEGERI', '4', '1', 'LOW' ),
( '127', '1', 'SUMSEL', 'A', '3', 'NEGERI', '3', '0', 'LOW' ),
( '128', '1', 'SUMUT', 'A', '3', 'NEGERI', '1', '1', 'LOW' ),
( '129', '1', 'DIY', 'A', '2', 'PENSIUN', '3', '1', 'LOW' ),
( '130', '1', 'DIY', 'A', '1', 'NEGERI', '0', '0', 'LOW' ),
( '131', '1', 'DIY', 'B', '1', 'NEGERI', '0', '0', 'LOW' ),
( '132', '1', 'DIY', 'C', '1', 'NEGERI', '0', '0', 'LOW' ),
( '133', '1', 'DIY', 'D', '1', 'NEGERI', '0', '0', 'LOW' ),
( '134', '1', 'DIY', 'E', '1', 'NEGERI', '0', '0', 'LOW' ),
( '135', '1', 'DIY', 'B', '1', 'NEGERI', '1', '1', 'LOW' ),
( '136', '1', 'DIY', 'B', '1', 'NEGERI', '2', '1', 'LOW' ),
( '137', '1', 'DIY', 'B', '1', 'NEGERI', '3', '0', 'LOW' ),
( '138', '1', 'DIY', 'D', '1', 'NEGERI', '4', '0', 'LOW' ),
( '139', '1', 'DIY', 'F', '1', 'NEGERI', '5', '1', 'LOW' ),
( '140', '1', 'DIY', 'D', '2', 'NEGERI', '11', '1', 'FREEZE' ),
( '141', '1', 'JATENG', 'D', '2', 'NEGERI', '9', '1', 'FREEZE' ),
( '142', '1', 'JATIM', 'D', '1', 'NEGERI', '8', '0', 'FREEZE' ),
( '143', '1', 'SUMBAR', 'D', '3', 'NEGERI', '10', '0', 'FREEZE' ),
( '144', '1', 'DKI', 'D', '1', 'NEGERI', '10', '1', 'FREEZE' ),
( '145', '1', 'DIY', 'D', '2', 'SWASTA', '11', '1', 'HARD' ),
( '146', '1', 'JATENG', 'D', '2', 'NEGERI', '9', '1', 'HARD' ),
( '147', '1', 'JATIM', 'D', '1', 'SWASTA', '8', '0', 'HARD' ),
( '148', '1', 'SUMBAR', 'D', '3', 'SWASTA', '10', '0', 'HARD' ),
( '149', '1', 'DKI', 'D', '1', 'NEGERI', '10', '1', 'HARD' );
-- ---------------------------------------------------------


-- Dump data of "billing_payment" --------------------------
INSERT INTO `billing_payment`(`id`,`nama`,`mainBilllingNumber`,`transactionId`,`billAmount`,`periode`,`biayaAdmin`,`paymentDate`,`status`,`retryCount`,`createdDate`,`updatedDate`) VALUES 
( '1', 'Andika Ristian Nugraha', '8888801793465998', 'FPLLNGZIEYOH54E1244OLS7K2HH3GDNYXXVI8HVS', '125000', '1', '2500', '2020-06-18 17:42:11', '1', '0', '2020-06-18 17:27:14', '2020-06-18 17:42:11' ),
( '2', 'Andika Ristian Nugraha', '8888801793465998', 'FPLLNGZIEYOH54E1244OLS7K2HH3GDNYXXVI8HVS', '125000', '2', '2500', '2020-06-18 17:42:11', '1', '0', '2020-06-18 17:27:14', '2020-06-18 17:42:11' ),
( '3', 'Andika Ristian Nugraha', '8888801793465998', 'FPLLNGZIEYOH54E1244OLS7K2HH3GDNYXXVI8HVS', '125000', '3', '2500', '2020-06-18 17:42:11', '1', '0', '2020-06-18 17:27:14', '2020-06-18 17:42:11' );
-- ---------------------------------------------------------


-- Dump data of "fingerprint" ------------------------------
INSERT INTO `fingerprint`(`id`,`bpjs_number`,`finger_id`,`mainBilllingNumber`,`billingNumber`,`kelas`,`nama`) VALUES 
( '0', NULL, '555664', '8888801793465998', '8888801793465997', '1', 'Eufrisia Marcheline Arnindhita' ),
( '0', NULL, '555663', '8888801793465998', '8888801793465998', '1', 'Andika Ristian Nugraha' );
-- ---------------------------------------------------------


-- Dump data of "gamification" -----------------------------
-- ---------------------------------------------------------


-- Dump data of "payment_log" ------------------------------
-- ---------------------------------------------------------


-- Dump data of "reasoning_report" -------------------------
-- ---------------------------------------------------------


-- Dump data of "ref_error_codes" --------------------------
INSERT INTO `ref_error_codes`(`code`,`message`,`messageID`,`description`,`created_date`,`created_by`,`updated_date`,`updated_by`) VALUES 
( '001', 'Payment is currently being processed', 'Pembayaran sedang di proses', NULL, '2019-11-21 13:43:22', '1', '2019-11-21 02:33:40', '1' ),
( '100', 'Decrypt Failed', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:25', '1' ),
( '101', 'Invalid Parent Format', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:26', '1' ),
( '102', 'Invalid Child Format', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:27', '1' ),
( '103', 'Data Expired', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:28', '1' ),
( '104', 'Encrypt Failed', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:29', '1' ),
( '105', 'Invalid Hashed Data', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:29', '1' ),
( '106', 'Invalid Encrypted Data', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:30', '1' ),
( '108', 'Invalid Format', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:31', '1' ),
( '109', 'Invalid IP Address', NULL, 'ip address not allowed to use this gateway. 
see ip_whitelist', '2019-11-19 13:43:22', '1', '2019-11-18 23:43:31', '1' ),
( '116', 'Invalid Access Token', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:32', '1' ),
( '117', 'Incorrect Credential', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-19 00:24:22', '1' ),
( '121', 'Payment Failed', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:33', '1' ),
( '122', 'Invalid Amount', 'Invalid Amount', NULL, NULL, '1', '2020-05-10 21:07:21', '1' ),
( '124', 'Number Only', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:34', '1' ),
( '200', 'Success', 'Sukses', NULL, '2019-11-19 13:43:22', '1', '2020-06-20 21:25:55', '1' ),
( '333', 'Response Data cannot be parsed', NULL, 'time limit exceeded to encrypt the data from ecoll', '2019-11-19 13:43:22', '1', '2019-11-18 23:43:34', '1' ),
( '400', 'Bad Request', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:38', '1' ),
( '401', 'Authentication Failed', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:39', '1' ),
( '404', 'No Data', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:39', '1' ),
( '405', 'Not Allowed', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:40', '1' ),
( '422', 'Validation Failed', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:41', '1' ),
( '429', 'Max Request', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:42', '1' ),
( '500', 'Internal Error', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:47', '1' ),
( '600', 'Request Failed', 'Request Failed', NULL, NULL, '1', '2020-05-10 21:07:21', '1' ),
( '606', 'System is under maintenance, please come back later!', 'Sistem sedang dalam meintenance, silahkan coba kembali dalam beberapa saat.', 'Maintenance system', '2019-11-22 13:13:13', '1', '2019-11-21 23:13:13', '1' ),
( '665', 'Invalid Prefix', 'Invalid Prefix', NULL, NULL, '1', '2020-05-07 20:33:18', '1' ),
( '667', 'Invalid Va Type', 'Invalid Va Type', NULL, NULL, '1', '2020-05-10 21:09:02', '1' ),
( '669', 'Va Has Been Paid', NULL, NULL, NULL, '1', '2020-05-10 21:09:02', '1' ),
( '701', 'Biller token service is temporarily unaviailable, please try again later.', NULL, 'Error token from biller', '2019-11-22 13:13:13', '1', '2019-11-28 01:54:32', '1' ),
( '702', 'Biller inquiry service is temporarily unaviailable, please try again later.', NULL, 'Error inquiry from biller', '2019-11-22 13:13:13', '1', '2019-11-28 01:54:35', '1' ),
( '703', 'Biller payment service is temporarily unaviailable, please try again later.', NULL, 'Error payment from biller', '2019-11-22 13:13:13', '1', '2019-11-28 01:54:36', '1' ),
( '704', 'Biller inquiry status service is temporarily unaviailable, please try again later.', NULL, 'Error inquiry status from biller', '2019-11-22 13:13:13', '1', '2019-11-28 01:54:38', '1' ),
( '705', 'Biller force flagging service is temporarily unaviailable, please try again later.', NULL, 'Error manual flagging from biller', '2019-11-22 13:13:13', '1', '2019-11-28 01:54:40', '1' ),
( '802', 'Login Successful', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:48', '1' ),
( '806', 'Payment Successful', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:48', '1' ),
( '807', 'Verification Success', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:49', '1' ),
( '901', 'Invalid Param', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:51', '1' ),
( '999', 'Test', NULL, NULL, '2019-11-19 13:43:22', '1', '2019-11-18 23:43:53', '1' );
-- ---------------------------------------------------------


-- Dump data of "user" -------------------------------------
INSERT INTO `user`(`id`,`finger_id`,`main_bpjs_number`,`bpjs_number`,`first_name`,`last_name`,`picture`,`kelas`,`phone`,`salary`,`username`,`password`,`join_date`,`point`) VALUES 
( '1', '22', '7', '1', 'Johan', 'Setiawan', '/hdsh.jpg', '1', '08132', '4000000', '111', 'deddw', '2018-05-05 00:00:00', '200' ),
( '2', '11', '2', '2', 'Anita', 'Mellani', '/ddd.jpg', '2', '08144', '7000000', '11', 'csdc', '2018-05-05 00:00:00', '150' );
-- ---------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


