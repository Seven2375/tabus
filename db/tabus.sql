/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50741
 Source Host           : localhost:3306
 Source Schema         : tabus

 Target Server Type    : MySQL
 Target Server Version : 50741
 File Encoding         : 65001

 Date: 21/05/2025 16:25:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for classroom_analysis
-- ----------------------------
DROP TABLE IF EXISTS `classroom_analysis`;
CREATE TABLE `classroom_analysis`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) NOT NULL COMMENT '关联课程ID',
  `student_raise_rate` double NULL DEFAULT NULL COMMENT '学生抬头率（百分比）',
  `student_lower_rate` double NULL DEFAULT NULL COMMENT '学生低头率（百分比）',
  `teacher_happiness_avg` double NULL DEFAULT NULL COMMENT '教师高兴值均值',
  `teacher_anger_avg` double NULL DEFAULT NULL COMMENT '教师愤怒值均值',
  `teacher_neutral_avg` double NULL DEFAULT NULL COMMENT '教师平静值均值',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `classroom_analysis_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课堂分析数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classroom_analysis
-- ----------------------------
INSERT INTO `classroom_analysis` VALUES (1, 2, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);
INSERT INTO `classroom_analysis` VALUES (4, 4, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);
INSERT INTO `classroom_analysis` VALUES (5, 6, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (6, 6, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (7, 11, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);
INSERT INTO `classroom_analysis` VALUES (8, 12, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (9, 12, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (10, 12, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (11, 12, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (12, 12, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (13, 12, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (14, 14, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (15, 14, 0, 100, 0, 0, 0);
INSERT INTO `classroom_analysis` VALUES (16, 15, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);
INSERT INTO `classroom_analysis` VALUES (17, 16, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);
INSERT INTO `classroom_analysis` VALUES (18, 20, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);
INSERT INTO `classroom_analysis` VALUES (19, 21, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);

-- ----------------------------
-- Table structure for course_info
-- ----------------------------
DROP TABLE IF EXISTS `course_info`;
CREATE TABLE `course_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `teacher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '教师姓名',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `class_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班级（如“高三1班”）',
  `start_time` datetime NOT NULL COMMENT '课程开始时间',
  `end_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '课程结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课程基本信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course_info
-- ----------------------------
INSERT INTO `course_info` VALUES (1, '朱凯', '肉饼制作实验课', '高二3班', '2025-05-14 16:25:43', '2025-05-14 16:40:56');
INSERT INTO `course_info` VALUES (2, '朱凯小哥哥', '肉饼制作实验课', '高二3班', '2025-05-14 16:34:38', '2025-05-14 17:10:03');
INSERT INTO `course_info` VALUES (3, '朱凯老师', '汉堡肉片实验课', '中专3班', '2025-05-14 19:59:55', '2025-05-14 19:59:54');
INSERT INTO `course_info` VALUES (4, '学哥', '汉堡配菜发明课', '本生砖3班', '2025-05-14 21:17:57', '2025-05-14 21:30:41');
INSERT INTO `course_info` VALUES (5, '王老师', '123', '本生砖3班', '2025-05-21 15:05:52', '2025-05-21 15:05:52');
INSERT INTO `course_info` VALUES (6, '学哥', '123', '本生砖2班', '2025-05-21 15:07:29', '2025-05-21 15:07:54');
INSERT INTO `course_info` VALUES (7, '张老师', '123', '计算机科学1班', '2025-05-21 15:10:05', '2025-05-21 15:10:05');
INSERT INTO `course_info` VALUES (8, '李老师', '123', '本生砖3班', '2025-05-21 15:19:31', '2025-05-21 15:19:31');
INSERT INTO `course_info` VALUES (9, '学哥', '123', '本生砖3班', '2025-05-21 15:20:07', '2025-05-21 15:20:07');
INSERT INTO `course_info` VALUES (10, '李老师', '123', '本生砖3班', '2025-05-21 15:33:56', '2025-05-21 15:33:56');
INSERT INTO `course_info` VALUES (11, '王老师', '123', '本生砖3班', '2025-05-21 15:44:46', '2025-05-21 15:45:54');
INSERT INTO `course_info` VALUES (12, '学哥', '123', '本生砖3班', '2025-05-21 15:53:29', '2025-05-21 15:54:07');
INSERT INTO `course_info` VALUES (13, '李老师', '123', '本生砖3班', '2025-05-21 15:54:36', '2025-05-21 15:54:35');
INSERT INTO `course_info` VALUES (14, '李老师', '123', '本生砖2班', '2025-05-21 15:58:46', '2025-05-21 16:00:05');
INSERT INTO `course_info` VALUES (15, '张老师', '123', '本生砖2班', '2025-05-21 16:01:54', '2025-05-21 16:02:32');
INSERT INTO `course_info` VALUES (16, '李老师', '123', '本生砖2班', '2025-05-21 16:03:12', '2025-05-21 16:03:41');
INSERT INTO `course_info` VALUES (17, '学哥', '123', '本生砖2班', '2025-05-21 16:08:34', '2025-05-21 16:08:33');
INSERT INTO `course_info` VALUES (18, '张老师', '123', '本生砖2班', '2025-05-21 16:10:51', '2025-05-21 16:10:50');
INSERT INTO `course_info` VALUES (19, '李老师', '123', '本生砖2班', '2025-05-21 16:14:33', '2025-05-21 16:14:32');
INSERT INTO `course_info` VALUES (20, '李老师', '123', '本生砖1班', '2025-05-21 16:15:28', '2025-05-21 16:16:05');
INSERT INTO `course_info` VALUES (21, '王老师', '123', '本生砖1班', '2025-05-21 16:23:53', '2025-05-21 16:24:27');

-- ----------------------------
-- Table structure for discussion_text
-- ----------------------------
DROP TABLE IF EXISTS `discussion_text`;
CREATE TABLE `discussion_text`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) NOT NULL COMMENT '关联课程ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '讨论内容（如学生发言）',
  `timestamp` datetime NOT NULL COMMENT '发言时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id`) USING BTREE,
  CONSTRAINT `discussion_text_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '课堂讨论文本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discussion_text
-- ----------------------------

-- ----------------------------
-- Table structure for emotion_record
-- ----------------------------
DROP TABLE IF EXISTS `emotion_record`;
CREATE TABLE `emotion_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `request_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `face_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `anger` double NULL DEFAULT NULL,
  `disgust` double NULL DEFAULT NULL,
  `fear` double NULL DEFAULT NULL,
  `happiness` double NULL DEFAULT NULL,
  `neutral` double NULL DEFAULT NULL,
  `sadness` double NULL DEFAULT NULL,
  `surprise` double NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `course_id` bigint(20) NULL DEFAULT NULL COMMENT '关联课程ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '记录类型（student/teacher）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_request_id`(`request_id`) USING BTREE,
  INDEX `idx_created_at`(`created_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 313 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '表情识别表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emotion_record
