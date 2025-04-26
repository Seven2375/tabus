/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : localhost:3306
 Source Schema         : tabus

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 26/04/2025 21:03:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for emotion_record
-- ----------------------------
DROP TABLE IF EXISTS `emotion_record`;
CREATE TABLE `emotion_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `request_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `face_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `anger` double NULL DEFAULT NULL,
  `disgust` double NULL DEFAULT NULL,
  `fear` double NULL DEFAULT NULL,
  `happiness` double NULL DEFAULT NULL,
  `neutral` double NULL DEFAULT NULL,
  `sadness` double NULL DEFAULT NULL,
  `surprise` double NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_request_id`(`request_id` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emotion_record
-- ----------------------------
INSERT INTO `emotion_record` VALUES (1, '1745492787,a10049ab-ad7f-4c27-8a84-9800c36df337', '4ImRc5pH4re5jiFMKCPJmQ==', '857d9c5f3e52770bf2e007499c4a31b0', 0.008, 0.008, 0.008, 0.453, 71.37, 28.074, 0.08, '2025-04-24 19:06:25');
INSERT INTO `emotion_record` VALUES (2, '1745492823,14628a63-c28b-42a9-bab4-2a340c99f3f3', '4ImRc5pH4re5jiFMKCPJmQ==', 'ec154c8cc166b3f69855ce2a312e8083', 0.008, 0.008, 0.008, 0.453, 71.37, 28.074, 0.08, '2025-04-24 19:07:01');

SET FOREIGN_KEY_CHECKS = 1;
