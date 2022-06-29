/*
 Navicat MySQL Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : thesispro

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 29/06/2022 23:42:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for submit_record_info
-- ----------------------------
DROP TABLE IF EXISTS `submit_record_info`;
CREATE TABLE `submit_record_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `file_url` json NOT NULL COMMENT 'URL信息JSON',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
