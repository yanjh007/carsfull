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

 Date: 09/18/2014 16:49:03 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `appointments`
-- ----------------------------
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `atype` smallint(6) NOT NULL DEFAULT '0' COMMENT '预约类型',
  `acode` varchar(11) DEFAULT NULL COMMENT '预约编号',
  `rtime` datetime DEFAULT NULL COMMENT '提交时间',
  `ptime` datetime DEFAULT NULL COMMENT '计划时间',
  `status` smallint(6) DEFAULT NULL,
  `content` varchar(256) DEFAULT NULL,
  `descp` varchar(128) DEFAULT NULL,
  `edit_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `appointments`
-- ----------------------------
BEGIN;
INSERT INTO `appointments` VALUES ('1', '11', '0', 'A503804134', '2014-09-03 16:00:05', '2014-09-04 11:48:01', '2', null, 'ok', '2014-09-04 15:00:43'), ('2', '11', '0', 'A723804134', '2014-09-03 15:55:52', '2014-09-06 11:50:16', '3', null, 'no time', '2014-09-04 10:08:31'), ('3', '11', '0', 'A162514134', '2014-09-03 15:55:52', '2014-09-04 14:02:06', '2', null, 'hello', '2014-09-04 09:58:14');
COMMIT;

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
  `shop_code` varchar(10) DEFAULT NULL,
  UNIQUE KEY `idx_code` (`acode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `car_aptms`
-- ----------------------------
BEGIN;
INSERT INTO `car_aptms` VALUES (null, 'A503804134', '11', null, null, 'CA-1573R', null, null, 'CDS001'), (null, 'A723804134', '11', null, null, 'CA-1573R', null, null, 'CDS001'), (null, 'A162514134', '11', null, null, 'CA-1573R', null, null, 'CDS001');
COMMIT;

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
  `framenumber` varchar(20) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `cars`
