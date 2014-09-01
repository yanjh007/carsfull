/*
 Navicat Premium Data Transfer

 Source Server         : iosdb
 Source Server Type    : SQLite
 Source Server Version : 3007015
 Source Database       : main

 Target Server Type    : SQLite
 Target Server Version : 3007015
 File Encoding         : utf-8

 Date: 09/02/2014 01:18:28 AM
*/

PRAGMA foreign_keys = false;

-- ----------------------------
--  Table structure for "_meta"
-- ----------------------------
DROP TABLE IF EXISTS "_meta";
CREATE TABLE _meta (mname string PRIMARY KEY, mvalue text);

-- ----------------------------
--  Records of "main"."_meta"
-- ----------------------------
BEGIN;
INSERT INTO "_meta" VALUES (X'646276657273696f6e', 2);
COMMIT;

-- ----------------------------
--  Table structure for "appointments"
-- ----------------------------
DROP TABLE IF EXISTS "appointments";
CREATE TABLE appointments (acode string, create_at datetime, plan_at datetime, car string, shop string, status int);

-- ----------------------------
--  Records of "main"."appointments"
-- ----------------------------
BEGIN;
INSERT INTO "appointments" VALUES (X'41303630353732313334', X'323031342d30392d30312032323a33373a3333', X'323031342d30392d30312032323a33373a3333', X'43412d3031353744', null, null);
INSERT INTO "appointments" VALUES (X'41343835353732313334', X'323031342d30392d30312032323a34363a3231', X'323031342d30392d30312032323a34363a3231', X'43412d3031353744', null, null);
COMMIT;

-- ----------------------------
--  Table structure for "brands"
-- ----------------------------
DROP TABLE IF EXISTS "brands";
CREATE TABLE brands (brand string, brand_sn string PRIMARY KEY, edit_at datetime);

-- ----------------------------
--  Table structure for "cars"
-- ----------------------------
DROP TABLE IF EXISTS "cars";
CREATE TABLE cars (carid int, carnumber string PRIMARY KEY, framenumber string, enginenumber string, brand string, brand_sn string);

-- ----------------------------
--  Records of "main"."cars"
-- ----------------------------
BEGIN;
INSERT INTO "cars" VALUES (null, X'43412d3031353744', X'38393937302d30383737', null, null, null);
COMMIT;

PRAGMA foreign_keys = true;
