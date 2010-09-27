/*
Navicat MySQL Data Transfer

Source Server         : LocalHost
Source Server Version : 50142
Source Host           : localhost:3306
Source Database       : adserving

Target Server Type    : MYSQL
Target Server Version : 50142
File Encoding         : 65001

Date: 2010-09-24 15:33:02
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `ad_groups`
-- ----------------------------
DROP TABLE IF EXISTS `ad_groups`;
CREATE TABLE `ad_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`campaign_id`),
  CONSTRAINT `campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ad_groups
-- ----------------------------
INSERT INTO `ad_groups` VALUES ('1', '1', 'Test Ad Group 1', null, null, null);
INSERT INTO `ad_groups` VALUES ('2', '1', 'Test Ad Group 2', null, null, null);
INSERT INTO `ad_groups` VALUES ('3', '1', 'Image Ad Group 3', null, null, null);

-- ----------------------------
-- Table structure for `ad_types`
-- ----------------------------
DROP TABLE IF EXISTS `ad_types`;
CREATE TABLE `ad_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `size` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ad_types
-- ----------------------------
INSERT INTO `ad_types` VALUES ('1', 'Text 300x250', 'text', '300x250');
INSERT INTO `ad_types` VALUES ('2', 'Mobile leaderboard', 'mobile', '300x50');
INSERT INTO `ad_types` VALUES ('3', 'Banner', 'display', '468x60');
INSERT INTO `ad_types` VALUES ('4', 'Leaderboard', 'display', '728x90');
INSERT INTO `ad_types` VALUES ('5', 'Square', 'display', '250x250');
INSERT INTO `ad_types` VALUES ('6', 'Small square', 'display', '200x200');
INSERT INTO `ad_types` VALUES ('7', 'Large rectangle', 'display', '336x280');
INSERT INTO `ad_types` VALUES ('8', 'Inline rectangle', 'display', '300x250');
INSERT INTO `ad_types` VALUES ('9', 'Skyscrapper', 'display', '120x600');
INSERT INTO `ad_types` VALUES ('10', 'Wide skyscrapper', 'display', '160x600');
INSERT INTO `ad_types` VALUES ('11', 'Monster', 'display', '300x600');
INSERT INTO `ad_types` VALUES ('12', 'Text 300x600', 'text', '300x250');

-- ----------------------------
-- Table structure for `ads`
-- ----------------------------
DROP TABLE IF EXISTS `ads`;
CREATE TABLE `ads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ad_group_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(25) DEFAULT NULL,
  `description_line_1` varchar(35) DEFAULT NULL,
  `description_line_2` varchar(35) DEFAULT NULL,
  `description` varchar(70) DEFAULT NULL,
  `display_url` varchar(255) DEFAULT NULL,
  `destination_url` text,
  `destination_url_prefix` varchar(8) DEFAULT NULL,
  `bid_price` decimal(10,2) DEFAULT NULL,
  `bid_metric` varchar(16) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_group_id` (`ad_group_id`),
  CONSTRAINT `ad_group_id` FOREIGN KEY (`ad_group_id`) REFERENCES `ad_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ads
-- ----------------------------
INSERT INTO `ads` VALUES ('1', '1', 'Test Ad 1', 'first line on ad 1', '2nd line on ad 1', null, 'DaneJ.com/Ad1', 'www.danej.com/', 'http://', null, null, null, null, null);
INSERT INTO `ads` VALUES ('2', '1', 'Test Ad 2', 'first line on ad 2', '2nd line on ad 2', null, 'DaneJ.com/Ad2', 'www.danej.com/', 'http://', null, null, null, null, null);
INSERT INTO `ads` VALUES ('3', '1', 'Test Ad 3', 'first line on ad 3', '2nd line on ad 3', '', 'DaneJ.com/Ad3', 'www.danej.com/', 'http://', null, null, null, null, null);
INSERT INTO `ads` VALUES ('4', '2', 'Test Ad 4', 'first line on ad 4', '2nd line on ad 4', null, 'DaneJ.com/Ad4', 'www.danej.com/', 'http://', null, null, null, null, null);
INSERT INTO `ads` VALUES ('5', '3', 'Image Test Ad 5', null, null, null, null, 'www.danej.com/', 'http://', null, null, null, null, null);
INSERT INTO `ads` VALUES ('6', '2', 'Test Ad 5', 'first line on ad 5', '2nd line on ad 5', null, 'DaneJ.com/Ad5', 'www.danej.com/', 'http://', null, null, null, null, null);
INSERT INTO `ads` VALUES ('7', '2', 'Test Ad 6', 'first line on ad 6', '2nd line on ad 6', null, 'DaneJ.com/Ad6', 'www.danej.com/', 'http://', null, null, null, null, null);

-- ----------------------------
-- Table structure for `campaigns`
-- ----------------------------
DROP TABLE IF EXISTS `campaigns`;
CREATE TABLE `campaigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of campaigns
-- ----------------------------
INSERT INTO `campaigns` VALUES ('1', 'Test Campaign 1', 'active', null, null, null);

-- ----------------------------
-- Table structure for `clicks`
-- ----------------------------
DROP TABLE IF EXISTS `clicks`;
CREATE TABLE `clicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` int(10) unsigned NOT NULL,
  `publisher_id` int(10) unsigned NOT NULL,
  `placement_id` int(10) unsigned NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clicks
-- ----------------------------

-- ----------------------------
-- Table structure for `images`
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ad_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `size` int(8) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ad_id` (`ad_id`),
  CONSTRAINT `ad_id` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES ('1', '1', '1', '1.gif', 'gif', '1000', '2010-09-17 14:51:09', null, null);
INSERT INTO `images` VALUES ('2', '2', '2', '2.gif', 'gif', '1000', '2010-09-17 14:51:37', null, null);
INSERT INTO `images` VALUES ('3', '3', '3', '3.gif', 'gif', '1000', '2010-09-17 14:51:52', null, null);
INSERT INTO `images` VALUES ('4', '4', '4', '4.gif', 'gif', '1000', '2010-09-17 14:52:05', null, null);
INSERT INTO `images` VALUES ('5', '5', 'Image', '300x250.gif', 'gif', '1000', null, null, null);
INSERT INTO `images` VALUES ('6', '6', '5', '5.gif', 'gif', '1000', null, null, null);
INSERT INTO `images` VALUES ('7', '7', '6', '6.gif', 'gif', '1000', null, null, null);

-- ----------------------------
-- Table structure for `impressions`
-- ----------------------------
DROP TABLE IF EXISTS `impressions`;
CREATE TABLE `impressions` (
  `ad_id` int(10) unsigned NOT NULL,
  `publisher_id` int(10) unsigned NOT NULL,
  `template_id` int(10) NOT NULL,
  `position` int(10) unsigned NOT NULL,
  `total` int(10) unsigned NOT NULL,
  `time_served` int(10) unsigned NOT NULL,
  UNIQUE KEY `ad_id-time_served_index` (`publisher_id`,`ad_id`,`template_id`,`position`,`time_served`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of impressions
-- ----------------------------
INSERT INTO `impressions` VALUES ('1', '1', '1', '1', '2', '1284998400');
INSERT INTO `impressions` VALUES ('1', '1', '1', '1', '13', '1285106400');
INSERT INTO `impressions` VALUES ('1', '1', '1', '1', '3', '1285110000');
INSERT INTO `impressions` VALUES ('1', '1', '1', '2', '11', '1285106400');
INSERT INTO `impressions` VALUES ('1', '1', '1', '2', '2', '1285110000');
INSERT INTO `impressions` VALUES ('1', '1', '1', '3', '9', '1285106400');
INSERT INTO `impressions` VALUES ('2', '1', '1', '1', '3', '1284998400');
INSERT INTO `impressions` VALUES ('2', '1', '1', '1', '14', '1285106400');
INSERT INTO `impressions` VALUES ('2', '1', '1', '1', '1', '1285110000');
INSERT INTO `impressions` VALUES ('2', '1', '1', '2', '15', '1285106400');
INSERT INTO `impressions` VALUES ('2', '1', '1', '2', '1', '1285110000');
INSERT INTO `impressions` VALUES ('2', '1', '1', '3', '10', '1285106400');
INSERT INTO `impressions` VALUES ('2', '1', '1', '3', '2', '1285110000');
INSERT INTO `impressions` VALUES ('2', '1', '2', '1', '25', '1285106400');
INSERT INTO `impressions` VALUES ('2', '1', '2', '1', '3', '1285110000');
INSERT INTO `impressions` VALUES ('2', '1', '2', '1', '1', '1285362000');
INSERT INTO `impressions` VALUES ('2', '1', '2', '2', '25', '1285106400');
INSERT INTO `impressions` VALUES ('2', '1', '2', '2', '1', '1285110000');
INSERT INTO `impressions` VALUES ('2', '1', '2', '3', '22', '1285106400');
INSERT INTO `impressions` VALUES ('2', '1', '2', '3', '2', '1285110000');
INSERT INTO `impressions` VALUES ('3', '1', '1', '1', '4', '1284998400');
INSERT INTO `impressions` VALUES ('3', '1', '1', '1', '9', '1285106400');
INSERT INTO `impressions` VALUES ('3', '1', '1', '1', '1', '1285110000');
INSERT INTO `impressions` VALUES ('3', '1', '1', '2', '8', '1285106400');
INSERT INTO `impressions` VALUES ('3', '1', '1', '2', '2', '1285110000');
INSERT INTO `impressions` VALUES ('3', '1', '1', '3', '9', '1285106400');
INSERT INTO `impressions` VALUES ('3', '1', '2', '1', '28', '1285106400');
INSERT INTO `impressions` VALUES ('3', '1', '2', '1', '2', '1285110000');
INSERT INTO `impressions` VALUES ('3', '1', '2', '2', '21', '1285106400');
INSERT INTO `impressions` VALUES ('3', '1', '2', '2', '1', '1285110000');
INSERT INTO `impressions` VALUES ('3', '1', '2', '3', '23', '1285106400');
INSERT INTO `impressions` VALUES ('3', '1', '2', '3', '3', '1285110000');
INSERT INTO `impressions` VALUES ('3', '1', '2', '3', '1', '1285362000');
INSERT INTO `impressions` VALUES ('4', '1', '1', '1', '4', '1285106400');
INSERT INTO `impressions` VALUES ('4', '1', '1', '2', '11', '1285106400');
INSERT INTO `impressions` VALUES ('4', '1', '1', '2', '1', '1285110000');
INSERT INTO `impressions` VALUES ('4', '1', '1', '3', '12', '1285106400');
INSERT INTO `impressions` VALUES ('4', '1', '1', '3', '1', '1285110000');
INSERT INTO `impressions` VALUES ('4', '1', '2', '1', '19', '1285106400');
INSERT INTO `impressions` VALUES ('4', '1', '2', '1', '1', '1285110000');
INSERT INTO `impressions` VALUES ('4', '1', '2', '2', '26', '1285106400');
INSERT INTO `impressions` VALUES ('4', '1', '2', '2', '4', '1285110000');
INSERT INTO `impressions` VALUES ('4', '1', '2', '2', '1', '1285362000');
INSERT INTO `impressions` VALUES ('4', '1', '2', '3', '27', '1285106400');
INSERT INTO `impressions` VALUES ('4', '1', '2', '3', '1', '1285110000');
INSERT INTO `impressions` VALUES ('5', '1', '3', '1', '55', '1285106400');
INSERT INTO `impressions` VALUES ('5', '1', '3', '1', '6', '1285110000');
INSERT INTO `impressions` VALUES ('6', '1', '1', '1', '17', '1285106400');
INSERT INTO `impressions` VALUES ('6', '1', '1', '1', '1', '1285110000');
INSERT INTO `impressions` VALUES ('6', '1', '1', '2', '13', '1285106400');
INSERT INTO `impressions` VALUES ('6', '1', '1', '3', '15', '1285106400');
INSERT INTO `impressions` VALUES ('6', '1', '1', '3', '3', '1285110000');
INSERT INTO `impressions` VALUES ('7', '1', '1', '1', '9', '1285106400');
INSERT INTO `impressions` VALUES ('7', '1', '1', '2', '8', '1285106400');
INSERT INTO `impressions` VALUES ('7', '1', '1', '3', '11', '1285106400');

-- ----------------------------
-- Table structure for `placement_positions`
-- ----------------------------
DROP TABLE IF EXISTS `placement_positions`;
CREATE TABLE `placement_positions` (
  `placement_id` int(10) unsigned DEFAULT NULL,
  `ad_id` int(10) unsigned DEFAULT NULL,
  `position` int(10) unsigned DEFAULT NULL,
  KEY `placement_id` (`placement_id`),
  CONSTRAINT `placement_id` FOREIGN KEY (`placement_id`) REFERENCES `placements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of placement_positions
-- ----------------------------
INSERT INTO `placement_positions` VALUES ('1', '1', '1');
INSERT INTO `placement_positions` VALUES ('1', '2', '2');
INSERT INTO `placement_positions` VALUES ('1', '3', '3');
INSERT INTO `placement_positions` VALUES ('2', '5', '1');
INSERT INTO `placement_positions` VALUES ('1', '4', '4');
INSERT INTO `placement_positions` VALUES ('1', '6', '5');
INSERT INTO `placement_positions` VALUES ('1', '7', '6');
INSERT INTO `placement_positions` VALUES ('3', '2', '1');
INSERT INTO `placement_positions` VALUES ('3', '3', '1');
INSERT INTO `placement_positions` VALUES ('3', '4', '1');

-- ----------------------------
-- Table structure for `placements`
-- ----------------------------
DROP TABLE IF EXISTS `placements`;
CREATE TABLE `placements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `publisher_id` int(10) unsigned NOT NULL,
  `template_id` int(10) unsigned NOT NULL,
  `ad_type_id` int(10) unsigned NOT NULL,
  `type` varchar(32) NOT NULL DEFAULT 'performance' COMMENT 'type would be manual, random, or performance based',
  PRIMARY KEY (`id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of placements
-- ----------------------------
INSERT INTO `placements` VALUES ('1', '1', '1', '1', 'performance');
INSERT INTO `placements` VALUES ('2', '1', '3', '8', 'performance');
INSERT INTO `placements` VALUES ('3', '1', '2', '1', 'performance');

-- ----------------------------
-- Table structure for `publishers`
-- ----------------------------
DROP TABLE IF EXISTS `publishers`;
CREATE TABLE `publishers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `contact_name` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of publishers
-- ----------------------------
INSERT INTO `publishers` VALUES ('1', 'KSL', 'http://www.ksl.com/', null, 'Daivd Cluff', '2010-09-17 14:42:59', null, null);

-- ----------------------------
-- Table structure for `templates`
-- ----------------------------
DROP TABLE IF EXISTS `templates`;
CREATE TABLE `templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `positions` int(10) unsigned DEFAULT NULL,
  `ad_type_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of templates
-- ----------------------------
INSERT INTO `templates` VALUES ('1', '300x250 roll over', '3', '1', null, null, null);
INSERT INTO `templates` VALUES ('2', '300x250 simple', '3', '1', null, null, null);
INSERT INTO `templates` VALUES ('3', '300x250 display', '1', '8', null, null, null);
