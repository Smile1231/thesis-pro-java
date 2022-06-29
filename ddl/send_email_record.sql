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

 Date: 29/06/2022 23:41:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for send_email_record
-- ----------------------------
DROP TABLE IF EXISTS `send_email_record`;
CREATE TABLE `send_email_record` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮件发送人',
  `to` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮件接受人',
  `subject` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮件主题',
  `text` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮件内容',
  `cc` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '抄送',
  `bcc` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密送',
  `status` tinyint NOT NULL COMMENT '0 - ok , 1 - fail',
  `error` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '报错信息',
  `send_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `computation_directory` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '计算文件夹路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
