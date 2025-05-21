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

 Date: 21/05/2025 14:57:20
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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课堂分析数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classroom_analysis
-- ----------------------------
INSERT INTO `classroom_analysis` VALUES (1, 2, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);
INSERT INTO `classroom_analysis` VALUES (4, 4, 100, 0, 77.02855555555556, 0.04566666666666666, 3.6573333333333338);

-- ----------------------------
-- Table structure for course_info
-- ----------------------------
DROP TABLE IF EXISTS `course_info`;
CREATE TABLE `course_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `teacher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '教师姓名',
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `class_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '班级（如“高三1班”）',
  `start_time` datetime NOT NULL COMMENT '课程开始时间',
  `end_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '课程结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课程基本信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course_info
-- ----------------------------
INSERT INTO `course_info` VALUES (1, '朱凯', '肉饼制作实验课', '高二3班', '2025-05-14 16:25:43', '2025-05-14 16:40:56');
INSERT INTO `course_info` VALUES (2, '朱凯小哥哥', '肉饼制作实验课', '高二3班', '2025-05-14 16:34:38', '2025-05-14 17:10:03');
INSERT INTO `course_info` VALUES (3, '朱凯老师', '汉堡肉片实验课', '中专3班', '2025-05-14 19:59:55', '2025-05-14 19:59:54');
INSERT INTO `course_info` VALUES (4, '学哥', '汉堡配菜发明课', '本生砖3班', '2025-05-14 21:17:57', '2025-05-14 21:30:41');

-- ----------------------------
-- Table structure for discussion_text
-- ----------------------------
DROP TABLE IF EXISTS `discussion_text`;
CREATE TABLE `discussion_text`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL COMMENT '关联课程ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '讨论内容（如学生发言）',
  `timestamp` datetime NOT NULL COMMENT '发言时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `course_id`(`course_id` ASC) USING BTREE,
  CONSTRAINT `discussion_text_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '课堂讨论文本表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discussion_text
-- ----------------------------

-- ----------------------------
-- Table structure for emotion_record
-- ----------------------------
DROP TABLE IF EXISTS `emotion_record`;
CREATE TABLE `emotion_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `request_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `face_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anger` double NULL DEFAULT NULL,
  `disgust` double NULL DEFAULT NULL,
  `fear` double NULL DEFAULT NULL,
  `happiness` double NULL DEFAULT NULL,
  `neutral` double NULL DEFAULT NULL,
  `sadness` double NULL DEFAULT NULL,
  `surprise` double NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `course_id` bigint NULL DEFAULT NULL COMMENT '关联课程ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '记录类型（student/teacher）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_request_id`(`request_id` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '表情识别表' ROW_FORMAT = DYNAMIC;

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

SET FOREIGN_KEY_CHECKS = 1;