-- ----------------------------
BEGIN;
INSERT INTO `cars` VALUES ('1', '川A-BQ498', null, '蒙迪欧', 'B', '自动经典型', 'CA07408', null, '长安福特', '200612', '553', null, '4810-1800-1450-2754-1435', 'L6-2.0-143-185', 'CAF488Q1', 'FF', 'AT-4', '205-70-R18-88-H', '墨绿', '139087', 'http://www.xgo.com.cn/2650/2006/items.html', null, null), ('6', 'CA-8765G', '123-4567', '雨燕', null, null, null, null, '长安铃木', null, null, null, null, null, null, null, null, null, null, null, null, '2014-09-18 10:54:44', null), ('23', 'CA-1668H', '90-80', '蒙迪欧', null, null, null, null, '长安福特', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `carseries`
-- ----------------------------
DROP TABLE IF EXISTS `carseries`;
CREATE TABLE `carseries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ctype` varchar(10) DEFAULT NULL,
  `manufacturer` varchar(20) DEFAULT NULL,
  `brand` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `serie_url` varchar(60) DEFAULT NULL,
  `desc` varchar(128) DEFAULT NULL,
  `cfg_list` varchar(100) DEFAULT NULL,
  `style_list` varchar(100) DEFAULT NULL,
  `engine_list` varchar(100) DEFAULT NULL,
  `trans_list` varchar(30) DEFAULT NULL COMMENT '里程数',
  `color_list` varchar(30) DEFAULT NULL,
  `version` int(11) DEFAULT '0',
  `tags` varchar(26) DEFAULT NULL,
  `descp` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `carseries`
-- ----------------------------
BEGIN;
INSERT INTO `carseries` VALUES ('1', 'B', '长安福特', '蒙迪欧', '自动经典型', 'CA07408', null, '200612', '553', null, '139087', '墨绿', '0', 'CFM', null), ('2', 'A0', '长安铃木', '雨燕', '手动基本型', 'http://newcar.xcar.com.cn/176/', null, 'LMH', '552', '1.3-L4,1.5-L4,1.5-L4-T', '5-MT,6-AT,4-AMT,5-CVT', '蓝,白,黄,黑,绿,红,银,灰', '0', 'CLY', '铃木A0级小型轿车，两厢5门5座，2005年首款'), ('3', 'B', '广州本田', '雅阁', '', 'GB-74532', null, '自动豪华型', null, '2.0L4,2.5L4,3.0V6', '6-AT,6-MT,7-DSG', '黑,白,墨绿', '0', 'YGB', null), ('4', 'A', '长安铃木', '天语SX4', null, null, null, null, null, null, null, null, '0', 'CLMT', null), ('5', 'A', '北京现代', '伊兰特', null, null, null, null, null, null, null, null, '0', 'BXY', null);
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
INSERT INTO `ci_sessions` VALUES ('373eed90d0507bb49b4f05943f1a7798', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1411013141', ''), ('59e5cae5fe776401b58146a92cbca08d', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1411028837', ''), ('6db41b3b5e5d13f2b8a3fe3ced246680', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1411013208', ''), ('9e254b6632c02feaf9b91ade8106a4da', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1411013208', ''), ('dcaa7ef6bf97e62bdf3abe706a74a7d8', '127.0.0.1', 'Cars/1.0 CFNetwork/672.1.13 Darwin/14.0.0', '1411028837', '');
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
INSERT INTO `clients` VALUES ('1', null, 'shixc', 'a5b09e5b217127812c3f0e778dd1098404ce1fd4', null, '施磊', null, null, '18602802121', 'X_shileixc', null, '1', '2014-08-14 16:04:33', null, null), ('2', null, 'yanjh', null, null, '颜建华', null, null, '13808077242', 'X_hahar006', null, '0', null, null, null), ('4', null, null, null, null, '周琪', null, null, '13880735908', 'Q8990099', null, '0', null, null, null), ('10', null, null, null, null, '陶莉', null, null, '13882189728', 'Q89960707', null, '0', '2014-08-15 15:21:08', null, null), ('11', null, '13908077242', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '8C1AF92C-CDBC-4791-B', 'John Yan', 'yanjh@sina.com', 'yanjh@sina.com', '13908077242', null, null, '0', '2014-09-12 14:54:37', null, null);
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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `dic`
-- ----------------------------
BEGIN;
INSERT INTO `dic` VALUES ('1', '1', '0', '乘用车辆类型', null, null), ('2', '2', '0', '变速箱类型', null, null), ('3', '1', '1', 'A00-微型车', null, null), ('4', '1', '2', 'A0-小型车', '小型车', 'A0'), ('5', '1', '3', 'A-紧凑级', null, 'A'), ('6', '1', '4', 'B-中级车', null, 'B'), ('7', '1', '5', 'C-豪华级', null, 'C'), ('8', '1', '6', 'D-大型豪华级', null, 'D'), ('9', '1', '7', 'S0-小型SUV', null, 'S0'), ('10', '1', '8', 'SA-紧凑型SUV', '紧凑型SUV', 'SA'), ('11', '1', '9', 'MPV', '商务车', 'MPV'), ('12', '1', '100', '其他', null, null), ('13', '2', '1', 'MT4-4速手动', null, null), ('14', '2', '2', 'MT5-5速手动', null, null), ('15', '2', '3', 'MT6-6速手动', null, null), ('16', '2', '4', 'AT4-4速自动', null, null), ('17', '2', '5', 'AT5-5速自动', null, null), ('18', '2', '6', 'AT6-6速自动', null, null), ('19', '2', '7', 'CVT', null, null), ('20', '2', '8', 'DT', null, null), ('21', '3', '0', '车身结构', null, null), ('22', '1', '20', 'SB-中型SUV', null, 'SB'), ('23', '1', '21', 'SF-大型SUV', null, 'SF'), ('24', '1', '22', 'SC-跑车', null, 'SC'), ('25', '1', '23', 'SSC-超级跑车', null, 'SSC'), ('26', '3', '1', '552-5门5座2箱', null, null), ('27', '3', '2', '552-5门5座3箱', null, null), ('28', '3', '3', '553-3门5座2箱', null, null), ('29', '4', '0', '驱动形式', null, null), ('30', '4', '1', 'FF-前置前驱', null, null), ('31', '4', '2', 'FR-前置后驱', null, null), ('32', '4', '3', 'F4-前置四驱', null, null), ('33', '4', '4', 'RR-后置后驱', null, null), ('34', '4', '5', 'MR-中置后驱', null, null), ('35', '4', '6', 'M4-中置四驱', null, null), ('36', '2', '100', '其他', null, null), ('37', '3', '100', null, null, null), ('38', '4', '100', null, null, null), ('40', '5', '0', '预约和服务状态', null, null), ('41', '5', '100', null, null, null), ('42', '6', '0', '客户类型', null, null), ('43', '6', '100', null, null, null), ('44', '5', '1', '客户预约', null, null), ('45', '5', '2', '预约确认', null, null), ('46', '5', '10', '预约完成', null, null), ('47', '5', '11', '预约取消', null, null), ('48', '5', '3', '服务进行中', null, null), ('49', '7', '0', '客户账号状态', null, null), ('50', '7', '100', null, null, null), ('51', '7', '50', '正常', null, null), ('52', '7', '1', '未激活', null, null), ('53', '7', '2', '验证中', null, null), ('54', '7', '10', '已禁用', null, null), ('55', '8', '0', '菜品类别', null, null), ('56', '8', '100', 'END', null, null), ('58', '8', '13', '热炒', null, null), ('59', '8', '14', '凉菜', null, null), ('60', '8', '43', '主食', null, null), ('61', '8', '44', '配餐', null, null), ('62', '8', '45', '饮料', null, null), ('63', '8', '46', '甜品', null, null), ('64', '8', '15', '面食', null, null), ('65', '8', '16', '汤煲', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `dishes`
-- ----------------------------
DROP TABLE IF EXISTS `dishes`;
CREATE TABLE `dishes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dcode` varchar(5) DEFAULT NULL,
  `dtype` tinyint(4) DEFAULT NULL COMMENT '0-菜品 1-套餐',
  `name` varchar(50) DEFAULT NULL,
  `ename` varchar(50) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `descp` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `dishes`
-- ----------------------------
BEGIN;
INSERT INTO `dishes` VALUES ('1', 'S0011', '1', '麦辣鸡腿堡套餐', null, '18', '麦辣鸡腿堡，中可乐，中薯条'), ('2', 'W0011', '0', '麦辣鸡腿堡', null, '10', ''), ('3', 'D0004', '0', '中可乐', null, '6', '500ml'), ('4', 'A0003', '0', '中薯条', null, '6', '100g'), ('5', 'S1002', '0', '套餐配汤', null, '3', ''), ('6', 'S1001', '0', '套餐米饭', null, '1', ''), ('7', 'S1021', '1', '辣子鸡丁套餐', null, '16', ''), ('8', null, '0', '辣子鸡丁', null, '14', null), ('9', 'S1022', '1', '回锅肉套餐', null, '16', ''), ('10', 'S0012', '1', '双层吉士堡套餐', null, '18', ''), ('15', 'N0011', '0', '牛肉拉面(大)', null, '9', '');
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
INSERT INTO `links` VALUES ('1', '10', '陶莉', '1', '川A-BQ498', null), ('1', '10', '陶莉', '2', '川A-A1574', null), ('1', '11', '', '6', null, null), ('1', '11', '', '23', 'CA-1668H', null), ('2', '1', '', '4', '更换轮胎', null), ('2', '1', '', '5', '常规检查', null), ('2', '1', '', '8', 'A0级日常保养', null), ('2', '2', '', '3', '更换发动机油滤', null), ('2', '2', '', '6', '高级检查', null), ('2', '3', '', '3', '更换发动机油滤', null), ('2', '3', '', '4', '更换轮胎', null), ('2', '3', '', '7', '更换空气滤清器', null), ('2', '5', '', '1', '洗车-小型', null), ('2', '5', '', '4', '更换轮胎', null), ('10', '1', '', '60', '主食', null), ('10', '1', '', '61', '配餐', null), ('10', '4', '', '61', '配餐', null), ('10', '5', '套餐配汤', '61', '配餐', null), ('10', '8', '', '58', '热炒', null), ('10', '15', '', '64', '面食', null), ('11', '3', '', '1', '麦辣鸡腿堡套餐', null), ('11', '3', '', '10', '双层吉士堡套餐', null), ('11', '5', '套餐配汤', '7', '辣子鸡丁套餐', null), ('11', '6', '', '7', '辣子鸡丁套餐', null), ('11', '6', '', '9', '回锅肉套餐', null), ('11', '8', '', '7', '辣子鸡丁套餐', null);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tasktypes`
-- ----------------------------
BEGIN;
INSERT INTO `tasktypes` VALUES ('1', 'W001', '洗车-小型', null, '15', '2000', null, '30', '20'), ('2', 'W002', '洗车-中大型', null, '20', '1000', null, '40', '30'), ('3', 'T101', '更换发动机油滤', null, '60', '6000', null, null, null), ('4', 'T201', '更换轮胎', null, '127', '32767', null, null, null), ('5', 'C001', '常规检查', null, '0', '0', null, null, null), ('6', 'C002', '高级检查', null, '0', '0', null, null, null), ('7', 'M008', '更换空气滤清器', null, '30', '5000', null, '30', '80'), ('8', 'M002', 'A0级日常保养', null, '60', '5000', null, '120', '150'), ('9', 'B003', '贴膜', null, '0', '0', null, '45', '100'), ('11', 'D2', '什么名字', null, '30', '5000', null, '45', '100'), ('15', 'F003', '轮胎检查', null, '180', '15000', null, '30', '100'), ('16', '', '未命名', null, '30', '5000', null, '45', '100'), ('17', 'A001', '冷空气吸入口', null, '0', '0', null, '120', '200'), ('18', 'A002', '比赛用引擎调教', null, '0', '0', null, '90', '300'), ('19', 'A003', '比赛用节气门', null, '0', '0', null, '45', '100'), ('20', 'A004', '增加引擎缸径', null, '0', '0', null, '45', '100'), ('21', 'A005', '比赛用进气歧管', null, '0', '0', null, '45', '100'), ('22', 'A006', '比赛用凸轮轴', null, '0', '0', null, '45', '100'), ('23', 'A007', '比赛用汽缸盖', null, '0', '0', null, '45', '100'), ('24', 'A008', '高性能超级增压器普利盘', null, '0', '0', null, '45', '100');
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
INSERT INTO `zm_sessions` VALUES ('2', '011df3836cca0d7bc341350011118b23f12b35137f000001', '13908077242', '2015-09-12 14:23:53', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', '1622b001f1d1d7dd8ae596ac20729f94954f33c67f000001', '13908077242', '2015-09-12 14:43:03', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', '1a02d2860f42d5ddecfd5d188c0c386b561d02017f000001', '13908077242', '2015-09-12 14:28:07', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', '2bd033a2fb942bd084fe9db045bd5e8067ddef3e7f000001', '13908077242', '2015-09-12 14:36:45', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('0', '2d2d763917352e6af02a07abc19a8ebef20c34f17f000001', 'shixc', '2014-08-14 09:55:30', 'bbb', null), ('2', '32b3e5562bf33acaf45381f13310c2bc7ddc46527f000001', '13908077242', '2015-09-04 15:51:57', 'EFDD10DC-1341-40C9-8C18-2DEF2D665E4C', null), ('2', '3da376a0cdf72a609a99382eb2d9e6c0be9dad837f000001', '13908077242', '2015-09-10 14:01:05', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', '5d30d36fcbbc455b0ca2cab991fb6718d74985c37f000001', '13908077242', '2015-09-12 14:37:03', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', '8c579dac98e0e9b0615ad515180805e2879ed0327f000001', '13908077242', '2015-09-12 14:33:22', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', '8fe11966741cee825ffede84a104d026c47b36ca7f000001', '13908077242', '2015-09-01 23:12:57', '8C1AF92C-CDBC-4791-BA37-761F576108FF', null), ('2', 'c1669ea4e9b5b9550936f7d5abddb8bb023f22457f000001', '13908077242', '2015-09-12 14:45:13', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', 'cdda1ec3269923f663cbbf67a070d582e1e551a07f000001', '13908077242', '2015-09-11 16:50:59', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', 'd43b9a45d3234875cf22135acefadc682df19c317f000001', '13908077242', '2015-09-11 16:55:01', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', 'd62b561e5baefbd62512ee163a650d7dc8e9dbad7f000001', '13908077242', '2015-09-03 11:55:50', 'FDE249F3-5997-461F-AEF9-45C1E21E48DA', null), ('2', 'df8a54b232a961f8f42d4a845a4e4ea2fc332a477f000001', '13908077242', '2015-09-11 15:35:28', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', 'e2820a768720c5b2a329d5d3596ec6d6038899977f000001', '13908077242', '2015-09-08 22:32:38', '01B5BDF3-A228-4DDF-B920-7CBB0DDDE302', null), ('2', 'ed3b3db340cd33edd9a81eb28a88c3b7d36722b07f000001', '13908077242', '2015-09-11 15:57:17', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null), ('2', 'f4d01309a0529a4521294caecd22e95cb019a0177f000001', '13908077242', '2015-09-12 14:42:52', 'DB7EDF4E-8FED-42BB-AE77-4632DE40A904', null);
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
INSERT INTO `zm_versions` VALUES ('client_cars_11', '36'), ('shop_version', '9');
COMMIT;

-- ----------------------------
--  View structure for `v_cappointments`
-- ----------------------------
DROP VIEW IF EXISTS `v_cappointments`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cappointments` AS select `a`.`acode` AS `acode`,`a`.`rtime` AS `rtime`,`a`.`ptime` AS `ptime`,`c`.`carnumber` AS `carnumber`,`u`.`name` AS `name`,`c`.`client` AS `client`,`a`.`status` AS `status`,`a`.`descp` AS `descp`,`a`.`edit_at` AS `edit_at` from ((`appointments` `a` left join `car_aptms` `c` on((`a`.`acode` = `c`.`acode`))) left join `clients` `u` on((`u`.`id` = `c`.`client`))) where (`a`.`atype` = 0);

-- ----------------------------
--  View structure for `v_carsofuser`
-- ----------------------------
DROP VIEW IF EXISTS `v_carsofuser`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_carsofuser` AS select `u`.`name` AS `name`,`c`.`carnumber` AS `carnumber`,`c`.`manufacturer` AS `manufacturer`,`c`.`brand` AS `brand`,`c`.`id` AS `cid`,`c`.`descp` AS `descp`,`u`.`id` AS `uid`,`c`.`mileage` AS `mileage`,`c`.`config` AS `config`,`c`.`engine` AS `engine`,`c`.`color` AS `color`,`c`.`framenumber` AS `framenumber` from ((`links` `l` left join `clients` `u` on((`u`.`id` = `l`.`lid`))) left join `cars` `c` on((`c`.`id` = `l`.`rid`))) where ((`l`.`ltype` = 1) and (`c`.`id` is not null) and (`u`.`id` is not null));

SET FOREIGN_KEY_CHECKS = 1;
