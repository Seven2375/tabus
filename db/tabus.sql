/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : localhost:3306
 Source Schema         : tabus

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 07/05/2025 16:36:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for classroom_analysis
-- ----------------------------
DROP TABLE IF EXISTS `classroom_analysis`;
CREATE TABLE `classroom_analysis`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL COMMENT '关联课程ID',
  `student_raise_rate` double NULL DEFAULT NULL COMMENT '学生抬头率（百分比）',
  `student_lower_rate` double NULL DEFAULT NULL COMMENT '学生低头率（百分比）',
  `teacher_happiness_avg` double NULL DEFAULT NULL COMMENT '教师高兴值均值',
  `teacher_anger_avg` double NULL DEFAULT NULL COMMENT '教师愤怒值均值',
  `teacher_neutral_avg` double NULL DEFAULT NULL COMMENT '教师平静值均值',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id` ASC) USING BTREE,
  CONSTRAINT `classroom_analysis_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课堂分析数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classroom_analysis
-- ----------------------------

-- ----------------------------
-- Table structure for course_info
-- ----------------------------
DROP TABLE IF EXISTS `course_info`;
CREATE TABLE `course_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `teacher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教师姓名',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `class` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '班级（如“高三1班”）',
  `start_time` datetime NOT NULL COMMENT '课程开始时间',
  `end_time` datetime NOT NULL COMMENT '课程结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程基本信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course_info
-- ----------------------------

-- ----------------------------
-- Table structure for discussion_text
-- ----------------------------
DROP TABLE IF EXISTS `discussion_text`;
CREATE TABLE `discussion_text`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL COMMENT '关联课程ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '讨论内容（如学生发言）',
  `timestamp` datetime NOT NULL COMMENT '发言时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id` ASC) USING BTREE,
  CONSTRAINT `discussion_text_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课堂讨论文本表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discussion_text
-- ----------------------------

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
  `course_id` bigint NULL DEFAULT NULL COMMENT '关联课程ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '记录类型（student/teacher）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_request_id`(`request_id` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '表情识别表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emotion_record
-- ----------------------------
INSERT INTO `emotion_record` VALUES (1, '1745492787,a10049ab-ad7f-4c27-8a84-9800c36df337', '4ImRc5pH4re5jiFMKCPJmQ==', '857d9c5f3e52770bf2e007499c4a31b0', 0.008, 0.008, 0.008, 0.453, 71.37, 28.074, 0.08, '2025-04-24 19:06:25', NULL, NULL);
INSERT INTO `emotion_record` VALUES (2, '1745492823,14628a63-c28b-42a9-bab4-2a340c99f3f3', '4ImRc5pH4re5jiFMKCPJmQ==', 'ec154c8cc166b3f69855ce2a312e8083', 0.008, 0.008, 0.008, 0.453, 71.37, 28.074, 0.08, '2025-04-24 19:07:01', NULL, NULL);
INSERT INTO `emotion_record` VALUES (3, '1745672937,bb10fc1c-1e90-4e93-9b0b-2514511fa3db', 'HFVUik7aMDDfk303RWb0kw==', 'a956f40b6f4c703e1a45b1cf8a835502', 0.001, 0.001, 0.001, 0.018, 95.625, 0.097, 4.257, '2025-04-26 21:08:58', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
