/*
 Navicat Premium Data Transfer

 Source Server         : localdb
 Source Server Type    : MySQL
 Source Server Version : 50620
 Source Host           : localhost
 Source Database       : cidb

 Target Server Type    : MySQL
 Target Server Version : 50620
 File Encoding         : utf-8

 Date: 09/02/2014 15:24:13 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `appointments`
-- ----------------------------
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `atype` smallint(6) NOT NULL DEFAULT '0' COMMENT '预约类型',
  `acode` varchar(11) DEFAULT NULL COMMENT '预约编号',
  `client` int(11) DEFAULT NULL,
  `rtime` datetime DEFAULT NULL COMMENT '申请时间',
  `content` varchar(256) DEFAULT NULL,
  `ptime` datetime DEFAULT NULL COMMENT '计划时间',
  `status` smallint(6) DEFAULT NULL,
  `carnumber` varchar(15) DEFAULT NULL,
  `shop` int(11) DEFAULT NULL,
  `descp` varchar(128) DEFAULT NULL,
  `edit_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `car_aptms`
-- ----------------------------
DROP TABLE IF EXISTS `car_aptms`;
CREATE TABLE `car_aptms` (
  `aid` int(11) DEFAULT NULL,
  `acode` varchar(15) DEFAULT NULL,
  `client` int(11) DEFAULT NULL,
  `client_name` varchar(255) DEFAULT NULL,
  `car` int(11) DEFAULT NULL,
  `carnumber` varchar(20) DEFAULT NULL,
  `shop` int(11) DEFAULT NULL,
  `shop_name` varchar(20) DEFAULT NULL,
  UNIQUE KEY `idx_code` (`acode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `carmodels`
-- ----------------------------
DROP TABLE IF EXISTS `carmodels`;
CREATE TABLE `carmodels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(20) DEFAULT NULL,
  `manufacturer` varchar(20) DEFAULT NULL,
  `ctype` varchar(10) DEFAULT NULL,
  `mcode` varchar(20) DEFAULT NULL,
  `mname` varchar(20) DEFAULT NULL,
  `desc` varchar(128) DEFAULT NULL,
  `manudate` varchar(10) DEFAULT NULL,
  `structure` varchar(20) DEFAULT NULL,
  `config` varchar(100) DEFAULT NULL,
  `dimension` varchar(30) DEFAULT NULL,
  `emodel` varchar(255) DEFAULT NULL,
  `engine` varchar(255) DEFAULT NULL,
  `engine_url` int(11) DEFAULT NULL COMMENT '里程数',
  `drive` varchar(10) DEFAULT NULL,
  `gear` varchar(255) DEFAULT NULL,
  `tire` varchar(20) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `config_url` varchar(100) DEFAULT NULL,
  `edit_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `carmodels`
-- ----------------------------
BEGIN;
INSERT INTO `carmodels` VALUES ('1', '蒙迪欧', '长安福特', 'B', 'CA07408', '自动经典型', null, '200612', '553', null, '4810-1800-1450-2754-1435', 'CAF488Q1', 'L6-2.0-143-185', '139087', 'FF', 'AT-4', '205-70-R18-88-H', '墨绿', 'http://www.xgo.com.cn/2650/2006/items.html', null), ('2', '雨燕', '长安铃木', 'A0', 'CA09987', '手动基本型', null, '200907', '552', null, '3765-1690-1510-2390-1040', '4A91', 'L4-1.3-67-115', '65700', 'FF', 'MT-5', '195-65-R15-88-H', '蓝', 'http://newcar.xcar.com.cn/176/2013/', null), ('3', '雅阁A', '广州本田', 'B', 'GB-74532', '自动豪华型', null, null, null, null, null, null, null, null, null, null, null, null, null, '2014-08-21 15:53:24');
COMMIT;

-- ----------------------------
--  Table structure for `cars`
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carnumber` varchar(20) NOT NULL DEFAULT '',
  `brand` varchar(20) DEFAULT NULL,
  `ctype` varchar(10) DEFAULT NULL,
  `modelname` varchar(20) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `descp` varchar(128) DEFAULT NULL,
  `manufacturer` varchar(20) DEFAULT NULL,
  `manudate` varchar(10) DEFAULT NULL,
  `structure` varchar(20) DEFAULT NULL,
  `config` varchar(100) DEFAULT NULL,
  `dimension` varchar(30) DEFAULT NULL,
  `engine` varchar(255) DEFAULT NULL,
  `emodel` varchar(255) DEFAULT NULL,
  `drive` varchar(10) DEFAULT NULL,
  `gear` varchar(255) DEFAULT NULL,
  `tire` varchar(20) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `mileage` int(11) DEFAULT NULL COMMENT '里程数',
  `config_url` varchar(100) DEFAULT NULL,
  `edit_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `submodel` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`carnumber`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `cars`
-- ----------------------------
BEGIN;
INSERT INTO `cars` VALUES ('1', '川A-BQ498', '蒙迪欧', 'B', '自动经典型', 'CA07408', null, '长安福特', '200612', '553', null, '4810-1800-1450-2754-1435', 'L6-2.0-143-185', 'CAF488Q1', 'FF', 'AT-4', '205-70-R18-88-H', '墨绿', '139087', 'http://www.xgo.com.cn/2650/2006/items.html', null, null), ('2', '川A-A1574', '雨燕', 'A0', '手动基本型', 'CA09987', null, '长安铃木', '200907', '552', null, '3765-1690-1510-2390-1040', 'L4-1.3-67-115', '4A91', 'FF', 'MT-5', '195-65-R15-88-H', '蓝', '65700', 'http://newcar.xcar.com.cn/176/2013/', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `ci_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `ci_sessions`
-- ----------------------------
BEGIN;
INSERT INTO `ci_sessions` VALUES ('22426aa7691bbb94a86234fcfe3a32d6', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.8 (KHTML, like Gecko) Version/8.0 Safari/600.1.8', '1409636499', 'a:2:{s:9:\"user_data\";s:0:\"\";s:9:\"logged_in\";a:4:{s:2:\"id\";s:1:\"1\";s:5:\"login\";s:5:\"yanjh\";s:4:\"role\";s:3:\"100\";s:4:\"name\";s:9:\"颜建华\";}}'), ('3803a0eab3d49737f9483a5b68a8094a', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1409641795', ''), ('44190270177c07872c77b6bd5d3431db', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36', '1409636901', ''), ('584ecfb34c2ba7cd9c1c90a42d7e4340', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1409641643', ''), ('5cb5c11c6f75975c033dde7c44bfb943', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36', '1409636905', ''), ('78c3133c90802faef60d581d37ced228', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1409640434', ''), ('9bf2ad658a2b24a521341e5aa471f017', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/13.3.0', '1409587804', ''), ('9f56bc3d8c62195b6bf78bd5ebe5c671', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1409640434', ''), ('cddf2085e599a38bcf641fbb99fe8550', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/13.3.0', '1409580887', ''), ('e33d8b00db2fe3366fd4380d2af6e31a', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.8 (KHTML, like Gecko) Version/8.0 Safari/600.1.8', '1409622460', ''), ('f5c58d2739b63998287abdd2cf29778b', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1409638616', '');
COMMIT;

-- ----------------------------
--  Table structure for `clients`
-- ----------------------------
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ctype` tinyint(4) DEFAULT NULL COMMENT '客户类型',
  `login` varchar(20) DEFAULT NULL,
  `passwd` varchar(100) DEFAULT NULL,
  `deviceid` varchar(20) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `contact` varchar(128) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `wechat` varchar(20) DEFAULT NULL COMMENT '微信号/QQ/微博',
  `desc` varchar(255) DEFAULT NULL,
  `level` tinyint(4) DEFAULT '0' COMMENT '客户级别',
  `edit_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `login_at` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `clients`
-- ----------------------------
BEGIN;
INSERT INTO `clients` VALUES ('1', null, 'shixc', 'a5b09e5b217127812c3f0e778dd1098404ce1fd4', null, '施磊', null, null, '18602802121', 'X_shileixc', null, '1', '2014-08-14 16:04:33', null, null), ('2', null, 'yanjh', null, null, '颜建华', null, null, '13808077242', 'X_hahar006', null, '0', null, null, null), ('4', null, null, null, null, '周琪', null, null, '13880735908', 'Q8990099', null, '0', null, null, null), ('10', null, null, null, null, '陶莉', null, null, '13882189728', 'Q89960707', null, '0', '2014-08-15 15:21:08', null, null), ('11', null, '13908077242', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '8C1AF92C-CDBC-4791-B', null, null, null, '13908077242', null, null, '0', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `dic`
-- ----------------------------
DROP TABLE IF EXISTS `dic`;
CREATE TABLE `dic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dtype` smallint(6) DEFAULT NULL,
  `did` smallint(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sdesc` varchar(10) DEFAULT NULL,
  `sname` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `did` (`dtype`,`did`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `dic`
-- ----------------------------
BEGIN;
INSERT INTO `dic` VALUES ('1', '1', '0', '乘用车辆类型', null, null), ('2', '2', '0', '变速箱类型', null, null), ('3', '1', '1', 'A00-微型车', null, null), ('4', '1', '2', 'A0-小型车', '小型车', 'A0'), ('5', '1', '3', 'A-紧凑级', null, 'A'), ('6', '1', '4', 'B-中级车', null, 'B'), ('7', '1', '5', 'C-豪华级', null, 'C'), ('8', '1', '6', 'D-大型豪华级', null, 'D'), ('9', '1', '7', 'S0-小型SUV', null, 'S0'), ('10', '1', '8', 'SA-紧凑型SUV', '紧凑型SUV', 'SA'), ('11', '1', '9', 'MPV', '商务车', 'MPV'), ('12', '1', '100', '其他', null, null), ('13', '2', '1', 'MT4-4速手动', null, null), ('14', '2', '2', 'MT5-5速手动', null, null), ('15', '2', '3', 'MT6-6速手动', null, null), ('16', '2', '4', 'AT4-4速自动', null, null), ('17', '2', '5', 'AT5-5速自动', null, null), ('18', '2', '6', 'AT6-6速自动', null, null), ('19', '2', '7', 'CVT', null, null), ('20', '2', '8', 'DT', null, null), ('21', '3', '0', '车身结构', null, null), ('22', '1', '20', 'SB-中型SUV', null, 'SB'), ('23', '1', '21', 'SF-大型SUV', null, 'SF'), ('24', '1', '22', 'SC-跑车', null, 'SC'), ('25', '1', '23', 'SSC-超级跑车', null, 'SSC'), ('26', '3', '1', '552-5门5座2箱', null, null), ('27', '3', '2', '552-5门5座3箱', null, null), ('28', '3', '3', '553-3门5座2箱', null, null), ('29', '4', '0', '驱动形式', null, null), ('30', '4', '1', 'FF-前置前驱', null, null), ('31', '4', '2', 'FR-前置后驱', null, null), ('32', '4', '3', 'F4-前置四驱', null, null), ('33', '4', '4', 'RR-后置后驱', null, null), ('34', '4', '5', 'MR-中置后驱', null, null), ('35', '4', '6', 'M4-中置四驱', null, null), ('36', '2', '100', '其他', null, null), ('37', '3', '100', null, null, null), ('38', '4', '100', null, null, null), ('40', '5', '0', '预约和服务状态', null, null), ('41', '5', '100', null, null, null), ('42', '6', '0', '客户类型', null, null), ('43', '6', '100', null, null, null), ('44', '5', '1', '客户预约', null, null), ('45', '5', '2', '预约确认', null, null), ('46', '5', '10', '预约完成', null, null), ('47', '5', '11', '预约取消', null, null), ('48', '5', '3', '服务进行中', null, null), ('49', '7', '0', '客户账号状态', null, null), ('50', '7', '100', null, null, null), ('51', '7', '50', '正常', null, null), ('52', '7', '1', '未激活', null, null), ('53', '7', '2', '验证中', null, null), ('54', '7', '10', '已禁用', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `links`
-- ----------------------------
DROP TABLE IF EXISTS `links`;
CREATE TABLE `links` (
  `ltype` smallint(6) NOT NULL DEFAULT '0',
  `lid` int(11) NOT NULL DEFAULT '0',
  `lname` varchar(20) DEFAULT NULL,
  `rid` int(11) NOT NULL DEFAULT '0',
  `rname` varchar(20) DEFAULT NULL,
  `lorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`ltype`,`lid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `links`
-- ----------------------------
BEGIN;
INSERT INTO `links` VALUES ('1', '2', '颜建华', '2', '川A-A1574', null), ('1', '10', '陶莉', '1', '川A-BQ498', null), ('1', '10', '陶莉', '2', '川A-A1574', null), ('2', '1', '', '4', '更换轮胎', null), ('2', '1', '', '5', '常规检查', null), ('2', '1', '', '8', 'A0级日常保养', null), ('2', '2', '', '3', '更换发动机油滤', null), ('2', '2', '', '6', '高级检查', null), ('2', '3', '', '3', '更换发动机油滤', null), ('2', '3', '', '4', '更换轮胎', null), ('2', '3', '', '7', '更换空气滤清器', null), ('2', '5', '', '1', '洗车-小型', null), ('2', '5', '', '4', '更换轮胎', null);
COMMIT;

-- ----------------------------
--  Table structure for `news`
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `slug` varchar(128) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `schools`
-- ----------------------------
DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0',
  `utype` tinyint(4) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `gyear` smallint(6) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `descp` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `shops`
-- ----------------------------
DROP TABLE IF EXISTS `shops`;
CREATE TABLE `shops` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `scode` varchar(8) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `geoaddress` varchar(100) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `sclass` char(50) DEFAULT 'A',
  PRIMARY KEY (`id`),
  KEY `idx_code` (`scode`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `shops`
-- ----------------------------
BEGIN;
INSERT INTO `shops` VALUES ('1', 'CDS001', '天府新区旗舰店', '天府软件园', '104.073938889,30.55955278\nN30.55955278,', '028-86000998', null, 'F'), ('2', 'CDN002', '火车北站店', '北站1路12号', null, '028-86000998', null, 'A'), ('3', 'CDS002', '火车南站店', '火车南站', null, '87676999', null, 'B'), ('4', 'CDE001', '川师大店', '川师大南门', null, '13809998789', null, 'A'), ('5', 'CDW002', '西门车站店', '西门车站', null, '13809987654', null, 'A');
COMMIT;

-- ----------------------------
--  Table structure for `students`
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` varchar(8) DEFAULT NULL,
  `sclass` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `bdate` varchar(8) DEFAULT NULL,
  `gender` tinyint(4) DEFAULT '0',
  `descp` varchar(128) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `taskgroups`
-- ----------------------------
DROP TABLE IF EXISTS `taskgroups`;
CREATE TABLE `taskgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `descp` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `taskgroups`
-- ----------------------------
BEGIN;
INSERT INTO `taskgroups` VALUES ('1', 'A0普通日常保养', 'OK'), ('2', 'B级日常保养', '普通B级车'), ('3', 'A级日常保养', 'A级'), ('5', '美容套餐A', '精细洗车\n车标\n贴膜'), ('6', '底盘检修B', '底盘和悬挂系统检查，胎压和胎况检查'), ('11', '美容套餐B', '针对B级车，包括洗车，打蜡，车身检查');
COMMIT;

-- ----------------------------
--  Table structure for `tasktypes`
-- ----------------------------
DROP TABLE IF EXISTS `tasktypes`;
CREATE TABLE `tasktypes` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tcode` varchar(10) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  `duration1` int(4) DEFAULT '0' COMMENT '按日期计算的任务间隔',
  `duration2` int(6) DEFAULT '0' COMMENT '按里程计算的任务间隔',
  `price` int(11) DEFAULT NULL,
  `tasktime` smallint(6) DEFAULT NULL,
  `taskprice` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tasktypes`
-- ----------------------------
BEGIN;
INSERT INTO `tasktypes` VALUES ('1', 'W001', '洗车-小型', null, '15', '2000', null, '30', '20'), ('2', 'W002', '洗车-中大型', null, '20', '1000', null, '40', '30'), ('3', 'T101', '更换发动机油滤', null, '60', '6000', null, null, null), ('4', 'T201', '更换轮胎', null, '127', '32767', null, null, null), ('5', 'C001', '常规检查', null, '0', '0', null, null, null), ('6', 'C002', '高级检查', null, '0', '0', null, null, null), ('7', 'M008', '更换空气滤清器', null, '30', '5000', null, '30', '80'), ('8', 'M002', 'A0级日常保养', null, '60', '5000', null, '120', '150'), ('9', 'B003', '贴膜', null, '0', '0', null, '45', '100'), ('11', 'D2', '什么名字', null, '30', '5000', null, '45', '100'), ('15', 'F003', '轮胎检查', null, '180', '15000', null, '30', '100');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `login` varchar(16) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `passwd` varchar(100) DEFAULT NULL,
  `desc` varchar(256) DEFAULT NULL,
  `role` tinyint(4) NOT NULL DEFAULT '0',
  `shop` int(11) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'yanjh', '颜建华', '8db1b26f628cddbccb4df5f4530bf853fdca99ea', null, '100', '1', '13808077242', null, ''), ('2', 'admin', '管理员', 'f342a7cf3fb38d37dc8a2f6d34f6957569195948', null, '100', '2', '133', null, ''), ('3', 'shixc', '施磊', '7e8b8c0eaa636c59c029f5b9b5e1543f6f4117e6', null, '0', '4', '13980992121', null, '人民南路');
COMMIT;

-- ----------------------------
--  Table structure for `zm_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `zm_sessions`;
CREATE TABLE `zm_sessions` (
  `session_type` tinyint(4) DEFAULT '0' COMMENT 'session类型，用于不同的系统和应用',
  `session_id` varchar(56) NOT NULL COMMENT 'sha1(时间)+ip(aaaaaaaa)',
  `client_id` varchar(20) DEFAULT NULL,
  `stime` datetime DEFAULT NULL,
  `device_id` varchar(40) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `zm_sessions`
-- ----------------------------
BEGIN;
INSERT INTO `zm_sessions` VALUES ('0', '2d2d763917352e6af02a07abc19a8ebef20c34f17f000001', 'shixc', '2014-08-14 09:55:30', 'bbb', null), ('2', '8fe11966741cee825ffede84a104d026c47b36ca7f000001', '13908077242', '2015-09-01 23:12:57', '8C1AF92C-CDBC-4791-BA37-761F576108FF', null);
COMMIT;

-- ----------------------------
--  Table structure for `zm_versions`
-- ----------------------------
DROP TABLE IF EXISTS `zm_versions`;
CREATE TABLE `zm_versions` (
  `vkey` varchar(20) NOT NULL DEFAULT '',
  `vvalue` int(11) DEFAULT '0',
  PRIMARY KEY (`vkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `zm_versions`
-- ----------------------------
BEGIN;
INSERT INTO `zm_versions` VALUES ('shop_version', '5');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