-- ----------------------------
INSERT INTO `emotion_record` VALUES (1, '1745492787,a10049ab-ad7f-4c27-8a84-9800c36df337', '4ImRc5pH4re5jiFMKCPJmQ==', '857d9c5f3e52770bf2e007499c4a31b0', 0.008, 0.008, 0.008, 0.453, 71.37, 28.074, 0.08, '2025-04-24 19:06:25', NULL, NULL);
INSERT INTO `emotion_record` VALUES (2, '1745492823,14628a63-c28b-42a9-bab4-2a340c99f3f3', '4ImRc5pH4re5jiFMKCPJmQ==', 'ec154c8cc166b3f69855ce2a312e8083', 0.008, 0.008, 0.008, 0.453, 71.37, 28.074, 0.08, '2025-04-24 19:07:01', NULL, NULL);
INSERT INTO `emotion_record` VALUES (3, '1745672937,bb10fc1c-1e90-4e93-9b0b-2514511fa3db', 'HFVUik7aMDDfk303RWb0kw==', 'a956f40b6f4c703e1a45b1cf8a835502', 0.001, 0.001, 0.001, 0.018, 95.625, 0.097, 4.257, '2025-04-26 21:08:58', NULL, NULL);
INSERT INTO `emotion_record` VALUES (4, '1747213633,f80e829f-c0c0-4f23-8dec-e9990ad64d6e', 'ddlsZhKVYeg+K5D11KVUDA==', 'bdfcdfb171ff61dd953f6af6fbccf3ad', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-14 17:07:14', 2, 'student');
INSERT INTO `emotion_record` VALUES (5, '1747213635,0c5c8b6c-a0de-4175-b33e-f351af549d2e', '85UUoqxyZdJmxjZR2TgiHw==', 'c187f7f1e8104085c84be92270d5b7de', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-14 17:07:16', 2, 'student');
INSERT INTO `emotion_record` VALUES (6, '1747213637,57af020a-8901-439e-b3c6-1fceb3490e33', 'dn+KEYZ/jDHdQRaLjZAvqA==', '4834a234033670ade8558649008b909f', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-14 17:07:17', 2, 'student');
INSERT INTO `emotion_record` VALUES (7, '1747213638,3597eb92-b6ad-4ade-b6eb-5af2b80218df', '/t1D8nO+t9aR6rezEf1HxA==', '1a6617be135760fd87627aaefc6200f8', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-14 17:07:18', 2, 'student');
INSERT INTO `emotion_record` VALUES (8, '1747213640,0f72f906-d565-4b10-9787-8a7b718052c6', 'Vdd24M+86gPRWXCrrgtzeA==', 'f1c841df473b59ad021bb52fd773e733', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-14 17:07:20', 2, 'student');
INSERT INTO `emotion_record` VALUES (9, '1747213640,0f72f906-d565-4b10-9787-8a7b718052c6', 'Vdd24M+86gPRWXCrrgtzeA==', '3b6903a4784720dcb5685044b793c02a', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-14 17:07:20', 2, 'student');
INSERT INTO `emotion_record` VALUES (10, '1747213641,a031b2fc-1e02-4778-9d27-5abce063989b', 'WUe5ibWtbKvoRBiXwLusUA==', '3ba9a9678dcaa6a0c790ab64a81302dc', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-14 17:07:21', 2, 'student');
INSERT INTO `emotion_record` VALUES (11, '1747213641,a031b2fc-1e02-4778-9d27-5abce063989b', 'WUe5ibWtbKvoRBiXwLusUA==', '17ab04a3508ae7d8aa6cecfa675644bf', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-14 17:07:21', 2, 'student');
INSERT INTO `emotion_record` VALUES (12, '1747213641,a031b2fc-1e02-4778-9d27-5abce063989b', 'WUe5ibWtbKvoRBiXwLusUA==', 'b3e51aed44dd09b8487c2ceb4b53743f', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-14 17:07:21', 2, 'student');
INSERT INTO `emotion_record` VALUES (13, '1747213643,3bcc7fb6-733a-4cb8-b04e-6fd96683721f', '5wMkry20WsFtVLxZDNriGQ==', '5c91a5d13b2430060e2018bf8b786f03', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-14 17:07:23', 2, 'student');
INSERT INTO `emotion_record` VALUES (14, '1747213643,3bcc7fb6-733a-4cb8-b04e-6fd96683721f', '5wMkry20WsFtVLxZDNriGQ==', '2e3825e8ee79a6b610afb634baba136e', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-14 17:07:23', 2, 'student');
INSERT INTO `emotion_record` VALUES (15, '1747213645,e495951c-dcee-4151-8928-5a6587f29a8d', 'r9B/MNGuxPIGsTJxraxtFw==', 'a775ab1eab25f9d7692fc812733ff5cc', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-14 17:07:26', 2, 'student');
INSERT INTO `emotion_record` VALUES (16, '1747213645,e495951c-dcee-4151-8928-5a6587f29a8d', 'r9B/MNGuxPIGsTJxraxtFw==', 'f4901c5f5fb28c681a4fc39d512c8b50', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-14 17:07:26', 2, 'student');
INSERT INTO `emotion_record` VALUES (17, '1747213645,e495951c-dcee-4151-8928-5a6587f29a8d', 'r9B/MNGuxPIGsTJxraxtFw==', 'ee8aa5272498e910bfe7dce2db30a657', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-14 17:07:26', 2, 'student');
INSERT INTO `emotion_record` VALUES (18, '1747213647,671bd095-ab25-4166-85f5-b5299dd8a112', 'aAlO3myLwMb17o1QWeG5PQ==', '06c45b92a702741903b9c85b425e7ae3', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-14 17:07:27', 2, 'student');
INSERT INTO `emotion_record` VALUES (19, '1747213647,671bd095-ab25-4166-85f5-b5299dd8a112', 'aAlO3myLwMb17o1QWeG5PQ==', 'e280fea870cbcef0a313e6f3b9c62c5d', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-14 17:07:27', 2, 'student');
INSERT INTO `emotion_record` VALUES (20, '1747213647,671bd095-ab25-4166-85f5-b5299dd8a112', 'aAlO3myLwMb17o1QWeG5PQ==', '0bc7bf24baca6801c42838ddc6c9bed9', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-14 17:07:27', 2, 'student');
INSERT INTO `emotion_record` VALUES (21, '1747213649,36afa552-4458-481f-9cfb-7fcb72444666', '+5oKVJB240YGj018Rk2SWQ==', 'cd5646bc3c1cc28dacd1f59953994b98', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-14 17:07:29', 2, 'student');
INSERT INTO `emotion_record` VALUES (22, '1747213649,36afa552-4458-481f-9cfb-7fcb72444666', '+5oKVJB240YGj018Rk2SWQ==', 'b9387c37200ad6ca322ed4b176130635', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-14 17:07:29', 2, 'student');
INSERT INTO `emotion_record` VALUES (23, '1747213649,36afa552-4458-481f-9cfb-7fcb72444666', '+5oKVJB240YGj018Rk2SWQ==', '34def896f4029897a439669d442b81a1', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-14 17:07:29', 2, 'student');
INSERT INTO `emotion_record` VALUES (24, '1747213649,36afa552-4458-481f-9cfb-7fcb72444666', '+5oKVJB240YGj018Rk2SWQ==', 'fa20fe2ce8cc4b84475e8a02560b2f3b', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-14 17:07:29', 2, 'student');
INSERT INTO `emotion_record` VALUES (25, '1747213706,782722de-569b-445b-9d81-b3771d9a316b', 'tV9yywN3KMrMMA+DbvWfwg==', '0a1d7050e59bbabf5c98a084ffc4c14c', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-14 17:08:26', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (26, '1747213707,4200193d-b4ef-47cc-9674-504ee2592c6b', '/sktHVxs7MomhjCYYAA+5A==', '84395669841ba370c8ef3ec951d78403', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-14 17:08:27', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (27, '1747213707,0ac6beb7-f52d-4f92-8bd3-28f15d3add72', 'hC1DF+oNhYaq8L5uyCtRoQ==', 'ae068a651173b3918fe969d61da5be90', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-14 17:08:27', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (28, '1747213708,10aaba0e-a308-4a78-9bcc-dc22fc4d8228', 'VCgRTBs9igv/X6k0Sxo9VQ==', 'c7c42a90cbe3dfabed2358eaf6f62034', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-14 17:08:28', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (29, '1747213708,c35cfd38-5373-4183-ae72-6f2112283c2d', 'fEGbK1dXHzaaYoUXZrdzwQ==', 'd47397d5173be56888f7a13a98976e35', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-14 17:08:28', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (30, '1747213709,584816e8-c7c1-4cd8-822a-1780de8e79ee', '6XvArDX6AhhmB4kWdnkm6w==', 'bc82a6ea586bb07e693fafb783db2bb8', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-14 17:08:29', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (31, '1747213710,8915150e-119f-440b-b2a6-c5f5b64bf846', 'C6c8B4IN2Lfh5qT35qQAKg==', 'a33ccb7e7840094d6c5bdc494cf29f15', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-14 17:08:30', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (32, '1747213710,b794b3d7-c30a-4578-9846-8ace77881feb', 'XIlfm8adpMpBBBTaa+QK9A==', 'cdff8121b677e6782d3debf65a10562d', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-14 17:08:30', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (33, '1747213711,453d8ab1-dfb3-41f7-8c06-6823e559430c', 'Z9nrEm2bJmjE5W8xEtcskw==', '205b5fd947eb87854a3754d3fdd13033', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-14 17:08:31', 2, 'teacher');
INSERT INTO `emotion_record` VALUES (34, '1747229268,33ebe85d-37e2-4337-bb88-dd00096344ae', 'ddlsZhKVYeg+K5D11KVUDA==', 'a867c701103dd3a93dc461f288059ad2', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-14 21:27:49', 4, 'student');
INSERT INTO `emotion_record` VALUES (35, '1747229270,579f463f-4428-43a1-aaf1-d6c603d3112c', '85UUoqxyZdJmxjZR2TgiHw==', '922378c7e07d3744bbba577623b167ee', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-14 21:27:50', 4, 'student');
INSERT INTO `emotion_record` VALUES (36, '1747229272,732a83fb-2744-4b7f-bbc2-774744845b8a', 'dn+KEYZ/jDHdQRaLjZAvqA==', '7939f555a960c39a7edf6805c35b3467', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-14 21:27:52', 4, 'student');
INSERT INTO `emotion_record` VALUES (37, '1747229274,cf567348-4117-4921-9002-bb6627977a80', '/t1D8nO+t9aR6rezEf1HxA==', '69f64cb05ab6048679cde549ff9a9194', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-14 21:27:54', 4, 'student');
INSERT INTO `emotion_record` VALUES (38, '1747229276,6f2ee399-2f78-48a3-8288-d8b955f50b74', 'Vdd24M+86gPRWXCrrgtzeA==', 'adae34754a0d7383fc95ff817c9d871b', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-14 21:27:56', 4, 'student');
INSERT INTO `emotion_record` VALUES (39, '1747229276,6f2ee399-2f78-48a3-8288-d8b955f50b74', 'Vdd24M+86gPRWXCrrgtzeA==', 'e9f05d6b3ea0bdc51b74504709d099e8', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-14 21:27:56', 4, 'student');
INSERT INTO `emotion_record` VALUES (40, '1747229277,43c7056c-53d9-4b6c-937c-3c006979a35c', 'WUe5ibWtbKvoRBiXwLusUA==', 'b8c994d73dc6f9b79a91eeea42678272', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-14 21:27:58', 4, 'student');
INSERT INTO `emotion_record` VALUES (41, '1747229277,43c7056c-53d9-4b6c-937c-3c006979a35c', 'WUe5ibWtbKvoRBiXwLusUA==', 'fcad54e29f76f425a1880ad6f221ef34', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-14 21:27:58', 4, 'student');
INSERT INTO `emotion_record` VALUES (42, '1747229277,43c7056c-53d9-4b6c-937c-3c006979a35c', 'WUe5ibWtbKvoRBiXwLusUA==', '195f75ff7e5ff2c49099d85e714579da', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-14 21:27:58', 4, 'student');
INSERT INTO `emotion_record` VALUES (43, '1747229279,302c3f61-fa35-48a6-8660-22d5f01733ef', '5wMkry20WsFtVLxZDNriGQ==', 'd872ca04938b76f3411014fc17b4fcec', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-14 21:27:59', 4, 'student');
INSERT INTO `emotion_record` VALUES (44, '1747229279,302c3f61-fa35-48a6-8660-22d5f01733ef', '5wMkry20WsFtVLxZDNriGQ==', 'a417b009fa4d6eece2703b46776097d8', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-14 21:27:59', 4, 'student');
INSERT INTO `emotion_record` VALUES (45, '1747229283,a1c6a5e9-c30c-474d-b0b3-01680bd17cfb', 'r9B/MNGuxPIGsTJxraxtFw==', 'f86b4b4f3e20ec7bed974b086f32e8d1', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-14 21:28:03', 4, 'student');
INSERT INTO `emotion_record` VALUES (46, '1747229283,a1c6a5e9-c30c-474d-b0b3-01680bd17cfb', 'r9B/MNGuxPIGsTJxraxtFw==', '7bb52029bb9a026242fcf6e33d925ff1', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-14 21:28:03', 4, 'student');
INSERT INTO `emotion_record` VALUES (47, '1747229283,a1c6a5e9-c30c-474d-b0b3-01680bd17cfb', 'r9B/MNGuxPIGsTJxraxtFw==', '9ebf65b53a90a9dba7554e8b9fdd608b', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-14 21:28:03', 4, 'student');
INSERT INTO `emotion_record` VALUES (48, '1747229285,3721d0f5-0b74-49b7-b29e-89e519d9922e', 'aAlO3myLwMb17o1QWeG5PQ==', '45a44c12217d72b172a2935836758c99', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-14 21:28:05', 4, 'student');
INSERT INTO `emotion_record` VALUES (49, '1747229285,3721d0f5-0b74-49b7-b29e-89e519d9922e', 'aAlO3myLwMb17o1QWeG5PQ==', 'c2f2dd5781bccb05f8ca42322207eb8d', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-14 21:28:05', 4, 'student');
INSERT INTO `emotion_record` VALUES (50, '1747229285,3721d0f5-0b74-49b7-b29e-89e519d9922e', 'aAlO3myLwMb17o1QWeG5PQ==', '363a76e7ffa3f0d5aedee928b97bda7d', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-14 21:28:05', 4, 'student');
INSERT INTO `emotion_record` VALUES (51, '1747229287,b33d862f-b963-4307-a4fb-2794daaafa6a', '+5oKVJB240YGj018Rk2SWQ==', '72221b04a5a1eb5928dd06694194aa33', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-14 21:28:07', 4, 'student');
INSERT INTO `emotion_record` VALUES (52, '1747229287,b33d862f-b963-4307-a4fb-2794daaafa6a', '+5oKVJB240YGj018Rk2SWQ==', '3da7d0cb8dd128d41b8af0b3b4848795', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-14 21:28:07', 4, 'student');
INSERT INTO `emotion_record` VALUES (53, '1747229287,b33d862f-b963-4307-a4fb-2794daaafa6a', '+5oKVJB240YGj018Rk2SWQ==', 'eb1a29f4149e3fd1007613ece46977d2', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-14 21:28:07', 4, 'student');
INSERT INTO `emotion_record` VALUES (54, '1747229287,b33d862f-b963-4307-a4fb-2794daaafa6a', '+5oKVJB240YGj018Rk2SWQ==', '62fd4c29374102e450831b2dec3b558f', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-14 21:28:07', 4, 'student');
INSERT INTO `emotion_record` VALUES (55, '1747229425,24ddaee5-29a8-4cee-aa69-98dcf565b4ba', 'tV9yywN3KMrMMA+DbvWfwg==', 'a8082da8b1b26e16c977becf3e22502d', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-14 21:30:25', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (56, '1747229426,d6eb86f6-4fcd-4144-8228-89a6439025e1', '/sktHVxs7MomhjCYYAA+5A==', '2947838769cee3b891b6da945c75b1d6', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-14 21:30:26', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (57, '1747229427,3465d09e-9de4-46b5-9df5-5bc861668529', 'hC1DF+oNhYaq8L5uyCtRoQ==', '7b3d10ccc7a72ad6075e14a91a375be7', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-14 21:30:26', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (58, '1747229427,4f2c879b-5242-4d39-9bd0-c2af43f4ba9c', 'VCgRTBs9igv/X6k0Sxo9VQ==', '5604eab5ec2935202bced16933d6da0c', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-14 21:30:27', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (59, '1747229428,cf91cdea-e96e-4508-9232-6724e2d8696a', 'fEGbK1dXHzaaYoUXZrdzwQ==', 'adeecd8e21fbe9d073d152bdb678af68', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-14 21:30:28', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (60, '1747229428,635b25b8-8e1e-4d70-89b7-dd3ce64b8828', '6XvArDX6AhhmB4kWdnkm6w==', '52cc201b0bb2e1aab47d6648c3d27fce', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-14 21:30:28', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (61, '1747229430,d0797ee0-45f0-4b53-bfcf-d55eace1e3d3', 'C6c8B4IN2Lfh5qT35qQAKg==', 'de9399c0f197649db6144e7b196c11e2', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-14 21:30:29', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (62, '1747229430,61dc7dd0-7e7b-4363-a730-b992cde340bc', 'XIlfm8adpMpBBBTaa+QK9A==', 'de34bdccf576086b2e0b53146837d847', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-14 21:30:30', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (63, '1747229431,cad97109-7ba4-4cfd-8b87-6f238e8e8c0b', 'Z9nrEm2bJmjE5W8xEtcskw==', '7bc7b3e2d0e824269a245477f7cbbde4', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-14 21:30:31', 4, 'teacher');
INSERT INTO `emotion_record` VALUES (64, '1747813471,64f97152-456c-4679-ad31-e8b6ef7ae67d', 'tV9yywN3KMrMMA+DbvWfwg==', '36be5042c053463169c18f512f8b2bd3', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 15:44:30', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (65, '1747813472,ae127de5-145a-4a93-9fb8-5910a26865d2', '/sktHVxs7MomhjCYYAA+5A==', '889def305d466588c88d7d26550956a4', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 15:44:31', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (66, '1747813472,4aceab58-7753-4269-906c-19178cb55c1c', 'hC1DF+oNhYaq8L5uyCtRoQ==', 'ff1180808d85e367db2de4b8daa58797', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 15:44:31', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (67, '1747813473,777c2b69-2b53-4675-b09f-9ae9a30ad587', 'VCgRTBs9igv/X6k0Sxo9VQ==', '108a8d97b61d925a0ff6e858f730ce92', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 15:44:33', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (68, '1747813474,950c13b3-0a65-4ea0-ac4e-53589bee4831', 'fEGbK1dXHzaaYoUXZrdzwQ==', '512c3ddf8191014315b0efaf0d82dcd8', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 15:44:33', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (69, '1747813474,e2a990c9-5921-4dce-b3db-427de2d28755', '6XvArDX6AhhmB4kWdnkm6w==', '3d73dfb4ddbd4119e39f59b20ef233d8', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 15:44:34', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (70, '1747813475,f5a908e0-0a63-4dfa-b20d-0eca2d57e498', 'C6c8B4IN2Lfh5qT35qQAKg==', '103a94e92a26fd56dc413fbf9441a189', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 15:44:35', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (71, '1747813476,83c843d1-eaf6-489c-959c-cac1a6c5ed35', 'XIlfm8adpMpBBBTaa+QK9A==', 'e4f2b03baab32ed8202341b16cbbc17e', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 15:44:35', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (72, '1747813476,b8156ef3-5fe9-4873-ad92-9ce375f0c287', 'Z9nrEm2bJmjE5W8xEtcskw==', '5b8f2e584320443943b475a8fb8b344b', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 15:44:36', 10, 'teacher');
INSERT INTO `emotion_record` VALUES (73, '1747813494,2de0e551-7160-4081-967c-cea5f14026aa', 'tV9yywN3KMrMMA+DbvWfwg==', '6b4dedc800c9aa54ab2d99c870b67fcb', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 15:44:53', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (74, '1747813494,637b233f-47f3-4f33-8686-b9ef02b11ae5', '/sktHVxs7MomhjCYYAA+5A==', 'aab72ef5b0b07ed9eabb20fdbc4124dc', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 15:44:54', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (75, '1747813495,f94f0d10-fde3-46b9-8f29-0c931872dd60', 'hC1DF+oNhYaq8L5uyCtRoQ==', '4ec0a3dee86d4796113dbb1085699551', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 15:44:54', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (76, '1747813495,8afcd9dc-4c1d-4c9c-9217-756241c58256', 'VCgRTBs9igv/X6k0Sxo9VQ==', '639a442b7342f0da3ce3209e0e501c4c', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 15:44:54', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (77, '1747813496,ae4a5dcc-af2d-4bc7-9d26-a461fc021068', 'fEGbK1dXHzaaYoUXZrdzwQ==', '785504c230e90647dbdf434427a750d9', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 15:44:55', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (78, '1747813496,d1bd31c9-16ea-4301-b5a7-1193c9233a41', '6XvArDX6AhhmB4kWdnkm6w==', 'b69466e71accc722434f45af06f2b171', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 15:44:55', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (79, '1747813497,2391480f-bffd-4e9f-9e1b-7c14765eb506', 'C6c8B4IN2Lfh5qT35qQAKg==', 'd6c39fdfe9fc1fa5e0b67ca08f1a57bb', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 15:44:57', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (80, '1747813498,99257dd8-77cc-488f-bfb4-bce6c4234771', 'XIlfm8adpMpBBBTaa+QK9A==', 'df0c5b6c2dea93db5db3bc6217339522', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 15:44:57', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (81, '1747813498,c6688e49-7189-4779-b5ce-66e55877dd9a', 'Z9nrEm2bJmjE5W8xEtcskw==', '6dfb5ff4d8660491b6fd73dd24f096d1', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 15:44:58', 11, 'teacher');
INSERT INTO `emotion_record` VALUES (82, '1747813499,df8e38c5-7b98-465a-a7fd-8e3c1893f283', 'ddlsZhKVYeg+K5D11KVUDA==', '7559a2b57505b1ddbc453f6d991d4c74', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 15:44:59', 11, 'student');
INSERT INTO `emotion_record` VALUES (83, '1747813501,034ce693-ce9b-467d-96ba-3fe51bb42049', '85UUoqxyZdJmxjZR2TgiHw==', '74251ace5d63b12b2cdce53c91804dee', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 15:45:00', 11, 'student');
INSERT INTO `emotion_record` VALUES (84, '1747813503,6cdd0626-5d25-49a8-b002-91b0c6f9bb83', 'dn+KEYZ/jDHdQRaLjZAvqA==', 'fc08b4871012d90dff637028dcb61c97', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 15:45:02', 11, 'student');
INSERT INTO `emotion_record` VALUES (85, '1747813504,f184901f-d574-4856-a6f1-85185350de35', '/t1D8nO+t9aR6rezEf1HxA==', 'e5f9b97acd31c267fc3302292accb44e', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 15:45:04', 11, 'student');
INSERT INTO `emotion_record` VALUES (86, '1747813507,cecd654e-105e-4177-aedd-7189ac03782e', 'Vdd24M+86gPRWXCrrgtzeA==', '15ab65dfcf7c2669e8035b000f6a2fce', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 15:45:06', 11, 'student');
INSERT INTO `emotion_record` VALUES (87, '1747813507,cecd654e-105e-4177-aedd-7189ac03782e', 'Vdd24M+86gPRWXCrrgtzeA==', '965187df27a83d4880422fdbf3b97a52', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 15:45:06', 11, 'student');
INSERT INTO `emotion_record` VALUES (88, '1747813508,0654198b-9b5f-4432-813c-e84255f2c566', 'WUe5ibWtbKvoRBiXwLusUA==', 'ea88ca864528ae9159251fce5263e0f2', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 15:45:08', 11, 'student');
INSERT INTO `emotion_record` VALUES (89, '1747813508,0654198b-9b5f-4432-813c-e84255f2c566', 'WUe5ibWtbKvoRBiXwLusUA==', 'c2e857db9d6b2c815218fc56a5498707', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 15:45:08', 11, 'student');
INSERT INTO `emotion_record` VALUES (90, '1747813508,0654198b-9b5f-4432-813c-e84255f2c566', 'WUe5ibWtbKvoRBiXwLusUA==', '80296a732f2b0d70b3bd256cbed43356', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 15:45:08', 11, 'student');
INSERT INTO `emotion_record` VALUES (91, '1747813512,888ad6b4-2a30-409c-87c3-1de49f343fba', '5wMkry20WsFtVLxZDNriGQ==', 'e61f2220659f1ef71eb2ec928009d816', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 15:45:11', 11, 'student');
INSERT INTO `emotion_record` VALUES (92, '1747813512,888ad6b4-2a30-409c-87c3-1de49f343fba', '5wMkry20WsFtVLxZDNriGQ==', '0cbf548136365015275e77f95d7cef30', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 15:45:11', 11, 'student');
INSERT INTO `emotion_record` VALUES (93, '1747813518,c1bca547-619e-4ed6-97e4-1540602891da', 'r9B/MNGuxPIGsTJxraxtFw==', 'e9c47ae7bc975be631f003cd7f740709', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 15:45:18', 11, 'student');
INSERT INTO `emotion_record` VALUES (94, '1747813518,c1bca547-619e-4ed6-97e4-1540602891da', 'r9B/MNGuxPIGsTJxraxtFw==', 'ddbf903b9d5653e43b752a12e7bf5b66', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 15:45:18', 11, 'student');
INSERT INTO `emotion_record` VALUES (95, '1747813518,c1bca547-619e-4ed6-97e4-1540602891da', 'r9B/MNGuxPIGsTJxraxtFw==', '8064658a40b8679aa9517dddeaf45b9d', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 15:45:18', 11, 'student');
INSERT INTO `emotion_record` VALUES (96, '1747813520,0bd2c0b3-a923-4691-bc87-99891f4d074d', 'aAlO3myLwMb17o1QWeG5PQ==', 'ea36ad6508dc115e23d9b6b7e2ba1e6b', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 15:45:20', 11, 'student');
INSERT INTO `emotion_record` VALUES (97, '1747813520,0bd2c0b3-a923-4691-bc87-99891f4d074d', 'aAlO3myLwMb17o1QWeG5PQ==', 'acd5adf4beabd18459a4733ba0b6e636', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 15:45:20', 11, 'student');
INSERT INTO `emotion_record` VALUES (98, '1747813520,0bd2c0b3-a923-4691-bc87-99891f4d074d', 'aAlO3myLwMb17o1QWeG5PQ==', 'e561ad0b1335a83ec029d28d28ba45fb', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 15:45:20', 11, 'student');
INSERT INTO `emotion_record` VALUES (99, '1747813524,ecf026df-11a8-4a04-b1ed-b7092d122367', '+5oKVJB240YGj018Rk2SWQ==', '1b0dcb4a9ad11b807e3acb7bf6611399', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 15:45:23', 11, 'student');
INSERT INTO `emotion_record` VALUES (100, '1747813524,ecf026df-11a8-4a04-b1ed-b7092d122367', '+5oKVJB240YGj018Rk2SWQ==', '53296610e71c5b35a842539a4e6d16c0', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 15:45:23', 11, 'student');
INSERT INTO `emotion_record` VALUES (101, '1747813524,ecf026df-11a8-4a04-b1ed-b7092d122367', '+5oKVJB240YGj018Rk2SWQ==', 'f6816a16f1812660f57a3ca4e5ecf957', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 15:45:23', 11, 'student');
INSERT INTO `emotion_record` VALUES (102, '1747813524,ecf026df-11a8-4a04-b1ed-b7092d122367', '+5oKVJB240YGj018Rk2SWQ==', '66b8d2099abdbbf29b395479ca0c79bc', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 15:45:23', 11, 'student');
INSERT INTO `emotion_record` VALUES (103, '1747814520,fc6a8301-ebbe-4b3f-b070-e1a0f58296cb', 'tV9yywN3KMrMMA+DbvWfwg==', 'dddca0c11a280b0bf5d956833b424d7d', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 16:02:00', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (104, '1747814521,4d325a41-d9ef-4459-a9b7-b225bc78e258', '/sktHVxs7MomhjCYYAA+5A==', 'c5363d8bc71c7abf28fbef384aa2ce3a', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 16:02:00', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (105, '1747814523,88148405-58df-4702-a9c5-30aa40937e75', 'hC1DF+oNhYaq8L5uyCtRoQ==', '7161dcd8bd09df303c11585997ce52e3', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 16:02:02', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (106, '1747814523,03bc5478-65e3-4260-ad9b-4b608af85cbe', 'VCgRTBs9igv/X6k0Sxo9VQ==', 'ab1c895bdf57d0963377b1f56594ec54', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 16:02:02', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (107, '1747814524,a87a157c-b414-47a3-8c7c-b07e260ddc32', 'fEGbK1dXHzaaYoUXZrdzwQ==', 'daf5aad202fee1f60917bb6fa7c4c19d', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 16:02:03', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (108, '1747814524,f7853be4-bcfe-4df5-862b-d4cf7e736f92', '6XvArDX6AhhmB4kWdnkm6w==', 'de7b9b58a859d3250a8adac3e824f95f', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 16:02:04', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (109, '1747814526,57dc2504-8755-4d95-a0b4-6119d851aea8', 'C6c8B4IN2Lfh5qT35qQAKg==', '4002f47c9572e8bc600c78a5e48c9c37', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 16:02:05', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (110, '1747814526,ab212e93-0c01-4de9-8422-84a13cfba589', 'XIlfm8adpMpBBBTaa+QK9A==', '591e41af7b64c0d5b367d64cdfe55329', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 16:02:05', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (111, '1747814527,761b6993-1cac-4121-b80b-fc800325eaa7', 'Z9nrEm2bJmjE5W8xEtcskw==', 'db780445e56385bbb0153b65ce1b3589', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 16:02:06', 15, 'teacher');
INSERT INTO `emotion_record` VALUES (112, '1747814528,b3c5f212-bbd8-44ea-bf8a-cb712cd0d570', 'ddlsZhKVYeg+K5D11KVUDA==', '523a2dce1716b5dbb1346f0a2e5186e5', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 16:02:08', 15, 'student');
INSERT INTO `emotion_record` VALUES (113, '1747814531,d6c2977b-d201-4f15-a05d-0f15fe17e273', '85UUoqxyZdJmxjZR2TgiHw==', '6784f1adbbe8f08ab46f4866c7a3d6bd', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 16:02:10', 15, 'student');
INSERT INTO `emotion_record` VALUES (114, '1747814532,a5bddb10-4b9b-499c-bb0a-f0335d72d0d5', 'dn+KEYZ/jDHdQRaLjZAvqA==', '506a020fb7138036d1a8467491023a29', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 16:02:12', 15, 'student');
INSERT INTO `emotion_record` VALUES (115, '1747814534,e8e6e2a0-3685-4328-a024-f62dd2dcb884', '/t1D8nO+t9aR6rezEf1HxA==', '73e22c0011c219999b6fae01633f6081', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 16:02:14', 15, 'student');
INSERT INTO `emotion_record` VALUES (116, '1747814536,72cacfde-1b9f-4fe4-8f01-afe113d5789c', 'Vdd24M+86gPRWXCrrgtzeA==', '47046d0eecfb3ab2e06936b092db869c', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 16:02:15', 15, 'student');
INSERT INTO `emotion_record` VALUES (117, '1747814536,72cacfde-1b9f-4fe4-8f01-afe113d5789c', 'Vdd24M+86gPRWXCrrgtzeA==', 'e05de24b665d17fd0044c762387e3083', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 16:02:15', 15, 'student');
INSERT INTO `emotion_record` VALUES (118, '1747814538,85f93f1a-9b7f-48f7-b932-ea98817eb3b8', 'WUe5ibWtbKvoRBiXwLusUA==', '7359958dd7afeb2c80d9984b109b866f', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 16:02:17', 15, 'student');
INSERT INTO `emotion_record` VALUES (119, '1747814538,85f93f1a-9b7f-48f7-b932-ea98817eb3b8', 'WUe5ibWtbKvoRBiXwLusUA==', '93e0a52580e96e479c87aab7d4844f15', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 16:02:17', 15, 'student');
INSERT INTO `emotion_record` VALUES (120, '1747814538,85f93f1a-9b7f-48f7-b932-ea98817eb3b8', 'WUe5ibWtbKvoRBiXwLusUA==', '3ec6f75f0de614d44352993cf6ce6ab4', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 16:02:17', 15, 'student');
INSERT INTO `emotion_record` VALUES (121, '1747814540,cda6ec43-f5bb-469f-90c8-474a809e929e', '5wMkry20WsFtVLxZDNriGQ==', '307ab80c599316ba8b81176e4b548c04', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 16:02:19', 15, 'student');
INSERT INTO `emotion_record` VALUES (122, '1747814540,cda6ec43-f5bb-469f-90c8-474a809e929e', '5wMkry20WsFtVLxZDNriGQ==', 'c47f2a3dfc59086219b720e8215704d2', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 16:02:19', 15, 'student');
INSERT INTO `emotion_record` VALUES (123, '1747814543,e33218ad-58e7-4b9e-b6c8-f160f570ae72', 'r9B/MNGuxPIGsTJxraxtFw==', 'aaeed0cd8b6e455be0c2949bada1a5b6', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 16:02:22', 15, 'student');
INSERT INTO `emotion_record` VALUES (124, '1747814543,e33218ad-58e7-4b9e-b6c8-f160f570ae72', 'r9B/MNGuxPIGsTJxraxtFw==', '29c0a6eac89184a368264e3ad3c15a36', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 16:02:22', 15, 'student');
INSERT INTO `emotion_record` VALUES (125, '1747814543,e33218ad-58e7-4b9e-b6c8-f160f570ae72', 'r9B/MNGuxPIGsTJxraxtFw==', 'fc98fac6645f1fbaa7313b538fc4401b', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 16:02:22', 15, 'student');
INSERT INTO `emotion_record` VALUES (126, '1747814545,65cda52a-c930-40c7-baef-c0ad5eb617e2', 'aAlO3myLwMb17o1QWeG5PQ==', '9d4e857b73c16d8aca5dcebb2dc1549e', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 16:02:24', 15, 'student');
INSERT INTO `emotion_record` VALUES (127, '1747814545,65cda52a-c930-40c7-baef-c0ad5eb617e2', 'aAlO3myLwMb17o1QWeG5PQ==', '2c65be432fc578714bc14a50944b5a3f', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 16:02:24', 15, 'student');
INSERT INTO `emotion_record` VALUES (128, '1747814545,65cda52a-c930-40c7-baef-c0ad5eb617e2', 'aAlO3myLwMb17o1QWeG5PQ==', 'e16cb925508ba8f41d0524c61e196479', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 16:02:24', 15, 'student');
INSERT INTO `emotion_record` VALUES (129, '1747814547,e30b58c4-4f33-4b3e-b579-7862c7fdefcc', '+5oKVJB240YGj018Rk2SWQ==', '874bdb9a713be773f9f6eefc1f44839a', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 16:02:26', 15, 'student');
INSERT INTO `emotion_record` VALUES (130, '1747814547,e30b58c4-4f33-4b3e-b579-7862c7fdefcc', '+5oKVJB240YGj018Rk2SWQ==', 'b6a23df0311776bcaf03cf6d16da3219', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 16:02:26', 15, 'student');
INSERT INTO `emotion_record` VALUES (131, '1747814547,e30b58c4-4f33-4b3e-b579-7862c7fdefcc', '+5oKVJB240YGj018Rk2SWQ==', 'f9f4359e15780026e51135e6cd5a68ef', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 16:02:26', 15, 'student');
INSERT INTO `emotion_record` VALUES (132, '1747814547,e30b58c4-4f33-4b3e-b579-7862c7fdefcc', '+5oKVJB240YGj018Rk2SWQ==', '85a6b42fd012a5783110e2fb64a52126', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 16:02:26', 15, 'student');
INSERT INTO `emotion_record` VALUES (133, '1747814598,0413e42e-8ae8-4409-9a2d-c4629d791a42', 'tV9yywN3KMrMMA+DbvWfwg==', 'd464cc9a13d85ed70a506ff4dbdd72ce', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 16:03:18', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (134, '1747814599,f3c56259-714b-4e40-8894-46099c1a8495', '/sktHVxs7MomhjCYYAA+5A==', 'bd7c2c7b4f86529e2ae7fc8514f16eae', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 16:03:18', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (135, '1747814600,31d777a6-3643-4385-b8d0-120493d1dad4', 'hC1DF+oNhYaq8L5uyCtRoQ==', 'd6be371c1a87313408dff36f95c700bd', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 16:03:19', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (136, '1747814600,f6c9e118-947a-420f-99f9-a2a738fd7337', 'VCgRTBs9igv/X6k0Sxo9VQ==', '5f7098f2e8c041c6c952427dca818f3f', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 16:03:19', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (137, '1747814601,b2dfedfa-8242-4158-a879-7ece60ff4abf', 'fEGbK1dXHzaaYoUXZrdzwQ==', '4a85e1fa5d91eacf86c5ca007afbc60a', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 16:03:20', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (138, '1747814601,b1976eed-c078-4145-b120-9ac6d730e168', '6XvArDX6AhhmB4kWdnkm6w==', 'de81618a9404d2e0e48ef497582a269c', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 16:03:20', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (139, '1747814602,1b93e7c4-5c6c-40ee-b5a3-57a4ac9612f0', 'C6c8B4IN2Lfh5qT35qQAKg==', 'd9c41f574648765f32fb9cb6b52d79b4', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 16:03:21', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (140, '1747814603,737dbcc1-86da-4594-b918-e6ee6c280aa0', 'XIlfm8adpMpBBBTaa+QK9A==', '90ebed437c2e0284900325b5fc1d16fc', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 16:03:22', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (141, '1747814603,3e45c845-d25f-4ed1-90b4-57478feda4a9', 'Z9nrEm2bJmjE5W8xEtcskw==', 'ac1c4ff4943cd6692d40e6c36a91e974', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 16:03:23', 16, 'teacher');
INSERT INTO `emotion_record` VALUES (142, '1747814604,26ae09ab-66f6-49fd-869d-daa51506bce1', 'ddlsZhKVYeg+K5D11KVUDA==', '4b3efcbef5e7639a2981d33754970563', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 16:03:23', 16, 'student');
INSERT INTO `emotion_record` VALUES (143, '1747814605,869d0d40-6440-40e8-9e59-67f1ccb40dcf', '85UUoqxyZdJmxjZR2TgiHw==', '0ada79c80b41b8762689032af1856089', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 16:03:24', 16, 'student');
INSERT INTO `emotion_record` VALUES (144, '1747814606,281d67e6-35b1-4b12-a9b0-0024ad889123', 'dn+KEYZ/jDHdQRaLjZAvqA==', '5d3865f1e7b1312a1456c100dae62cdb', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 16:03:26', 16, 'student');
INSERT INTO `emotion_record` VALUES (145, '1747814607,35e6467c-aa25-46ae-ac7f-6099866cb693', '/t1D8nO+t9aR6rezEf1HxA==', 'd8c9b80587903124179c1d7cb1a2e65c', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 16:03:27', 16, 'student');
INSERT INTO `emotion_record` VALUES (146, '1747814609,bdeda050-80a8-4512-8610-46c7466a317c', 'Vdd24M+86gPRWXCrrgtzeA==', '21daca154a5ea57a668d440053a82413', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 16:03:28', 16, 'student');
INSERT INTO `emotion_record` VALUES (147, '1747814609,bdeda050-80a8-4512-8610-46c7466a317c', 'Vdd24M+86gPRWXCrrgtzeA==', '0aa4d3356aa0642a53340dd15ab950e0', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 16:03:28', 16, 'student');
INSERT INTO `emotion_record` VALUES (148, '1747814610,9a3bfa04-dbd6-4972-94c8-8c052bd27d55', 'WUe5ibWtbKvoRBiXwLusUA==', '4b7375b175cd97a9baac955d9e5ed65c', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 16:03:30', 16, 'student');
INSERT INTO `emotion_record` VALUES (149, '1747814610,9a3bfa04-dbd6-4972-94c8-8c052bd27d55', 'WUe5ibWtbKvoRBiXwLusUA==', '98f2119cb3792a2aa7c385fcff25c28b', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 16:03:30', 16, 'student');
INSERT INTO `emotion_record` VALUES (150, '1747814610,9a3bfa04-dbd6-4972-94c8-8c052bd27d55', 'WUe5ibWtbKvoRBiXwLusUA==', '72aeb62ba5cddd3a6a6c6a324387c978', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 16:03:30', 16, 'student');
INSERT INTO `emotion_record` VALUES (151, '1747814612,59a4e75a-c243-4569-b473-b4c47e721c49', '5wMkry20WsFtVLxZDNriGQ==', '4d2788af336b9ba1847b87679e165197', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 16:03:31', 16, 'student');
INSERT INTO `emotion_record` VALUES (152, '1747814612,59a4e75a-c243-4569-b473-b4c47e721c49', '5wMkry20WsFtVLxZDNriGQ==', '8ecc61d014bb2fb3ce2a4d68a24b1ad5', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 16:03:31', 16, 'student');
INSERT INTO `emotion_record` VALUES (153, '1747814614,4b3e1c30-9256-45fd-87aa-f974ee06b704', 'r9B/MNGuxPIGsTJxraxtFw==', '2ff156cf28f9b45324f3ede0637701c4', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 16:03:34', 16, 'student');
INSERT INTO `emotion_record` VALUES (154, '1747814614,4b3e1c30-9256-45fd-87aa-f974ee06b704', 'r9B/MNGuxPIGsTJxraxtFw==', '03382ac40b308625421390bf14191af1', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 16:03:34', 16, 'student');
INSERT INTO `emotion_record` VALUES (155, '1747814614,4b3e1c30-9256-45fd-87aa-f974ee06b704', 'r9B/MNGuxPIGsTJxraxtFw==', '1e5c83ab0c91352f5b73d50ebbcb57d7', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 16:03:34', 16, 'student');
INSERT INTO `emotion_record` VALUES (156, '1747814616,498f2865-1492-459d-a06b-c55e4c411a24', 'aAlO3myLwMb17o1QWeG5PQ==', '8e8af9c8f611ae0fde66b438bd801457', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 16:03:35', 16, 'student');
INSERT INTO `emotion_record` VALUES (157, '1747814616,498f2865-1492-459d-a06b-c55e4c411a24', 'aAlO3myLwMb17o1QWeG5PQ==', '70f62036ff4e73d26dd067b9018f556b', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 16:03:35', 16, 'student');
INSERT INTO `emotion_record` VALUES (158, '1747814616,498f2865-1492-459d-a06b-c55e4c411a24', 'aAlO3myLwMb17o1QWeG5PQ==', 'b91b078614739a41152489258aa2713c', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 16:03:35', 16, 'student');
INSERT INTO `emotion_record` VALUES (159, '1747814617,5726a8be-a290-4210-9c39-6e3431cbbf0e', '+5oKVJB240YGj018Rk2SWQ==', 'c74cd0c562e17809cb7ca71412f0a686', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 16:03:37', 16, 'student');
INSERT INTO `emotion_record` VALUES (160, '1747814617,5726a8be-a290-4210-9c39-6e3431cbbf0e', '+5oKVJB240YGj018Rk2SWQ==', '69811fbb6fdbb22630e23b645e84020b', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 16:03:37', 16, 'student');
INSERT INTO `emotion_record` VALUES (161, '1747814617,5726a8be-a290-4210-9c39-6e3431cbbf0e', '+5oKVJB240YGj018Rk2SWQ==', 'e36d950a87fb4298309a209552f29147', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 16:03:37', 16, 'student');
INSERT INTO `emotion_record` VALUES (162, '1747814617,5726a8be-a290-4210-9c39-6e3431cbbf0e', '+5oKVJB240YGj018Rk2SWQ==', '45578b0d4d7f8ca84d1c196e1b53c6cd', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 16:03:37', 16, 'student');
INSERT INTO `emotion_record` VALUES (163, '1747814764,fec77d38-d7df-46bf-9523-223cefaae2cf', 'tV9yywN3KMrMMA+DbvWfwg==', '24bcd5e48bed29e83d5cee94b5bf6380', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 16:06:04', 16, 'student');
INSERT INTO `emotion_record` VALUES (164, '1747814765,e1fe0d81-b509-401a-b047-19218e2d5d5e', '/sktHVxs7MomhjCYYAA+5A==', '86eb7eab1bf5c33174495cb0654d8558', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 16:06:04', 16, 'student');
INSERT INTO `emotion_record` VALUES (165, '1747814765,05a12e13-83bd-4a98-a273-f54c85184d14', 'hC1DF+oNhYaq8L5uyCtRoQ==', '0de8e5856f6bff2df849b7557fb52553', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 16:06:05', 16, 'student');
INSERT INTO `emotion_record` VALUES (166, '1747814766,6ac1eb37-d7b7-4021-bc95-5180dad75a07', 'VCgRTBs9igv/X6k0Sxo9VQ==', '90bcce5b043bacc8d8d1e72725e27f20', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 16:06:05', 16, 'student');
INSERT INTO `emotion_record` VALUES (167, '1747814766,32932ecc-c030-45ca-8d4e-e2d2b93321e7', 'fEGbK1dXHzaaYoUXZrdzwQ==', 'c2da94fc08b4298a2197c2362ac57d9a', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 16:06:06', 16, 'student');
INSERT INTO `emotion_record` VALUES (168, '1747814767,65d671fc-92b6-4411-9d57-1caf01fb756e', '6XvArDX6AhhmB4kWdnkm6w==', '08d4efd09d2ae3e4779a231d7b60be65', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 16:06:06', 16, 'student');
INSERT INTO `emotion_record` VALUES (169, '1747814768,013f830d-6063-4be1-819b-dcf888442d72', 'C6c8B4IN2Lfh5qT35qQAKg==', '445b15964c24d2cf7faf6e334cd6a87b', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 16:06:07', 16, 'student');
INSERT INTO `emotion_record` VALUES (170, '1747814769,01134422-9e50-4304-89a7-091581aa572a', 'XIlfm8adpMpBBBTaa+QK9A==', '5b4e7ced62d13cb6e61c248ae1f32b20', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 16:06:08', 16, 'student');
INSERT INTO `emotion_record` VALUES (171, '1747814769,f3c85a18-eedd-4018-b2f3-95cb5184e305', 'Z9nrEm2bJmjE5W8xEtcskw==', 'df760647be4d0a2438e1d12e8c6323c5', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 16:06:08', 16, 'student');
INSERT INTO `emotion_record` VALUES (172, '1747814920,78aa39c1-758a-437e-b242-7c965da44c44', 'tV9yywN3KMrMMA+DbvWfwg==', 'a29e7a1433b2125d60a669de086a83b1', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 16:08:39', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (173, '1747814920,cb50428d-bfc4-4307-bfcc-bf4867ebd325', '/sktHVxs7MomhjCYYAA+5A==', 'd21166a900516ff2ed1070d64aad1378', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 16:08:39', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (174, '1747814921,dd0e17e0-cfa2-4385-a9de-b0add85bc906', 'hC1DF+oNhYaq8L5uyCtRoQ==', 'f0a9d70f26c1cc82f9fcc6d6dcccbaae', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 16:08:40', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (175, '1747814921,e05f035b-6fef-4f8b-8324-d670c28e266c', 'VCgRTBs9igv/X6k0Sxo9VQ==', 'c678d92468baa2b89d5e260f8c51a242', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 16:08:40', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (176, '1747814922,a893329c-69f0-4b0d-86bb-1267466fec3f', 'fEGbK1dXHzaaYoUXZrdzwQ==', '476ba0e22b282253a095b224e2c070c4', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 16:08:41', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (177, '1747814922,f17f2075-8171-4cc0-9f79-2fc315b4c1fd', '6XvArDX6AhhmB4kWdnkm6w==', '07dbb75cca99be56082832d3a89f4307', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 16:08:41', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (178, '1747814923,cda552d5-6114-4387-a419-e28fb29b1faf', 'C6c8B4IN2Lfh5qT35qQAKg==', '462a90e55d71363e69b9661dc780e9b2', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 16:08:42', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (179, '1747814924,552eae31-a036-40a3-83e5-4c499b0ee280', 'XIlfm8adpMpBBBTaa+QK9A==', 'a534750be759f6d17c67fcfc7d8ebcf0', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 16:08:43', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (180, '1747814924,42681e32-889f-4a53-a91c-170cc81c6d20', 'Z9nrEm2bJmjE5W8xEtcskw==', 'd90e1228741982877c4fddf4a5e8dd60', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 16:08:43', 17, 'teacher');
INSERT INTO `emotion_record` VALUES (181, '1747814926,bad9da6c-2048-41db-afd9-eb9d0ea4a1ed', 'ddlsZhKVYeg+K5D11KVUDA==', '10dbe55da520d2ef7f83514295786e16', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 16:08:46', 17, 'student');
INSERT INTO `emotion_record` VALUES (182, '1747814928,b1ac31f6-ece7-4123-89e9-05464a51df00', '85UUoqxyZdJmxjZR2TgiHw==', 'c0a2bd39f6878e5389789908d9496d9d', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 16:08:47', 17, 'student');
INSERT INTO `emotion_record` VALUES (183, '1747814929,32c2e73f-73a8-4e6d-88ce-730e679c8d87', 'dn+KEYZ/jDHdQRaLjZAvqA==', '6a0b2650f7c79fe6b60f47fd1f491986', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 16:08:48', 17, 'student');
INSERT INTO `emotion_record` VALUES (184, '1747814930,21e1a5fa-bd75-42d6-9c3e-c2a3e89bc6c8', '/t1D8nO+t9aR6rezEf1HxA==', '54c34186233d4dfde43cb30f8dc607ea', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 16:08:50', 17, 'student');
INSERT INTO `emotion_record` VALUES (185, '1747814932,3fa20b5a-c93b-4d7f-9003-14e2bc8e7cdd', 'Vdd24M+86gPRWXCrrgtzeA==', 'c7f88781ccb691af57a4c78b8b21888a', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 16:08:51', 17, 'student');
INSERT INTO `emotion_record` VALUES (186, '1747814932,3fa20b5a-c93b-4d7f-9003-14e2bc8e7cdd', 'Vdd24M+86gPRWXCrrgtzeA==', 'e3ef41cf83df2f7c6a65d21c765a41fb', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 16:08:51', 17, 'student');
INSERT INTO `emotion_record` VALUES (187, '1747814933,60c4987e-7553-413d-b416-50245175b019', 'WUe5ibWtbKvoRBiXwLusUA==', '274a434cdfe706b1ac1a54a9bf1f1925', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 16:08:53', 17, 'student');
INSERT INTO `emotion_record` VALUES (188, '1747814933,60c4987e-7553-413d-b416-50245175b019', 'WUe5ibWtbKvoRBiXwLusUA==', '182be49ffd9d66fe447ad91ce749de50', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 16:08:53', 17, 'student');
INSERT INTO `emotion_record` VALUES (189, '1747814933,60c4987e-7553-413d-b416-50245175b019', 'WUe5ibWtbKvoRBiXwLusUA==', '59ac0ec4388ba7182b510a61dfaa3166', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 16:08:53', 17, 'student');
INSERT INTO `emotion_record` VALUES (190, '1747814935,88f452f7-af01-4302-95d9-7a985cd23b01', '5wMkry20WsFtVLxZDNriGQ==', '9369a909ca0b99153f9f9996b653fa81', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 16:08:54', 17, 'student');
INSERT INTO `emotion_record` VALUES (191, '1747814935,88f452f7-af01-4302-95d9-7a985cd23b01', '5wMkry20WsFtVLxZDNriGQ==', 'cd356eaf19577604e9d60a098de68e19', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 16:08:54', 17, 'student');
INSERT INTO `emotion_record` VALUES (192, '1747814937,f3e94f9d-16da-43a1-90de-969bbf8db330', 'r9B/MNGuxPIGsTJxraxtFw==', '623cd77a49021391f717c8fe53d0aa59', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 16:08:57', 17, 'student');
INSERT INTO `emotion_record` VALUES (193, '1747814937,f3e94f9d-16da-43a1-90de-969bbf8db330', 'r9B/MNGuxPIGsTJxraxtFw==', '0255195b82cb63dbd891fa18e45bcab2', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 16:08:57', 17, 'student');
INSERT INTO `emotion_record` VALUES (194, '1747814937,f3e94f9d-16da-43a1-90de-969bbf8db330', 'r9B/MNGuxPIGsTJxraxtFw==', 'c84fb832b823b15387be19d82089edd1', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 16:08:57', 17, 'student');
INSERT INTO `emotion_record` VALUES (195, '1747814939,3de2971c-5ddd-4cad-a18d-e56f630bab26', 'aAlO3myLwMb17o1QWeG5PQ==', '09c2cc84f61344d8bf24f049ff9f8300', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 16:08:58', 17, 'student');
INSERT INTO `emotion_record` VALUES (196, '1747814939,3de2971c-5ddd-4cad-a18d-e56f630bab26', 'aAlO3myLwMb17o1QWeG5PQ==', '3deb255bbf7c38c2921a0e1ccf3380dc', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 16:08:58', 17, 'student');
INSERT INTO `emotion_record` VALUES (197, '1747814939,3de2971c-5ddd-4cad-a18d-e56f630bab26', 'aAlO3myLwMb17o1QWeG5PQ==', '8ed0ea585fe2bb31aac31ada444e5587', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 16:08:58', 17, 'student');
INSERT INTO `emotion_record` VALUES (198, '1747814940,f0eab74e-aa28-45f5-8346-169421e17c72', '+5oKVJB240YGj018Rk2SWQ==', 'd610d80ee1f84cfef56052044110716a', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 16:09:00', 17, 'student');
INSERT INTO `emotion_record` VALUES (199, '1747814940,f0eab74e-aa28-45f5-8346-169421e17c72', '+5oKVJB240YGj018Rk2SWQ==', '76646a2759dee0c0eae6923c4e802e67', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 16:09:00', 17, 'student');
INSERT INTO `emotion_record` VALUES (200, '1747814940,f0eab74e-aa28-45f5-8346-169421e17c72', '+5oKVJB240YGj018Rk2SWQ==', '462d72dff4340fd0b4c60abf6a40a2f0', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 16:09:00', 17, 'student');
INSERT INTO `emotion_record` VALUES (201, '1747814940,f0eab74e-aa28-45f5-8346-169421e17c72', '+5oKVJB240YGj018Rk2SWQ==', 'b1f38a7550b2f7a76c55238dc24acee1', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 16:09:00', 17, 'student');
INSERT INTO `emotion_record` VALUES (202, '1747815058,58440d63-b548-4f68-b21b-438cd6a7101d', 'ddlsZhKVYeg+K5D11KVUDA==', '7e3fbdb4fecbe5c4e19867a2af802732', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 16:10:57', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (203, '1747815059,963e8736-cade-4ada-9ba5-d5386c53e68d', '85UUoqxyZdJmxjZR2TgiHw==', '24c5788a9af10729b8cc61726f6fc022', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 16:10:59', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (204, '1747815061,e3dd5ee0-56df-46f2-8c05-c72174201403', 'dn+KEYZ/jDHdQRaLjZAvqA==', '46c0fafe3fb5d7a6e8469605d13b3aa3', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 16:11:00', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (205, '1747815062,a32ca1da-6f2b-481f-8411-78625e4ffec8', '/t1D8nO+t9aR6rezEf1HxA==', '9416776099730235bb6df72e839e2cb1', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 16:11:01', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (206, '1747815063,34191726-f3c1-4d19-bfc6-b50baeab6d40', 'Vdd24M+86gPRWXCrrgtzeA==', 'a9f284f0317c9caa6da3f4d2e879d273', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 16:11:03', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (207, '1747815063,34191726-f3c1-4d19-bfc6-b50baeab6d40', 'Vdd24M+86gPRWXCrrgtzeA==', '1caa1a68180580e763482f0818fa3237', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 16:11:03', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (208, '1747815065,4bc27fad-bee0-4c35-8e24-b411f6093f62', 'WUe5ibWtbKvoRBiXwLusUA==', '5328421e30ca0e4df3c894fe3b936699', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 16:11:04', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (209, '1747815065,4bc27fad-bee0-4c35-8e24-b411f6093f62', 'WUe5ibWtbKvoRBiXwLusUA==', '5de55266759aff5ce5ae688337a0013e', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 16:11:04', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (210, '1747815065,4bc27fad-bee0-4c35-8e24-b411f6093f62', 'WUe5ibWtbKvoRBiXwLusUA==', 'cf21d5f3dcf8ec36a457563483c17c65', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 16:11:04', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (211, '1747815066,935b6105-283b-4b54-8807-b66a167d9346', '5wMkry20WsFtVLxZDNriGQ==', '54c77afa703e71abff7c8cfa4500879e', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 16:11:05', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (212, '1747815066,935b6105-283b-4b54-8807-b66a167d9346', '5wMkry20WsFtVLxZDNriGQ==', '7546ba945e0f524c36d7819be3651304', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 16:11:05', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (213, '1747815069,b2ed953c-abf8-4e2c-917b-d8e1be79c712', 'r9B/MNGuxPIGsTJxraxtFw==', '6ee445b02f97a4b0c6e41d370ecb3577', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 16:11:08', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (214, '1747815069,b2ed953c-abf8-4e2c-917b-d8e1be79c712', 'r9B/MNGuxPIGsTJxraxtFw==', '73ca4bbcd518333d829ea1386f639473', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 16:11:08', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (215, '1747815069,b2ed953c-abf8-4e2c-917b-d8e1be79c712', 'r9B/MNGuxPIGsTJxraxtFw==', '0ef9b0a4798dc33d3094974a34b4325d', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 16:11:08', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (216, '1747815070,a50a597f-e9dd-402a-8fef-b895cc1fcf39', 'aAlO3myLwMb17o1QWeG5PQ==', '3ebf234965b6b65cc1afbffcc1c4802c', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 16:11:10', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (217, '1747815070,a50a597f-e9dd-402a-8fef-b895cc1fcf39', 'aAlO3myLwMb17o1QWeG5PQ==', '855348767e788e2970f293049f696ae9', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 16:11:10', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (218, '1747815070,a50a597f-e9dd-402a-8fef-b895cc1fcf39', 'aAlO3myLwMb17o1QWeG5PQ==', '7205940211650c6515ed77d8671fa7a2', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 16:11:10', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (219, '1747815072,f222c3e4-758e-4685-b7df-b00a4a4d1eed', '+5oKVJB240YGj018Rk2SWQ==', '1d754f7905c85287183d1ae830168115', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 16:11:11', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (220, '1747815072,f222c3e4-758e-4685-b7df-b00a4a4d1eed', '+5oKVJB240YGj018Rk2SWQ==', '80ebd5017c8708dbd6a8eeae87e9a9e6', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 16:11:11', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (221, '1747815072,f222c3e4-758e-4685-b7df-b00a4a4d1eed', '+5oKVJB240YGj018Rk2SWQ==', 'c0742842561e669337a3058cdec2fea4', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 16:11:11', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (222, '1747815072,f222c3e4-758e-4685-b7df-b00a4a4d1eed', '+5oKVJB240YGj018Rk2SWQ==', '9cb9c172b6b44c324e63c08914401e48', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 16:11:11', 18, 'teacher');
INSERT INTO `emotion_record` VALUES (223, '1747815279,9fdcdbd9-a5e7-43b3-a807-53b084708212', 'tV9yywN3KMrMMA+DbvWfwg==', '1990d031090fafad1d1c28fcf7766cf9', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 16:14:38', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (224, '1747815280,c25699e7-bedd-4f9a-918d-79bd26d6e769', '/sktHVxs7MomhjCYYAA+5A==', '86cc84dc678b1025fd25710754fdd916', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 16:14:39', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (225, '1747815280,b5694cba-788e-4c82-8029-6409f2bb5d42', 'hC1DF+oNhYaq8L5uyCtRoQ==', '8a84358b6fa5da35900d61985490cfef', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 16:14:39', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (226, '1747815281,330fae71-5606-4c18-8c21-b3c89333a634', 'VCgRTBs9igv/X6k0Sxo9VQ==', 'e1df4e6442af2b49cc05559c4581e89a', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 16:14:40', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (227, '1747815281,55272e2e-873e-4797-979a-0d0f960bcfd3', 'fEGbK1dXHzaaYoUXZrdzwQ==', '89ae68c08560a3e0f0900793cd9c0e14', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 16:14:40', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (228, '1747815282,eb598e07-1a7c-4e67-b15b-3345d5d0d1c5', '6XvArDX6AhhmB4kWdnkm6w==', 'a0ceac533bc35b58b92f8f6ca8dbfbca', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 16:14:41', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (229, '1747815283,322e8735-d677-4566-a394-68ac83bd8b64', 'C6c8B4IN2Lfh5qT35qQAKg==', 'b7767b95200048a7a7dcaadcc73827a2', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 16:14:42', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (230, '1747815284,e0d78cb7-5d95-408e-93e4-89641c86ec09', 'XIlfm8adpMpBBBTaa+QK9A==', 'cf7e68d9a34df838d84383f046085172', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 16:14:43', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (231, '1747815284,f9d09329-3bb3-4fc9-bf74-e2c505827a65', 'Z9nrEm2bJmjE5W8xEtcskw==', '7e5ab850f92c9667eda1441333ec3e60', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 16:14:43', 19, 'teacher');
INSERT INTO `emotion_record` VALUES (232, '1747815285,46988e39-e19b-4732-922a-940178992a8a', 'ddlsZhKVYeg+K5D11KVUDA==', '8e06d4fcd3c799701d00cbd9884aa146', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 16:14:44', 19, 'student');
INSERT INTO `emotion_record` VALUES (233, '1747815286,b253a3e8-4ebb-4f29-b65c-2a801714239b', '85UUoqxyZdJmxjZR2TgiHw==', '6ff1b027341570bfe0c6daa9b6cedb37', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 16:14:46', 19, 'student');
INSERT INTO `emotion_record` VALUES (234, '1747815288,8353caa3-5bc4-449a-b0ed-eeba33e09157', 'dn+KEYZ/jDHdQRaLjZAvqA==', '6c9270e96f40574fc1ad291ce1dc95d6', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 16:14:47', 19, 'student');
INSERT INTO `emotion_record` VALUES (235, '1747815289,87f6eb9c-c57c-433e-9a7c-08f7440c2467', '/t1D8nO+t9aR6rezEf1HxA==', 'e003df596cc0091c9ab9a6b4d04dd60c', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 16:14:49', 19, 'student');
INSERT INTO `emotion_record` VALUES (236, '1747815291,11999789-06c3-40e4-83f1-2af0059f2911', 'Vdd24M+86gPRWXCrrgtzeA==', 'b0418bdc5fc169d32d78d6adaa7dbb74', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 16:14:50', 19, 'student');
INSERT INTO `emotion_record` VALUES (237, '1747815291,11999789-06c3-40e4-83f1-2af0059f2911', 'Vdd24M+86gPRWXCrrgtzeA==', '205e4974f1b599272f531e3e2fff6746', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 16:14:50', 19, 'student');
INSERT INTO `emotion_record` VALUES (238, '1747815292,d3581dfa-c5b5-4b3b-9d83-e6781a6b87ef', 'WUe5ibWtbKvoRBiXwLusUA==', '2632286755596219adcc86b5c0bcab88', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 16:14:52', 19, 'student');
INSERT INTO `emotion_record` VALUES (239, '1747815292,d3581dfa-c5b5-4b3b-9d83-e6781a6b87ef', 'WUe5ibWtbKvoRBiXwLusUA==', 'c9c2da390c4f5c14a4a153b777667bf0', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 16:14:52', 19, 'student');
INSERT INTO `emotion_record` VALUES (240, '1747815292,d3581dfa-c5b5-4b3b-9d83-e6781a6b87ef', 'WUe5ibWtbKvoRBiXwLusUA==', '446361c58ec483c7d43b3b5067c694b1', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 16:14:52', 19, 'student');
INSERT INTO `emotion_record` VALUES (241, '1747815294,6b6f2971-708e-4b53-b7e3-2b9c8978b5dc', '5wMkry20WsFtVLxZDNriGQ==', 'f33698bce06221b6b8a624a03d1fa896', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 16:14:53', 19, 'student');
INSERT INTO `emotion_record` VALUES (242, '1747815294,6b6f2971-708e-4b53-b7e3-2b9c8978b5dc', '5wMkry20WsFtVLxZDNriGQ==', 'b53f75cf174cfaf5b2c7cba852095cd4', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 16:14:53', 19, 'student');
INSERT INTO `emotion_record` VALUES (243, '1747815301,93169455-7fde-4266-a08a-3f635a9b15fc', 'r9B/MNGuxPIGsTJxraxtFw==', '1951eae99874e667f91a3671cbbc5311', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 16:15:01', 19, 'student');
INSERT INTO `emotion_record` VALUES (244, '1747815301,93169455-7fde-4266-a08a-3f635a9b15fc', 'r9B/MNGuxPIGsTJxraxtFw==', '53b88dd0dfb79aad5255021564ddc75a', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 16:15:01', 19, 'student');
INSERT INTO `emotion_record` VALUES (245, '1747815301,93169455-7fde-4266-a08a-3f635a9b15fc', 'r9B/MNGuxPIGsTJxraxtFw==', 'a75aa126386494a508757a8277b03d93', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 16:15:01', 19, 'student');
INSERT INTO `emotion_record` VALUES (246, '1747815304,5b2468a1-45ec-42cc-a419-6e859a024c07', 'aAlO3myLwMb17o1QWeG5PQ==', '9bad26a7fbe46712df30903a6f1fcc65', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 16:15:04', 19, 'student');
INSERT INTO `emotion_record` VALUES (247, '1747815304,5b2468a1-45ec-42cc-a419-6e859a024c07', 'aAlO3myLwMb17o1QWeG5PQ==', '28e5d88662a68cb5e22b1418d1169870', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 16:15:04', 19, 'student');
INSERT INTO `emotion_record` VALUES (248, '1747815304,5b2468a1-45ec-42cc-a419-6e859a024c07', 'aAlO3myLwMb17o1QWeG5PQ==', '5590c622ffbbf0daf91a71b76292cdfa', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 16:15:04', 19, 'student');
INSERT INTO `emotion_record` VALUES (249, '1747815307,4e72ec68-9f6d-4894-a63c-a881b9225fdf', '+5oKVJB240YGj018Rk2SWQ==', '111ef2ba654530c549c0441ffb559ebf', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 16:15:06', 19, 'student');
INSERT INTO `emotion_record` VALUES (250, '1747815307,4e72ec68-9f6d-4894-a63c-a881b9225fdf', '+5oKVJB240YGj018Rk2SWQ==', '805affaf40af3c2fa3d247351fa4ca57', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 16:15:06', 19, 'student');
INSERT INTO `emotion_record` VALUES (251, '1747815307,4e72ec68-9f6d-4894-a63c-a881b9225fdf', '+5oKVJB240YGj018Rk2SWQ==', 'c1b516e92a61cde62686bf91d54612ad', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 16:15:06', 19, 'student');
INSERT INTO `emotion_record` VALUES (252, '1747815307,4e72ec68-9f6d-4894-a63c-a881b9225fdf', '+5oKVJB240YGj018Rk2SWQ==', 'fd8a5866807e2775a3830639d5d68c0a', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 16:15:06', 19, 'student');
INSERT INTO `emotion_record` VALUES (253, '1747815338,d6f88b98-8edc-42e3-a658-7afcf2f8e9e1', 'tV9yywN3KMrMMA+DbvWfwg==', '3e4ce2a8a4ec09bc7b987fef543fb0bd', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 16:15:37', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (254, '1747815338,1219035d-b2ea-4d85-a170-5174153c4bb1', '/sktHVxs7MomhjCYYAA+5A==', 'ba1273cab4deff97514c7a3190371692', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 16:15:38', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (255, '1747815339,ab5a508f-adb5-41fc-8e33-2e7305516bf5', 'hC1DF+oNhYaq8L5uyCtRoQ==', '0fd597f5a90c22eb583a72004d7b964b', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 16:15:38', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (256, '1747815340,9881bdf2-d732-4526-b5f8-17c5e8dda449', 'VCgRTBs9igv/X6k0Sxo9VQ==', '39cdec17f4ec3bced1b030c7ac05bc38', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 16:15:39', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (257, '1747815340,f7c05d0d-3dfc-45f2-abe8-908866a25835', 'fEGbK1dXHzaaYoUXZrdzwQ==', 'dcc2d1b41b986d06434df5de2edccabd', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 16:15:40', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (258, '1747815341,e60a4d51-c112-4b1c-a757-16bad18b733b', '6XvArDX6AhhmB4kWdnkm6w==', '4a34f7f52e1e4a7b7a7445592a948762', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 16:15:40', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (259, '1747815343,0896eb0a-01c5-4bdd-955c-6c8a7f3ebffb', 'C6c8B4IN2Lfh5qT35qQAKg==', 'c3d5c6aac8175862cb0c26394cd0ece7', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 16:15:42', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (260, '1747815344,7a2b48a0-0e9f-4191-a7c1-cfd66221c997', 'XIlfm8adpMpBBBTaa+QK9A==', 'ba335f94d4ef903686bd4b3dbcbb91ef', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 16:15:43', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (261, '1747815344,e8f76751-ded2-4546-b164-3a2712e8335c', 'Z9nrEm2bJmjE5W8xEtcskw==', '324cf2667b955fe54ac8ba47957f2286', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 16:15:44', 20, 'teacher');
INSERT INTO `emotion_record` VALUES (262, '1747815345,d50a5990-faf0-4083-8c47-b9713d4ae5a1', 'ddlsZhKVYeg+K5D11KVUDA==', '751d7b9338bff61e0b82380ccd62ba02', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 16:15:44', 20, 'student');
INSERT INTO `emotion_record` VALUES (263, '1747815346,7e9d5681-6102-41d8-82f1-cd03e3bc1f85', '85UUoqxyZdJmxjZR2TgiHw==', '02382ccfcd26f52029b9f9f31825ab30', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 16:15:46', 20, 'student');
INSERT INTO `emotion_record` VALUES (264, '1747815348,ea320f98-4560-4789-9e9a-24e8ce1c2a9d', 'dn+KEYZ/jDHdQRaLjZAvqA==', '6d755dfac68dfecd54d9ae4658fd4b70', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 16:15:47', 20, 'student');
INSERT INTO `emotion_record` VALUES (265, '1747815349,544fe412-e7b0-4cf2-b268-36bcc5037cd3', '/t1D8nO+t9aR6rezEf1HxA==', '4222280390ec9fea0c7298560d4ff928', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 16:15:49', 20, 'student');
INSERT INTO `emotion_record` VALUES (266, '1747815351,f193cf20-4a18-4f59-94ba-2aae17866ada', 'Vdd24M+86gPRWXCrrgtzeA==', 'a4657d635c26f30172e959cc4090a07b', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 16:15:50', 20, 'student');
INSERT INTO `emotion_record` VALUES (267, '1747815351,f193cf20-4a18-4f59-94ba-2aae17866ada', 'Vdd24M+86gPRWXCrrgtzeA==', '88aaef38de763d6fe4952269bcf36c60', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 16:15:50', 20, 'student');
INSERT INTO `emotion_record` VALUES (268, '1747815352,436ec374-f03d-4d65-98d0-dd79c5b642e5', 'WUe5ibWtbKvoRBiXwLusUA==', '993dfa4717f0eee9ddf40d75e471962c', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 16:15:52', 20, 'student');
INSERT INTO `emotion_record` VALUES (269, '1747815352,436ec374-f03d-4d65-98d0-dd79c5b642e5', 'WUe5ibWtbKvoRBiXwLusUA==', 'ca3519568a52a4fac33c4b0c8d22bfb1', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 16:15:52', 20, 'student');
INSERT INTO `emotion_record` VALUES (270, '1747815352,436ec374-f03d-4d65-98d0-dd79c5b642e5', 'WUe5ibWtbKvoRBiXwLusUA==', 'd81f40a9dfc21093dc3a762ca88ce1fd', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 16:15:52', 20, 'student');
INSERT INTO `emotion_record` VALUES (271, '1747815354,82187f33-6fc0-4339-84d3-2ba3a72b0b49', '5wMkry20WsFtVLxZDNriGQ==', '7c8b046ec249a397a5a67554a20819ef', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 16:15:53', 20, 'student');
INSERT INTO `emotion_record` VALUES (272, '1747815354,82187f33-6fc0-4339-84d3-2ba3a72b0b49', '5wMkry20WsFtVLxZDNriGQ==', 'b92ab84d7df6c519e0fdbc7e5b110561', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 16:15:53', 20, 'student');
INSERT INTO `emotion_record` VALUES (273, '1747815357,86ab5f70-ca71-485e-aea6-7d16048462c4', 'r9B/MNGuxPIGsTJxraxtFw==', '0a400cd9cb0cc94b9676ad319e48e393', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 16:15:56', 20, 'student');
INSERT INTO `emotion_record` VALUES (274, '1747815357,86ab5f70-ca71-485e-aea6-7d16048462c4', 'r9B/MNGuxPIGsTJxraxtFw==', '2c2648becb86406c164e5fe5b2babc11', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 16:15:56', 20, 'student');
INSERT INTO `emotion_record` VALUES (275, '1747815357,86ab5f70-ca71-485e-aea6-7d16048462c4', 'r9B/MNGuxPIGsTJxraxtFw==', 'f442df9fc4c8e955a4fbca6881023062', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 16:15:56', 20, 'student');
INSERT INTO `emotion_record` VALUES (276, '1747815359,e992c113-8b9b-4454-8820-18a5c2600051', 'aAlO3myLwMb17o1QWeG5PQ==', '28715d9a80a9c4ddd2a361a8042ee10d', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 16:15:58', 20, 'student');
INSERT INTO `emotion_record` VALUES (277, '1747815359,e992c113-8b9b-4454-8820-18a5c2600051', 'aAlO3myLwMb17o1QWeG5PQ==', 'd00b714d0995de9bd5ac098fbbec93d8', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 16:15:58', 20, 'student');
INSERT INTO `emotion_record` VALUES (278, '1747815359,e992c113-8b9b-4454-8820-18a5c2600051', 'aAlO3myLwMb17o1QWeG5PQ==', '87ea258c52d8da85deea94ab1864cc17', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 16:15:58', 20, 'student');
INSERT INTO `emotion_record` VALUES (279, '1747815360,af8a67a7-96b4-41b7-99eb-d1f89b197495', '+5oKVJB240YGj018Rk2SWQ==', '6de628724231d3d4be88700ec5660ac3', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 16:16:00', 20, 'student');
INSERT INTO `emotion_record` VALUES (280, '1747815360,af8a67a7-96b4-41b7-99eb-d1f89b197495', '+5oKVJB240YGj018Rk2SWQ==', '8343f57fb00d1a4ed169dc74785f018e', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 16:16:00', 20, 'student');
INSERT INTO `emotion_record` VALUES (281, '1747815360,af8a67a7-96b4-41b7-99eb-d1f89b197495', '+5oKVJB240YGj018Rk2SWQ==', 'f4357b868166cdd02ccc3ab3c15ac40c', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 16:16:00', 20, 'student');
INSERT INTO `emotion_record` VALUES (282, '1747815360,af8a67a7-96b4-41b7-99eb-d1f89b197495', '+5oKVJB240YGj018Rk2SWQ==', '02f3bc61ff057a7b59958adaf2d36888', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 16:16:00', 20, 'student');
INSERT INTO `emotion_record` VALUES (283, '1747815842,751c1961-9002-4d1f-8509-6d20d60e2598', 'tV9yywN3KMrMMA+DbvWfwg==', '6062cc73c4438f5548d246a804c3935f', 0.002, 0.003, 0.002, 99.702, 0.002, 0.281, 0.007, '2025-05-21 16:24:01', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (284, '1747815843,f2f16a9e-3135-474e-8c45-bb44898b48e2', '/sktHVxs7MomhjCYYAA+5A==', '0c49e75ef17edda22e541e5d29c7a2aa', 0.122, 0.08, 0.048, 98.454, 0.033, 1.183, 0.079, '2025-05-21 16:24:02', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (285, '1747815843,2dd9950d-5ae0-4a99-83cd-a9112e8de19f', 'hC1DF+oNhYaq8L5uyCtRoQ==', 'b2cfa8287d312f6cfe63c29458dc1c21', 0.018, 0.208, 0.018, 92.882, 0.084, 6.753, 0.037, '2025-05-21 16:24:02', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (286, '1747815844,a2108f73-e867-46a3-ac2d-3681c184eaed', 'VCgRTBs9igv/X6k0Sxo9VQ==', 'f83c78bcc347715da5c40a4a1b2f3b48', 0.002, 0.002, 0.002, 99.97, 0.002, 0.019, 0.004, '2025-05-21 16:24:03', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (287, '1747815844,39d1b1ca-5bb4-45f9-b56c-86ae3c489fd3', 'fEGbK1dXHzaaYoUXZrdzwQ==', '7961421f991e95e67cc97f594e04e3c4', 0.009, 0.91, 0.009, 98.911, 0.009, 0.141, 0.01, '2025-05-21 16:24:03', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (288, '1747815844,d28da17b-cd1a-4f0c-93a8-132b5d695f60', '6XvArDX6AhhmB4kWdnkm6w==', '086fa38a9cbcdb2f85666b9ede559577', 0.148, 4.162, 0.537, 3.261, 15.755, 0.148, 75.99, '2025-05-21 16:24:04', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (289, '1747815846,8bc3845f-9cb1-4544-9576-b67ffd7c7a69', 'C6c8B4IN2Lfh5qT35qQAKg==', 'e9ac34184ef65e60c47ef373305b7c53', 0.002, 0.034, 0.002, 99.842, 0.002, 0.072, 0.045, '2025-05-21 16:24:05', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (290, '1747815846,92dc3ede-1f6c-4bec-a40c-fad4cf1d036b', 'XIlfm8adpMpBBBTaa+QK9A==', 'ddaa2771c23780745d84493b8268143e', 0.002, 0.017, 0.002, 99.88, 0.002, 0.018, 0.08, '2025-05-21 16:24:05', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (291, '1747815847,a9ef3e69-45b4-4551-93b4-b412b7ca7459', 'Z9nrEm2bJmjE5W8xEtcskw==', '86248781a4767d54a9ef0b68cdfe0afb', 0.106, 11.787, 0.799, 0.355, 17.027, 0.106, 69.821, '2025-05-21 16:24:06', 21, 'teacher');
INSERT INTO `emotion_record` VALUES (292, '1747815847,2b188d0e-552e-407a-b511-852d6f736dcc', 'ddlsZhKVYeg+K5D11KVUDA==', '1ead7e4820e1cb37aff5b81fc5804754', 34.362, 1.826, 3.182, 13.045, 7.899, 37.86, 1.826, '2025-05-21 16:24:07', 21, 'student');
INSERT INTO `emotion_record` VALUES (293, '1747815849,34dd9332-9c88-46b6-952c-4560ef7a0563', '85UUoqxyZdJmxjZR2TgiHw==', '73a8d39904da8014854ed6b895c65ffa', 1.155, 0.004, 0.017, 98.809, 0.004, 0.006, 0.004, '2025-05-21 16:24:08', 21, 'student');
INSERT INTO `emotion_record` VALUES (294, '1747815850,e5e22f63-9616-4e2f-91f4-bc02ab31b37f', 'dn+KEYZ/jDHdQRaLjZAvqA==', '43d278d20924b10a92b8b73c039403ae', 0.272, 5.043, 0.077, 88.294, 0.077, 6.158, 0.077, '2025-05-21 16:24:09', 21, 'student');
INSERT INTO `emotion_record` VALUES (295, '1747815851,3d937944-4904-4ee9-90ed-6313366f402b', '/t1D8nO+t9aR6rezEf1HxA==', '732ae98642d2fa6d0ddea6f017e478b5', 0.031, 0.13, 0.031, 99.539, 0.184, 0.055, 0.031, '2025-05-21 16:24:11', 21, 'student');
INSERT INTO `emotion_record` VALUES (296, '1747815853,4c5c4bae-4765-43a2-a7b0-52f2223e78fc', 'Vdd24M+86gPRWXCrrgtzeA==', 'ace22cfbec888f496fd6ccc0de967c8d', 0.036, 0.05, 0.008, 98.983, 0.007, 0.909, 0.007, '2025-05-21 16:24:12', 21, 'student');
INSERT INTO `emotion_record` VALUES (297, '1747815853,4c5c4bae-4765-43a2-a7b0-52f2223e78fc', 'Vdd24M+86gPRWXCrrgtzeA==', 'c430d49a1c5134b5bc2121cbb7f04c68', 1.247, 50.335, 1.056, 2.354, 15.158, 1.528, 28.321, '2025-05-21 16:24:12', 21, 'student');
INSERT INTO `emotion_record` VALUES (298, '1747815854,d1460696-43ec-4f0a-af18-c71c51a267a0', 'WUe5ibWtbKvoRBiXwLusUA==', '831fd00266d980e02b651e8e4f09d81c', 7.552, 0.536, 7.279, 82.746, 0.536, 0.536, 0.814, '2025-05-21 16:24:13', 21, 'student');
INSERT INTO `emotion_record` VALUES (299, '1747815854,d1460696-43ec-4f0a-af18-c71c51a267a0', 'WUe5ibWtbKvoRBiXwLusUA==', '281dd5ad137f4d8a01484528129c6be9', 0.093, 0.093, 9.094, 78.294, 0.589, 11.742, 0.093, '2025-05-21 16:24:13', 21, 'student');
INSERT INTO `emotion_record` VALUES (300, '1747815854,d1460696-43ec-4f0a-af18-c71c51a267a0', 'WUe5ibWtbKvoRBiXwLusUA==', 'cfeb15238eb088f15299fb254a47e097', 0.126, 1.124, 1.432, 1.588, 0.103, 95.573, 0.054, '2025-05-21 16:24:14', 21, 'student');
INSERT INTO `emotion_record` VALUES (301, '1747815856,8e808540-42d9-47bf-949e-41d09ad33647', '5wMkry20WsFtVLxZDNriGQ==', '4b40627cea90a43572fad1085f438ac4', 1.579, 0.889, 0.238, 88.954, 1.378, 6.744, 0.216, '2025-05-21 16:24:15', 21, 'student');
INSERT INTO `emotion_record` VALUES (302, '1747815856,8e808540-42d9-47bf-949e-41d09ad33647', '5wMkry20WsFtVLxZDNriGQ==', 'd54462730859e8b9c10265d3c1867a92', 0.003, 0.074, 0.001, 99.918, 0.001, 0.001, 0.001, '2025-05-21 16:24:15', 21, 'student');
INSERT INTO `emotion_record` VALUES (303, '1747815858,5e010237-2bb5-4128-809f-ae8760eb643e', 'r9B/MNGuxPIGsTJxraxtFw==', 'ee87eba13881051ae5cd751e6f7df4f5', 6.742, 0.309, 0.485, 81.692, 6.948, 0.204, 3.621, '2025-05-21 16:24:18', 21, 'student');
INSERT INTO `emotion_record` VALUES (304, '1747815858,5e010237-2bb5-4128-809f-ae8760eb643e', 'r9B/MNGuxPIGsTJxraxtFw==', 'ce9136abfa4f9739cc96765c65a170d0', 0.01, 0.01, 0.01, 97.408, 2.519, 0.014, 0.029, '2025-05-21 16:24:18', 21, 'student');
INSERT INTO `emotion_record` VALUES (305, '1747815858,5e010237-2bb5-4128-809f-ae8760eb643e', 'r9B/MNGuxPIGsTJxraxtFw==', 'a60823b88703f523d8f9b2202aa4cc62', 0.019, 0.019, 0.019, 75.249, 22.438, 0.468, 1.787, '2025-05-21 16:24:18', 21, 'student');
INSERT INTO `emotion_record` VALUES (306, '1747815860,fd3bcb7b-2660-46b3-87f5-3186b6bc9f1d', 'aAlO3myLwMb17o1QWeG5PQ==', '4f5fa5aeba3400a106efbb73494f4de0', 1.219, 4.014, 0.861, 33.316, 1.53, 58.538, 0.521, '2025-05-21 16:24:19', 21, 'student');
INSERT INTO `emotion_record` VALUES (307, '1747815860,fd3bcb7b-2660-46b3-87f5-3186b6bc9f1d', 'aAlO3myLwMb17o1QWeG5PQ==', '7bf9e472ecc11199211ce851a02a9493', 0.097, 22.617, 0.088, 69.835, 0.296, 6.972, 0.095, '2025-05-21 16:24:19', 21, 'student');
INSERT INTO `emotion_record` VALUES (308, '1747815860,fd3bcb7b-2660-46b3-87f5-3186b6bc9f1d', 'aAlO3myLwMb17o1QWeG5PQ==', 'ace7b7ade3ad2f3fe2055f377f83170e', 0.006, 0.006, 0.006, 97.54, 2.208, 0.006, 0.227, '2025-05-21 16:24:19', 21, 'student');
INSERT INTO `emotion_record` VALUES (309, '1747815861,8981ab1f-1f9c-4027-b352-ff28dbad47d0', '+5oKVJB240YGj018Rk2SWQ==', '5eb2ee1c333f08249465b439a0b43208', 0.382, 38.307, 12.619, 40.69, 0.382, 7.236, 0.382, '2025-05-21 16:24:21', 21, 'student');
INSERT INTO `emotion_record` VALUES (310, '1747815861,8981ab1f-1f9c-4027-b352-ff28dbad47d0', '+5oKVJB240YGj018Rk2SWQ==', 'f528ee758a5e4c678afe62dd54effeb3', 0.001, 0.001, 0.001, 99.992, 0.001, 0.001, 0.005, '2025-05-21 16:24:21', 21, 'student');
INSERT INTO `emotion_record` VALUES (311, '1747815861,8981ab1f-1f9c-4027-b352-ff28dbad47d0', '+5oKVJB240YGj018Rk2SWQ==', '0c047ca07481d1636f3a87c279c8d2f2', 0.147, 1.477, 1.08, 96.114, 0.604, 0.431, 0.147, '2025-05-21 16:24:21', 21, 'student');
INSERT INTO `emotion_record` VALUES (312, '1747815861,8981ab1f-1f9c-4027-b352-ff28dbad47d0', '+5oKVJB240YGj018Rk2SWQ==', '93324b4a29327af0be8327ffb9e8ae15', 0.043, 0.043, 0.043, 0.972, 0.043, 98.812, 0.043, '2025-05-21 16:24:21', 21, 'student');

-- ----------------------------
-- Table structure for video_processing_status
-- ----------------------------
DROP TABLE IF EXISTS `video_processing_status`;
CREATE TABLE `video_processing_status`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `course_id` bigint(20) NOT NULL COMMENT '课程ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '视频类型（student/teacher）',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理状态（PENDING, PROCESSING, COMPLETED, ERROR）',
  `progress` int(3) NOT NULL DEFAULT 0 COMMENT '处理进度（0-100）',
  `error_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '错误信息',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_course_type`(`course_id`, `type`) USING BTREE COMMENT '确保每个课程的每种类型只有一条记录'
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频处理状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of video_processing_status
-- ----------------------------
INSERT INTO `video_processing_status` VALUES (1, 12, 'teacher', 'ERROR', 10, 'java.io.FileNotFoundException: C:\\Users\\Jay\\AppData\\Local\\Temp\\tomcat.9080.11010776164832325910\\work\\Tomcat\\localhost\\ROOT\\upload_821ad588_45cd_4e27_857a_bcaddacf2bca_00000000.tmp (系统找不到指定的文件。)', '2025-05-21 15:53:35', '2025-05-21 15:53:35');
INSERT INTO `video_processing_status` VALUES (2, 12, 'student', 'ERROR', 10, 'java.io.FileNotFoundException: C:\\Users\\Jay\\AppData\\Local\\Temp\\tomcat.9080.11010776164832325910\\work\\Tomcat\\localhost\\ROOT\\upload_821ad588_45cd_4e27_857a_bcaddacf2bca_00000003.tmp (系统找不到指定的文件。)', '2025-05-21 15:53:38', '2025-05-21 15:53:38');
INSERT INTO `video_processing_status` VALUES (3, 13, 'teacher', 'ERROR', 10, 'java.io.FileNotFoundException: C:\\Users\\Jay\\AppData\\Local\\Temp\\tomcat.9080.11010776164832325910\\work\\Tomcat\\localhost\\ROOT\\upload_821ad588_45cd_4e27_857a_bcaddacf2bca_00000006.tmp (系统找不到指定的文件。)', '2025-05-21 15:54:40', '2025-05-21 15:54:41');
INSERT INTO `video_processing_status` VALUES (4, 13, 'student', 'ERROR', 10, 'java.io.FileNotFoundException: C:\\Users\\Jay\\AppData\\Local\\Temp\\tomcat.9080.11010776164832325910\\work\\Tomcat\\localhost\\ROOT\\upload_821ad588_45cd_4e27_857a_bcaddacf2bca_00000009.tmp (系统找不到指定的文件。)', '2025-05-21 15:54:45', '2025-05-21 15:54:45');
INSERT INTO `video_processing_status` VALUES (5, 14, 'teacher', 'ERROR', 5, 'C:\\Users\\Jay\\AppData\\Local\\Temp\\tomcat.9080.7030012766728056901\\work\\Tomcat\\localhost\\ROOT\\upload_9cff756a_aed3_4ec4_b98b_60d4cd71a82e_00000000.tmp', '2025-05-21 15:58:50', '2025-05-21 15:58:51');
INSERT INTO `video_processing_status` VALUES (6, 14, 'student', 'ERROR', 5, 'C:\\Users\\Jay\\AppData\\Local\\Temp\\tomcat.9080.7030012766728056901\\work\\Tomcat\\localhost\\ROOT\\upload_9cff756a_aed3_4ec4_b98b_60d4cd71a82e_00000003.tmp', '2025-05-21 15:59:16', '2025-05-21 15:59:16');
INSERT INTO `video_processing_status` VALUES (7, 15, 'teacher', 'COMPLETED', 100, NULL, '2025-05-21 16:01:58', '2025-05-21 16:02:06');
INSERT INTO `video_processing_status` VALUES (8, 15, 'student', 'COMPLETED', 100, NULL, '2025-05-21 16:02:06', '2025-05-21 16:02:26');
INSERT INTO `video_processing_status` VALUES (9, 16, 'teacher', 'COMPLETED', 100, NULL, '2025-05-21 16:03:17', '2025-05-21 16:03:23');
INSERT INTO `video_processing_status` VALUES (10, 16, 'student', 'COMPLETED', 100, NULL, '2025-05-21 16:03:21', '2025-05-21 16:06:08');
INSERT INTO `video_processing_status` VALUES (11, 17, 'teacher', 'COMPLETED', 100, NULL, '2025-05-21 16:08:38', '2025-05-21 16:08:43');
INSERT INTO `video_processing_status` VALUES (12, 17, 'student', 'COMPLETED', 100, NULL, '2025-05-21 16:08:44', '2025-05-21 16:09:00');
INSERT INTO `video_processing_status` VALUES (13, 18, 'teacher', 'COMPLETED', 100, NULL, '2025-05-21 16:10:55', '2025-05-21 16:11:11');
INSERT INTO `video_processing_status` VALUES (14, 19, 'teacher', 'COMPLETED', 100, NULL, '2025-05-21 16:14:37', '2025-05-21 16:14:43');
INSERT INTO `video_processing_status` VALUES (15, 19, 'student', 'COMPLETED', 100, NULL, '2025-05-21 16:14:42', '2025-05-21 16:15:06');
INSERT INTO `video_processing_status` VALUES (16, 20, 'teacher', 'COMPLETED', 100, NULL, '2025-05-21 16:15:36', '2025-05-21 16:15:44');
INSERT INTO `video_processing_status` VALUES (17, 20, 'student', 'COMPLETED', 100, NULL, '2025-05-21 16:15:41', '2025-05-21 16:16:00');
INSERT INTO `video_processing_status` VALUES (18, 21, 'teacher', 'COMPLETED', 100, NULL, '2025-05-21 16:24:00', '2025-05-21 16:24:06');
INSERT INTO `video_processing_status` VALUES (19, 21, 'student', 'COMPLETED', 100, NULL, '2025-05-21 16:24:05', '2025-05-21 16:24:21');

SET FOREIGN_KEY_CHECKS = 1;
