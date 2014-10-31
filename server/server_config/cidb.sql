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

 Date: 10/31/2014 17:04:18 PM
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
INSERT INTO `ci_sessions` VALUES ('10d2ba0f44a5a555241459b61a2e19e0', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/600.1.25 (KHTML, like Gecko) Version/8.0 Safari/600.1.25', '1414735850', 'a:5:{s:9:\"user_data\";s:0:\"\";s:12:\"itv_username\";s:9:\"颜建华\";s:12:\"itv_userrole\";i:100;s:8:\"itv_type\";s:2:\"11\";s:12:\"itv_timeleft\";d:-2620;}'), ('9bcbd51de15cc568b69d54f9c1fcc325', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:23.0) Gecko/20100101 Firefox/23.0', '1414739911', 'a:6:{s:9:\"user_data\";s:0:\"\";s:12:\"itv_username\";s:6:\"萧峰\";s:12:\"itv_userrole\";i:2;s:8:\"itv_type\";s:2:\"11\";s:12:\"itv_timeleft\";d:48;s:8:\"itv_user\";s:3:\"138\";}');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `clients`
-- ----------------------------
BEGIN;
INSERT INTO `clients` VALUES ('1', null, 'shixc', 'a5b09e5b217127812c3f0e778dd1098404ce1fd4', null, '施磊', null, null, '18602802121', 'X_shileixc', null, '1', '2014-08-14 16:04:33', null, null), ('2', null, 'yanjh', null, null, '颜建华', null, null, '13808077242', 'X_hahar006', null, '0', null, null, null), ('4', null, null, null, null, '周琪', null, null, '13880735908', 'Q8990099', null, '0', null, null, null), ('10', null, null, null, null, '陶莉', null, null, '13882189728', 'Q89960707', null, '0', '2014-08-15 15:21:08', null, null), ('11', null, '13908077242', 'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d', '8C1AF92C-CDBC-4791-B', 'John Yan', 'Tianfu', 'yanjh@sina.com', '13908077242', null, null, '0', '2014-09-19 17:00:15', null, null), ('12', null, null, null, null, null, null, null, null, null, null, '0', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `clogs`
-- ----------------------------
DROP TABLE IF EXISTS `clogs`;
CREATE TABLE `clogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course` int(11) DEFAULT NULL COMMENT '课程编号',
  `sclass` int(11) DEFAULT NULL COMMENT '班级编号',
  `lesson` int(11) DEFAULT '0' COMMENT '课堂编号',
  `ltype` tinyint(4) DEFAULT '0' COMMENT '日志类型 0-系统 1-课程状态 2-教师 3-学生',
  `rid` int(11) DEFAULT NULL COMMENT '来源id',
  `rname` varchar(30) DEFAULT NULL COMMENT '来源名称',
  `ltime` int(11) DEFAULT NULL COMMENT '记录时间',
  `content` varchar(256) DEFAULT NULL COMMENT '日志内容',
  `flag` int(11) DEFAULT '0' COMMENT '标志位，保留',
  `tid` int(11) DEFAULT NULL,
  `tname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `clogs`
-- ----------------------------
BEGIN;
INSERT INTO `clogs` VALUES ('1', '1', '3', '5', '1', null, null, '1413269564', '修改了课堂状态', '0', null, null), ('2', '1', '3', '5', '1', null, null, '1413269604', '修改了课堂状态', '0', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `cmodules`
-- ----------------------------
DROP TABLE IF EXISTS `cmodules`;
CREATE TABLE `cmodules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `course` int(11) DEFAULT NULL COMMENT '课程',
  `morder` smallint(6) DEFAULT NULL COMMENT '次序',
  `mtype` smallint(6) DEFAULT NULL COMMENT '课程模块类型 0-简介 1-章节 2-测验 3-调查 ',
  `content` varchar(2048) DEFAULT NULL,
  `status` smallint(6) DEFAULT '0' COMMENT '状态，0-编辑中，1-已发布 10-删除',
  `edit_at` int(11) DEFAULT NULL COMMENT '按分钟计算的最后编辑时间，用于离线请求',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `cmodules`
-- ----------------------------
BEGIN;
INSERT INTO `cmodules` VALUES ('1', '课程说明', '1', '1', '10', '共9个课时，5个自学模块，4个测验，5个作业\n9月10日作业\n阅读课本P15~55\n9月12日作业\n搜索网络相关资料\n', '0', '23554489'), ('2', '一. 数一数与乘法', '1', '2', '11', '{\n	\"ctype\":\"jpg_txt\",\n	\"total\":4,\n	\"descp1\":\"两个黄鹂鸣翠柳\",\n	\"descp2\":\"一行白鹭上青天\",\n	\"descp3\":\"三人行必有我师\",\n	\"descp4\":\"四面边声连角起，千嶂里，长烟落日孤城闭\",\n}', '0', '23554140'), ('3', '二. 乘法口诀1', '1', '6', '11', '', '0', '23554278'), ('4', '小测验', '1', '5', '13', '{\"count\":4,\"score\":30,\"content\":[{\"qorder\":\"1\",\"qtype\":\"10\",\"content\":\"\\u6d4b\\u8bd5\\u8bf4\\u660e\"},{\"qorder\":\"2\",\"qtype\":\"10\",\"content\":\"\\u5355\\u9009\\u9898 \\u51715\\u9898 10\\u5206\"},{\"qorder\":\"3\",\"qtype\":\"11\",\"score\":\"5\",\"content\":\"\\u4e09\\u89d2\\u5f62\\u7684\\u5185\\u89d2\\u4e4b\\u548c\\u4e3a:\\n\\n\\n90\\u00b0\\n\\u2713180\\u00b0\\n270\\u00b0\\n360\\u00b0\"},{\"qorder\":\"4\",\"qtype\":\"10\",\"content\":\"\\u591a\\u9009\\u9898 \\u51716\\u9898 20\\u5206\"},{\"qorder\":\"5\",\"qtype\":\"12\",\"score\":\"10\",\"content\":\"\\u4e0b\\u5217\\u90a3\\u4e9b\\u56fd\\u5bb6\\u662f\\u6b27\\u6d32\\u56fd\\u5bb6\\n\\n\\n\\u6fb3\\u5927\\u5229\\u4e9a\\n\\u2713\\u571f\\u8033\\u5176\\n\\u6469\\u6d1b\\u54e5\\n\\u2713\\u4fc4\\u7f57\\u65af\"},{\"qorder\":\"6\",\"qtype\":\"10\",\"content\":\"\\u586b\\u7a7a\\u9898 \\u51712\\u9898 10\\u5206\"},{\"qorder\":\"7\",\"qtype\":\"13\",\"score\":\"5\",\"content\":\"\\u4e2d\\u56fd\\u7684\\u82f1\\u6587\\u7b80\\u79f0\\u4e3a__A__\\uff0c\\u7f8e\\u56fd\\u7684\\u82f1\\u6587\\u7b80\\u79f0\\u4e3a__B__\\u3002\\n\\n\\nCHN,CN\\nUS,USA\"},{\"qorder\":\"8\",\"qtype\":\"10\",\"content\":\"\\u7b80\\u7b54\\u9898\"},{\"qorder\":\"9\",\"qtype\":\"19\",\"score\":\"10\",\"content\":\"\\u7b80\\u8981\\u5217\\u4e3e\\u56db\\u5ddd\\u7684\\u4e3b\\u8981\\u666f\\u70b9\\n\\n\\n\"},{\"qorder\":\"10\",\"qtype\":\"10\",\"content\":\"\\u7ed3\\u675f\\u8bf4\\u660e\"}]}', '1', '23568691'), ('5', '四. 分一分与除法', '1', '9', null, '', '0', null), ('6', '整理与复习1', '1', '10', null, '', '0', null), ('7', '总复习', '1', '102', null, '', '0', null), ('8', '节日广场', '1', '8', null, '', '0', null), ('9', '五. 方向与位置', '1', '11', null, '', '0', null), ('10', '二. 小数', '2', '1', '9', '', '0', null), ('11', '三. 观察物体', '1', '7', null, '', '0', null), ('12', '一. 数一数与乘法', '2', '1', null, '第一章', '0', null), ('13', '七. 乘法口诀2', '1', '14', null, '', '0', null), ('14', '六. 时、分、秒', '1', '12', null, '', '0', null), ('15', '月球旅行', '1', '13', null, '', '0', null), ('18', '整理与复习2', '1', '86', '0', '', '0', null), ('19', '八. 除法', '1', '87', '0', '', '0', null), ('20', '九. 统计与猜测', '1', '88', '0', '', '0', null), ('21', '趣味运动会', '1', '89', '0', '', '0', null), ('22', '期末考试', '1', '103', '13', '', '0', null), ('23', '一、声母', '3', '1', '9', '', '0', null), ('24', '一. 现代完成时', '4', '1', '9', '', '0', null), ('25', '简介', '7', '1', '10', null, '0', null), ('26', '小作业', '1', '4', '14', '{\"count\":4,\"score\":0,\"content\":[{\"qorder\":\"1\",\"qtype\":\"1\",\"content\":\"\\u4f5c\\u4e1a\\u8bf4\\u660e\"},{\"qorder\":\"2\",\"qtype\":\"2\",\"content\":\"\\u9644\\u4ef6\\u5217\\u8868\\n\\n\\u8bb2\\u4e49: aa.ppt\\n\\u5730\\u56fe: map.jpg\\n\\u542c\\u5199: tt.mp3\\n\"},{\"qorder\":\"3\",\"qtype\":\"3\",\"content\":\"\\u94fe\\u63a5\\n\\n\\u767e\\u5ea6: baidu.com\\n\\u7ef4\\u57fa: wiki.com\"},{\"qorder\":\"4\",\"qtype\":\"11\",\"content\":\"\\u7f8e\\u56fd\\u9996\\u90fd\\u662f \\n\\n\\n\\u829d\\u52a0\\u54e5\\n\\u2713\\u534e\\u76db\\u987f\\n\\u7ebd\\u7ea6 \\n\\u6d1b\\u6749\\u77f6\"},{\"qorder\":\"5\",\"qtype\":\"13\",\"content\":\"\\u5510\\u8bd7\\u4e2d\\u8bd7\\u4ed9\\u662f\\u6307__A__\\uff0c\\u8bd7\\u5723\\u662f\\u6307__B__\\u3002 \\n\\n\\n\\u674e\\u767d\\n\\u675c\\u752b\"},{\"qorder\":\"6\",\"qtype\":\"19\",\"content\":\"\\u8bf7\\u7b80\\u8981\\u8bf4\\u660e\\u5317\\u4eac\\u4f5c\\u4e3a\\u4e2d\\u56fd\\u653f\\u6cbb\\u4e2d\\u5fc3\\u7684\\u5386\\u53f2\\u3002\"},{\"qorder\":\"7\",\"qtype\":\"12\",\"content\":\"\\u90a3\\u4e9b\\u56fd\\u5bb6\\u662f\\u62c9\\u4e01\\u7f8e\\u6d32\\u56fd\\u5bb6 \\n\\n\\n\\u2713\\u53e4\\u5df4\\n\\u2713\\u58a8\\u897f\\u54e5\\n\\u2713\\u5df4\\u897f\\n\\u7f8e\\u56fd\"}]}', '1', '23567461'), ('27', '同步课堂1', '1', '3', '11', null, '0', '23567292');
COMMIT;

-- ----------------------------
--  Table structure for `courses`
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ccode` varchar(12) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `ccata` varchar(4) DEFAULT NULL COMMENT '科目编码',
  `descp` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `courses`
-- ----------------------------
BEGIN;
INSERT INTO `courses` VALUES ('1', 'M902', '初三数学下', 'MH', null), ('2', 'C901', '初三语文上', 'CL', null), ('3', 'CB02', '初二语文(下)', 'CL', null), ('4', 'E901', '初三英语(上)', 'EN', null), ('6', 'M901', '初三数学上', 'MH', null), ('7', 'C902', '初三语文下', 'CL', null);
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
--  Table structure for `itvanswers`
-- ----------------------------
DROP TABLE IF EXISTS `itvanswers`;
CREATE TABLE `itvanswers` (
  `contact` varchar(20) DEFAULT NULL,
  `exam` int(11) DEFAULT NULL,
  `eorder` int(11) DEFAULT NULL,
  `answer` varchar(500) DEFAULT NULL,
  `score` tinyint(4) DEFAULT '0',
  `review` varchar(50) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `itvanswers`
-- ----------------------------
BEGIN;
INSERT INTO `itvanswers` VALUES ('13808077242', '11', '3', '编译平台、硬件限制、部分特殊API', '8', null, null), ('13808077242', '11', '9', 'M-模型，V-视图，C-控制器，解耦，模块化。', '8', null, null), ('13808077242', '11', '7', '自动引用计数，减少程序员手工管理内存造成的工作量和出错概率。\n需要对响应的文件指定不使用ARC的编译标记。', '7', null, null), ('13808077242', '11', '1', 'Mac OS X, Xcode，Simulator，Organizer...', '6', null, null), ('13808077242', '11', '2', '语言(Ojb-C vs HTML5)，开发、测试和运行环境', '8', null, null), ('13808077242', '11', '6', '错误调用类方法，如NSArray, NSDirectionay..\nNull Delegate\nSQL 语法错误', '0', null, null), ('13800138000', '11', '3', '区别不大', null, null, null), ('13800138000', '11', '11', '网络访问，数据库操作', '0', null, null), ('13880735908', '11', '9', 'M-模型，V-视图', null, null, null), ('13880735908', '11', '1', 'Mac OS X, Xcode, Safari', null, null, null), ('13800138000', '12', '11', '客户端和服务器都保存摘要密码，传输可变密码编码', '0', null, null), ('13800138000', '12', '2', '基本机制和语法还是使用Java，也使用Java的开发工具，Delvik虚拟机，部分框架和类库，增加Android相关类库\n', '6', null, null), ('13800138000', '12', '5', 'Relative Layout,根据不同的屏幕加载不同的布局文件。', '10', null, null), ('13800138000', '12', '21', '华为P7，Android4.4，2G ,海思处理器', '0', null, null), ('138', '11', '18', 'URL中和RequestBody，长度限制不同，重复提交处理不同', '0', null, null), ('138', '11', '1', 'Mac OS X,Xcode,git,simulator', '0', null, null), ('138', '11', '10', 'NSConnection,', '0', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `itvquestions`
-- ----------------------------
DROP TABLE IF EXISTS `itvquestions`;
CREATE TABLE `itvquestions` (
  `exam` int(11) NOT NULL DEFAULT '0',
  `eorder` int(11) NOT NULL DEFAULT '0',
  `content` varchar(300) DEFAULT NULL,
  `flag` int(11) DEFAULT '0',
  `score` int(11) DEFAULT '0',
  PRIMARY KEY (`exam`,`eorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `itvquestions`
-- ----------------------------
BEGIN;
INSERT INTO `itvquestions` VALUES ('11', '1', '请简述iOS开发环境组成和相关工具', null, '10'), ('11', '2', 'iOS原⽣应⽤和Web应⽤在开发方⾯的主要区别在那⾥?', null, '10'), ('11', '3', '模拟器和真机在开发上的主要区别在什么地⽅', null, '10'), ('11', '4', '请简述iOS应⽤用开发如何⽀支持多种屏幕和分辨率的?如iPhone4/5和iPad', null, '10'), ('11', '5', '你觉得Objective-C语⾔言的主要优点和缺陷(如和C或JAVA相比)是什么?', null, '10'), ('11', '6', '请列举出一两个你在iOS开发中经常遇到的错误?', null, '10'), ('11', '7', '何为ARC?为什么要引入ARC?在ARC项目中，如何兼容原有非ARC代码', null, '10'), ('11', '8', '试两个常用的Cocoa Touch组件，并说明它们的主要功能特性。', null, '10'), ('11', '9', '何为MVC？其优缺点如何？在iOS开发中通常如何运用？', null, '10'), ('11', '10', '在iOS开发中通常如何实现网络连接和访问。', null, '10'), ('11', '11', '请举出在iOS开发中需要实现异步操作的场景，以及如何具体实现。', null, '10'), ('11', '13', '简要说明如何在TableCell中实现事件响应(如按钮和检查框)', null, '10'), ('11', '14', '何为委托Delegate，试举一个使用委托的场景', null, '10'), ('11', '15', '何为观察者(Observer)，其实现和应用流程通常是怎样的?', null, '10'), ('11', '16', '在iOS应用开发中，通常如何管理和使用结构化数据', null, '10'), ('11', '17', '假设有一个新闻数据库的表，表中包括新闻内容和发布时间等属性，请尝试编写一个SQL，来执行一个清理操作，以保留最近发布的20条记录', null, '10'), ('11', '18', 'HTTP协议中,GET和POST方法的区别如何，它们的应用场景如何？\n', null, '10'), ('11', '19', '试举几个常用的HTTP通讯状态码以及它们的含义', null, '10'), ('11', '20', '请尝试设计和说明在iOS应⽤开发中如何实现一个安全的网络登录和应用过程', null, '10'), ('11', '21', '何为JSON，其基本结构和格式是怎样的?iOS开发中通常如何处理JSON?', null, '10'), ('11', '22', '在iOS开发中，如何实现单元测试', null, '10'), ('11', '23', '简要说明iOS应用开发的提交和审核流程？', null, '10'), ('11', '24', '请简要说明在iOS开发和测试阶段，如何简化内部测试和发布流程', null, '10'), ('11', '25', '简述iOS IAP的原理和实现方式，以及如何防范IAP破解', null, '10'), ('11', '26', '以新浪微博、支付宝或其他应用为例，简单阐述如何在iOS程序中实现第三方应用集成', null, '10'), ('12', '1', '简要说明Android应用的常规开发环境和相关工具', '0', '10'), ('12', '2', '请说明Android应用程序和普通Java应用之间的区别和联系', '0', '10'), ('12', '3', '何为MVC?它在Android程序架构和开发过程如何体现?', null, '10'), ('12', '4', 'Activity和Fragment的生命周期有何异同?你认为Android系统为何要引入和设计这样一种机制?', '0', '0'), ('12', '5', 'Android应用开发中，如何使应用程序适配不同类型的屏幕?', '0', '0'), ('12', '6', 'Android应用开发中有那些方式可以用于实现数据持久化?', '0', '0'), ('12', '7', '列举几种常见的可能导致GC内存泄露的状况.', '0', '0'), ('12', '8', '何为Intent?通常它有那些相关要素?何为Pending Intent?尝试列举Pending Intent的使用场景', '0', '0'), ('12', '9', 'Android开发中，通常如何实现一个自定义的ListView?并且优化它?', '0', '0'), ('12', '10', '如何实现Android应用和网络应用系统的通信?并保证其不会阻塞用户主进程?', '0', '0'), ('12', '11', '以用户登录过程为例，简述其实现方式和如何提升此过程的安全性。', '0', '0'), ('12', '12', 'Android中如何操作数据库，通常这种数据库和其他常见数据库(如MySQL)的联系和区别是什么?为什么会有这些异同?', '0', '0'), ('12', '13', '何为JSON?其主要的结构和格式是怎样的?并简述和XML相比,它在网络应用中的优势。', '0', '10'), ('12', '14', '简要说明HTTP协议的工作方式和信息结构,并说明GET和POST方法的主要区别', '0', '10'), ('12', '15', '试举几个常用的HTTP通讯状态码以及它们的含义', '0', '10'), ('12', '16', '何为序列化?试举几个Android应用中序列化的使用场景。', '0', '10'), ('12', '17', '以你常用的版本管理软件为例，说明版本管理的常规流程，并解释其几种主要常见操作。', '0', '10'), ('12', '18', '以新浪微博、支付宝或其他应用为例，简单阐述如何在iOS程序中实现第三方应用集成', '0', '10'), ('12', '19', '简要说明Android应用程序的封装和发布流程。', '0', '10'), ('12', '20', '假设有一个新闻数据库的表，表中包括新闻内容和发布时间等属性，请尝试编写一个SQL，来执行一个清理操作，以保留最近发布的20条记录', '0', '10'), ('12', '21', '请例举你现在使用Android设备的型号、配置，操作系统版本以及此版本的主要特性。', '0', '10'), ('13', '1', 'Web应用开发中，如何实现Session', '0', '0'), ('13', '2', '请列举你常用的Linux系统，和此操作系统安装和应用安装的过程', '0', '0'), ('13', '3', '说明SSH的工作原理', '0', '0'), ('13', '4', '何为REST，在你使用的后台应用开发中，如何实现REST', '0', '0'), ('14', '4', '通常如何将一个Linux应用程序做成一个自启动服务', '0', '0'), ('15', '5', '请例举几种远程管理MySQL数据库的方法。', '0', '0'), ('15', '6', '请例举你常用的Web服务器软件?并简要说明其安装和配置方式。', '0', '0'), ('15', '7', '何为消息队列服务，例举常见的MQ软件', '0', '0'), ('15', '8', '例举几种常见网络服务和其使用的端口。', '0', '0'), ('15', '9', '简要说明在Linux中，如何配置网络接口', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `itvusers`
-- ----------------------------
DROP TABLE IF EXISTS `itvusers`;
CREATE TABLE `itvusers` (
  `contact` varchar(20) NOT NULL DEFAULT '0',
  `name` varchar(20) NOT NULL DEFAULT '0',
  `answer` varchar(255) DEFAULT NULL,
  `flag` int(11) DEFAULT '1' COMMENT '0 未登录 1-答题中 2-已提交 3-已批复 100-管理员',
  `passwd` varchar(80) NOT NULL,
  `itype` int(11) DEFAULT NULL,
  `itime` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `itvusers`
-- ----------------------------
BEGIN;
INSERT INTO `itvusers` VALUES ('13808077242', '颜建华', '', '3', '8db1b26f628cddbccb4df5f4530bf853fdca99ea', '11', '23576079', '37'), ('13800138000', '古定超', '很不错', '2', '75e0ed0ae9bc5a3c3c710495a0308691bf37c9c5', '12', '23578666', '16'), ('138', '萧峰', '', '2', 'ce4f5a7fcafe7ef514b5f60a44e9e32a398429be', '11', '23578920', '0');
COMMIT;

-- ----------------------------
--  Table structure for `lessons`
-- ----------------------------
DROP TABLE IF EXISTS `lessons`;
CREATE TABLE `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lcode` varchar(20) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `module` int(11) DEFAULT NULL,
  `sclass` int(11) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `stime` int(11) DEFAULT NULL,
  `etime` int(11) DEFAULT NULL,
  `cur_pos` smallint(6) DEFAULT '0' COMMENT '当前位置',
  `update_at` int(11) DEFAULT '0' COMMENT '课堂内容或者状态修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `lessons`
-- ----------------------------
BEGIN;
INSERT INTO `lessons` VALUES ('2', 'P201501-T01', null, '4', '3', '2', '23544060', '23544120', '0', '23568691'), ('3', null, null, '4', '4', '1', '23551260', '23551320', '0', '23568691'), ('4', null, null, '24', '3', '1', '23534187', '23534247', '0', '0'), ('5', '序言', null, '1', '3', '3', '23505120', '23623394', '0', '0'), ('6', '一. 数一数与乘法', null, '2', '3', '5', '23554311', '23554371', '0', '0'), ('7', '小作业', null, '26', '3', '4', '23535596', '23563260', '0', '23567461'), ('8', '序言', null, '1', '4', '2', '23535612', '23535672', '0', '0');
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
--  Table structure for `moduleitems`
-- ----------------------------
DROP TABLE IF EXISTS `moduleitems`;
CREATE TABLE `moduleitems` (
  `module` int(11) DEFAULT NULL,
  `qtype` int(11) DEFAULT NULL,
  `question` int(11) DEFAULT NULL,
  `qorder` int(11) DEFAULT '0',
  `score` int(11) DEFAULT NULL,
  `content` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `moduleitems`
-- ----------------------------
BEGIN;
INSERT INTO `moduleitems` VALUES ('4', '10', '0', '4', null, '多选题 共6题 20分'), ('4', '10', '0', '6', null, '填空题 共2题 10分'), ('4', '13', '4', '7', '5', '中国的英文简称为'), ('4', '12', '3', '5', '10', '下列那些国家是欧'), ('4', '10', '0', '8', null, '简答题'), ('4', '10', '0', '2', null, '单选题 共5题 10分'), ('4', '10', '0', '1', null, '测试说明'), ('4', '10', '0', '10', null, '结束说明'), ('26', '1', '0', '1', null, '作业说明'), ('26', '2', '0', '2', null, '附件列表\n\n讲义: aa.ppt\n地图: map.jpg\n听写: tt.mp3\n'), ('26', '3', '0', '3', null, '链接\n\n百度: baidu.com\n维基: wiki.com'), ('26', '19', '0', '4', '0', '请简要说明北京作为中国政治中心的历史。'), ('26', '13', '0', '3', '0', '唐诗中诗仙是指__A__，诗圣是指__B__。 \n\n\n李白\n杜甫'), ('26', '11', '0', '3', '0', '美国首都是 \n\n\n芝加哥\n✓华盛顿\n纽约 \n洛杉矶'), ('26', '12', '0', '5', '0', '那些国家是拉丁美洲国家 \n\n\n✓古巴\n✓墨西哥\n✓巴西\n美国'), ('4', '19', '0', '9', '10', '简要列举四川的主要景点\n\n\n'), ('4', '11', '1', '3', '5', '三角形的内角之和');
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
--  Table structure for `questions`
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qcode` varchar(18) DEFAULT NULL,
  `subject` varbinary(4) DEFAULT NULL,
  `qtype` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(1024) DEFAULT NULL,
  `qoption` varchar(1024) DEFAULT NULL,
  `grade` smallint(6) DEFAULT '1',
  `difficulty` smallint(6) DEFAULT '0',
  `status` int(11) DEFAULT NULL,
  `edit_at` int(11) DEFAULT NULL COMMENT '编辑时间',
  `tag` varchar(200) DEFAULT NULL,
  `favflag` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_code` (`qcode`,`subject`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `questions`
-- ----------------------------
BEGIN;
INSERT INTO `questions` VALUES ('1', 'M00001', 0x4d48, '11', null, '三角形的内角之和为:\n\n\n90°\n✓180°\n270°\n360°', '90°\n✓180°\n270°\n360°', '3', '5', null, '23567462', null, '0'), ('2', 'G000003', 0x5053, '13', null, '美国首都是__A__,印度的首都是__B__\n\n\n华盛顿\n新德里', '华盛顿\n新德里', '8', '5', null, '23567240', null, '0'), ('3', 'G000004', 0x4748, '12', null, '下列那些国家是欧洲国家\n\n\n澳大利亚\n✓土耳其\n摩洛哥\n✓俄罗斯', '澳大利亚\n✓土耳其\n摩洛哥\n✓俄罗斯', '9', '5', null, '23567242', null, '1'), ('4', 'G000005', 0x454e, '13', null, '中国的英文简称为__A__，美国的英文简称为__B__。\n\n\nCHN,CN\nUS,USA', 'CHN,CN\nUS,USA', '1', '5', null, '23567240', null, '0'), ('5', 'G000009', 0x47, '21', null, '简要概述四川主要旅游景点', '', '1', '5', null, '23563136', null, '0'), ('6', 'G100012', 0x4748, '12', null, '下列那些城市不在东半球\n\n\n伦敦\n✓纽约\n巴黎\n悉尼', '伦敦\n✓纽约\n巴黎\n悉尼', '10', '5', null, '23567238', null, '0'), ('9', 'H100016', 0x4854, '12', null, '下列那些城市不是首都\n\n\n✓伊斯坦布尔\n✓纽约\n巴格达\n✓孟买', '✓伊斯坦布尔\n✓纽约\n巴格达\n✓孟买', '8', '5', null, '23567236', null, '0'), ('10', 'H100039', 0x4854, '19', null, '请简要说明北京作为中国政治中心的历史。\n\n\n', '', '9', '5', null, '23567232', null, '0'), ('11', 'C010002', 0x434c, '11', null, '下列那位诗人号称诗仙\n\n\n苏轼\n白居易\n✓李白\n杜甫', '苏轼\n白居易\n✓李白\n杜甫', '1', '5', null, '23567226', null, '0'), ('12', 'G000024', 0x4748, '19', null, '简要列举四川的主要景点\n\n\n', '', '5', '5', null, '23567398', null, '0');
COMMIT;

-- ----------------------------
--  Table structure for `sclasses`
-- ----------------------------
DROP TABLE IF EXISTS `sclasses`;
CREATE TABLE `sclasses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scode` varchar(10) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  `utype` tinyint(4) DEFAULT '0' COMMENT '0-学校 1-年级 2-班级',
  `name` varchar(255) DEFAULT NULL,
  `gyear` smallint(6) DEFAULT '0' COMMENT '毕业年份',
  `address` varchar(100) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `descp` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sclasses`
-- ----------------------------
BEGIN;
INSERT INTO `sclasses` VALUES ('1', 'CDNSMS', '0', '0', '成都七中', '1980', '天府大道', '028-88888888', null), ('2', 'CSNNMS', '0', '0', '成都九中', '1987', '天府广场', '028-86000998', null), ('3', 'P201501', '1', '2', '初2015级1班', '2015', '教三202', null, null), ('4', 'P201502', '1', '2', '初2015级2班', '2015', '', '', null), ('6', 'CDSSMS', '0', '0', '石室中学1', null, '陕西街', '', null), ('7', 'P201603', '1', '2', '初2016级3班', '2016', '主楼503', '', null), ('8', 'SSH2016A', '6', '2', '高2016级B班', '2016', '', '', null), ('9', 'SSH2017C', '6', '2', '高2017级C班', '2017', '教4-503', '', null), ('10', 'NMP2016A', '2', '2', '初2016级A班', '2016', '1号楼308', '', null);
COMMIT;

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
--  Table structure for `slinks`
-- ----------------------------
DROP TABLE IF EXISTS `slinks`;
CREATE TABLE `slinks` (
  `ltype` smallint(6) NOT NULL DEFAULT '0',
  `lid` int(11) NOT NULL DEFAULT '0',
  `lname` varchar(20) DEFAULT NULL,
  `rid` int(11) NOT NULL DEFAULT '0',
  `rname` varchar(20) DEFAULT NULL,
  `lorder` int(11) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ltype`,`lid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `slinks`
-- ----------------------------
BEGIN;
INSERT INTO `slinks` VALUES ('102', '3', '', '12', '曹操', null, null), ('102', '3', '', '14', '数学老师', null, null), ('102', '3', '', '15', '助理老师', null, null), ('111', '3', '初2015级1班', '1', '初中一年级数学(北师大)', null, null), ('111', '3', '初2015级1班', '4', '初三英语(上)', null, null), ('111', '3', '初2015级1班', '6', '初三数学(上)', null, null), ('111', '3', '初2015级1班', '7', '初三语文下', null, null), ('111', '4', '初2015级2班', '1', '初中一年级数学(北师大)', null, null), ('111', '4', '初2015级2班', '4', '初三英语(上)', null, null), ('111', '4', '初2015级2班', '6', '初三数学(上)', null, null), ('111', '4', '初2015级2班', '7', '初三语文下', null, null), ('111', '7', '初2016级3班', '2', '初二语文(上)', null, null), ('111', '10', '初2016级A班', '2', '初二语文(上)', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `sreports`
-- ----------------------------
DROP TABLE IF EXISTS `sreports`;
CREATE TABLE `sreports` (
  `uid` int(11) DEFAULT NULL COMMENT '用户',
  `mid` int(11) DEFAULT NULL COMMENT '内容模块',
  `qorder` int(11) DEFAULT NULL COMMENT '题目',
  `answer` varchar(600) DEFAULT NULL COMMENT '用户答案',
  `score` smallint(6) DEFAULT NULL COMMENT '得分',
  `status` smallint(6) DEFAULT NULL COMMENT '状态，0-未答 1-错 2-对 3-待审核 4-已批覆',
  `rnote` varchar(100) DEFAULT NULL COMMENT '批覆注解，用户可见，批复人',
  `rtime` int(11) DEFAULT '0' COMMENT '批复时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sreports`
-- ----------------------------
BEGIN;
INSERT INTO `sreports` VALUES ('8', '4', '3', 'B', '5', '2', null, '0'), ('8', '4', '5', 'BC', '0', '1', null, '0'), ('8', '4', '7', 'CHN,,US', '5', '2', null, '0'), ('8', '4', '9', 'djy', '9', '4', 'OK,Greate\n(颜建华,201410281617)', '0'), ('9', '4', '3', 'B', '5', '2', null, '0'), ('9', '4', '5', 'BD', '4', '2', null, '0'), ('9', '4', '7', 'CHS,,USA', '0', '1', null, '0'), ('9', '4', '9', 'djy', '10', '4', 'Good\n(颜建华,201410281617)', '0');
COMMIT;

-- ----------------------------
--  Table structure for `susers`
-- ----------------------------
DROP TABLE IF EXISTS `susers`;
CREATE TABLE `susers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stype` smallint(6) DEFAULT '0' COMMENT '类型 0-学生 1-教师',
  `snumber` varchar(12) DEFAULT NULL COMMENT '学号或工号',
  `sclass` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `bdate` varchar(8) DEFAULT NULL,
  `gender` tinyint(4) DEFAULT '0',
  `descp` varchar(128) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `susers`
-- ----------------------------
BEGIN;
INSERT INTO `susers` VALUES ('1', '1', 'A003', '1', '颜建华', null, '0', null, null), ('2', null, null, null, '张三', null, '0', null, null), ('3', '2', 'S20150101', '3', '萧峰', null, '0', null, null), ('4', '2', 'S20150104', '3', '欧阳锋', null, '0', null, null), ('5', '2', 'A', null, '张三', null, '0', null, null), ('6', '0', 'T189', '3', '张老师', null, '0', null, null), ('7', '2', 'S20150111', null, '欧阳锋', null, '0', null, null), ('8', '2', 'S20150103', '3', '洪七公', null, '0', null, null), ('9', '2', 'S20150109', '3', '黄药师', null, '0', null, null), ('10', '0', 'T006', '1', '苏轼', null, '0', null, null), ('11', '1', 'A008', '1', '赵匡胤', null, '0', null, null), ('12', '0', 'T110', '1', '曹操', null, '0', null, null), ('13', '2', 'S20150113', '3', '段智兴', null, '0', null, null), ('14', '0', 'T031', '1', '数学老师', null, '0', null, null), ('15', '0', 'T100', '1', '助理老师', null, '0', null, null);
COMMIT;

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
--  Table structure for `zm_dic`
-- ----------------------------
DROP TABLE IF EXISTS `zm_dic`;
CREATE TABLE `zm_dic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dtype` smallint(6) DEFAULT NULL,
  `did` smallint(6) DEFAULT NULL,
  `dcode` varchar(10) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `descp` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `did` (`dtype`,`did`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `zm_dic`
-- ----------------------------
BEGIN;
INSERT INTO `zm_dic` VALUES ('1', '1', '0', null, '乘用车辆类型', null), ('2', '2', '0', null, '变速箱类型', null), ('3', '1', '1', null, 'A00-微型车', null), ('4', '1', '2', 'A0', 'A0-小型车', '小型车'), ('5', '1', '3', 'A', 'A-紧凑级', null), ('6', '1', '4', 'B', 'B-中级车', null), ('7', '1', '5', 'C', 'C-豪华级', null), ('8', '1', '6', 'D', 'D-大型豪华级', null), ('9', '1', '7', 'S0', 'S0-小型SUV', null), ('10', '1', '8', 'SA', 'SA-紧凑型SUV', '紧凑型SUV'), ('11', '1', '9', 'MPV', 'MPV', '商务车'), ('12', '1', '1000', null, '其他', null), ('13', '2', '1', null, 'MT4-4速手动', null), ('14', '2', '2', null, 'MT5-5速手动', null), ('15', '2', '3', null, 'MT6-6速手动', null), ('16', '2', '4', null, 'AT4-4速自动', null), ('17', '2', '5', null, 'AT5-5速自动', null), ('18', '2', '6', null, 'AT6-6速自动', null), ('19', '2', '7', null, 'CVT', null), ('20', '2', '8', null, 'DT', null), ('21', '3', '0', null, '车身结构', null), ('22', '1', '20', 'SB', 'SB-中型SUV', null), ('23', '1', '21', 'SF', 'SF-大型SUV', null), ('24', '1', '22', 'SC', 'SC-跑车', null), ('25', '1', '23', 'SSC', 'SSC-超级跑车', null), ('26', '3', '1', null, '552-5门5座2箱', null), ('27', '3', '2', null, '552-5门5座3箱', null), ('28', '3', '3', null, '553-3门5座2箱', null), ('29', '4', '0', null, '驱动形式', null), ('30', '4', '1', null, 'FF-前置前驱', null), ('31', '4', '2', null, 'FR-前置后驱', null), ('32', '4', '3', null, 'F4-前置四驱', null), ('33', '4', '4', null, 'RR-后置后驱', null), ('34', '4', '5', null, 'MR-中置后驱', null), ('35', '4', '6', null, 'M4-中置四驱', null), ('36', '2', '1000', null, '其他', null), ('37', '3', '1000', null, null, null), ('38', '4', '1000', null, null, null), ('40', '5', '0', null, '预约和服务状态', null), ('41', '5', '1000', null, null, null), ('42', '6', '0', null, '客户类型', null), ('43', '6', '1000', null, null, null), ('44', '5', '1', null, '客户预约', null), ('45', '5', '2', null, '预约确认', null), ('46', '5', '10', null, '预约完成', null), ('47', '5', '11', null, '预约取消', null), ('48', '5', '3', null, '服务进行中', null), ('49', '7', '0', null, '客户账号状态', null), ('50', '7', '1000', null, null, null), ('51', '7', '50', null, '正常', null), ('52', '7', '1', null, '未激活', null), ('53', '7', '2', null, '验证中', null), ('54', '7', '10', null, '已禁用', null), ('55', '8', '0', null, '菜品类别', null), ('56', '8', '1000', null, 'END', null), ('58', '8', '13', null, '热炒', null), ('59', '8', '14', null, '凉菜', null), ('60', '8', '43', null, '主食', null), ('61', '8', '44', null, '配餐', null), ('62', '8', '45', null, '饮料', null), ('63', '8', '46', null, '甜品', null), ('64', '8', '15', null, '面食', null), ('65', '8', '16', null, '汤煲', null), ('66', '9', '0', null, '科目', null), ('67', '9', '1000', null, null, null), ('68', '10', '0', null, '课程模块类型', null), ('69', '10', '1', null, '序言', null), ('70', '10', '1000', null, null, null), ('71', '10', '11', null, '同步课堂', null), ('72', '10', '12', null, '自学课堂', null), ('73', '10', '9', null, '章节', null), ('74', '10', '13', null, '课程测验', null), ('75', '10', '14', null, '课程作业', null), ('76', '10', '15', null, '调查反馈', null), ('77', '9', '10', 'MH', '数学', null), ('78', '9', '11', 'CL', '语文', null), ('79', '9', '2', 'EN', '英语', null), ('80', '11', '0', null, '课程模块状态', null), ('81', '11', '1000', null, null, null), ('82', '11', '1', null, '关闭', null), ('83', '11', '2', null, '开启', null), ('84', '11', '3', null, '定时开启', null), ('85', '11', '4', null, '定时关闭', null), ('86', '11', '5', null, '定时', null), ('89', '9', '20', 'PS', '物理', ''), ('91', '9', '23', 'HT', '历史', ''), ('92', '9', '24', 'GH', '地理', ''), ('93', '9', '25', 'NT', '自然', ''), ('94', '9', '26', 'IT', '信息技术', ''), ('95', '9', '27', 'PT', '政治', ''), ('96', '12', '0', null, '题目形式', null), ('97', '12', '1000', null, null, null), ('98', '13', '0', null, '课程内容形式', null), ('99', '13', '1000', null, null, null), ('100', '12', '11', 'S', '单选题', ''), ('101', '12', '12', 'M', '多选题', ''), ('102', '12', '13', 'F', '填空题', ''), ('103', '12', '14', 'R', '排序题', ''), ('104', '13', '1', 'H', '标题', ''), ('105', '13', '2', 'T', '文本内容', ''), ('106', '13', '3', 'L', '链接内容', ''), ('107', '13', '4', 'F', '附件内容', ''), ('108', '13', '5', 'W', '网页', null), ('109', '9', '31', 'MU', '音乐', ''), ('110', '9', '32', 'SP', '体育', ''), ('111', '9', '34', 'AT', '美术', ''), ('112', '9', '35', 'PU', '公共安全', ''), ('113', '9', '21', 'MC', '化学', ''), ('114', '12', '19', 'A', '简答题', '');
COMMIT;

-- ----------------------------
--  Table structure for `zm_metas`
-- ----------------------------
DROP TABLE IF EXISTS `zm_metas`;
CREATE TABLE `zm_metas` (
  `mkey` varchar(20) NOT NULL DEFAULT '',
  `mvalue` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `zm_metas`
-- ----------------------------
BEGIN;
INSERT INTO `zm_metas` VALUES ('mkey_checks', 'A,B,D'), ('mkey_resource_path', 'http://localhost/course/'), ('mkey_share_pwd', '123');
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

-- ----------------------------
--  View structure for `v_course_logs`
-- ----------------------------
DROP VIEW IF EXISTS `v_course_logs`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_course_logs` AS select `clogs`.`id` AS `id`,`clogs`.`sclass` AS `sclass`,`sclasses`.`name` AS `sname`,`clogs`.`lesson` AS `lesson`,`lessons`.`name` AS `lname`,`clogs`.`ltype` AS `ltype`,`clogs`.`rid` AS `rid`,`clogs`.`rname` AS `rname`,`clogs`.`ltime` AS `ltime`,`clogs`.`content` AS `content`,`clogs`.`course` AS `course`,`clogs`.`tid` AS `tid`,`clogs`.`tname` AS `tname`,`clogs`.`flag` AS `flag` from ((`clogs` join `sclasses` on((`clogs`.`sclass` = `sclasses`.`id`))) join `lessons` on((`clogs`.`lesson` = `lessons`.`id`)));

-- ----------------------------
--  View structure for `v_courses`
-- ----------------------------
DROP VIEW IF EXISTS `v_courses`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_courses` AS select `courses`.`id` AS `id`,`courses`.`ccode` AS `ccode`,`courses`.`name` AS `name`,`courses`.`ccata` AS `ccata`,`courses`.`descp` AS `descp`,`zm_dic`.`name` AS `subject` from (`courses` left join `zm_dic` on((`courses`.`ccata` = `zm_dic`.`dcode`))) where (`zm_dic`.`dtype` = 9);

-- ----------------------------
--  View structure for `v_lesson_classes`
-- ----------------------------
DROP VIEW IF EXISTS `v_lesson_classes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_lesson_classes` AS select `m`.`course` AS `course`,`l`.`module` AS `module`,`l`.`sclass` AS `sclass`,`c`.`name` AS `class_name`,`l`.`status` AS `status`,`l`.`stime` AS `stime`,`l`.`etime` AS `etime`,`l`.`id` AS `lid`,`l`.`name` AS `lname` from ((`lessons` `l` left join `sclasses` `c` on((`c`.`id` = `l`.`sclass`))) left join `cmodules` `m` on((`m`.`id` = `l`.`module`))) order by `l`.`module`;

-- ----------------------------
--  View structure for `v_lessons`
-- ----------------------------
DROP VIEW IF EXISTS `v_lessons`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_lessons` AS select `m`.`name` AS `name`,`l`.`module` AS `module`,`l`.`sclass` AS `sclass`,`l`.`status` AS `status`,`l`.`stime` AS `stime`,`l`.`etime` AS `etime`,`s`.`name` AS `class_name`,`m`.`mtype` AS `mtype`,`l`.`id` AS `lesson_id`,`m`.`content` AS `content`,`m`.`morder` AS `morder`,`c`.`name` AS `cname`,`l`.`update_at` AS `update_at`,`l`.`cur_pos` AS `cur_pos` from (((`lessons` `l` left join `cmodules` `m` on((`m`.`id` = `l`.`module`))) left join `sclasses` `s` on((`s`.`id` = `l`.`sclass`))) left join `courses` `c` on((`c`.`id` = `m`.`course`))) order by `m`.`course`,`m`.`morder`;

-- ----------------------------
--  View structure for `v_reviews`
-- ----------------------------
DROP VIEW IF EXISTS `v_reviews`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reviews` AS select `r`.`uid` AS `uid`,`u`.`snumber` AS `snumber`,`u`.`name` AS `name`,`r`.`qorder` AS `qorder`,`r`.`mid` AS `mid`,`m`.`mtype` AS `mtype`,`m`.`content` AS `content`,`r`.`answer` AS `answer`,`r`.`score` AS `score`,`r`.`status` AS `status`,`r`.`rnote` AS `rnote` from ((`sreports` `r` left join `cmodules` `m` on((`m`.`id` = `r`.`mid`))) left join `susers` `u` on((`u`.`id` = `r`.`uid`)));

-- ----------------------------
--  View structure for `v_sclasses`
-- ----------------------------
DROP VIEW IF EXISTS `v_sclasses`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_sclasses` AS select `c1`.`id` AS `id`,`c1`.`scode` AS `scode`,`c1`.`name` AS `name`,`c1`.`address` AS `address`,`c1`.`gyear` AS `gyear`,`c1`.`pid` AS `pid`,`c2`.`name` AS `sname` from (`sclasses` `c1` left join `sclasses` `c2` on((`c1`.`pid` = `c2`.`id`))) where (`c1`.`utype` = 2) order by `c1`.`pid`;

-- ----------------------------
--  Procedure structure for `p_mitem_order`
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_mitem_order`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_mitem_order`(in_mid int, in_qorder int)
IF (select count(*)>0  from moduleitems where module=in_mid and qorder=in_qorder limit 1) THEN

update moduleitems set qorder=qorder+1 where module=in_mid and qorder>=in_qorder;

END IF
 ;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
