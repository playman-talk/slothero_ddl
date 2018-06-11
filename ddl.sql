CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL,
  `email` varchar(255) NOT NULL COMMENT 'メールアドレス',
  `password` varchar(64) NOT NULL COMMENT 'パスワード',
  `role` tinyint(1) NOT NULL COMMENT '0:admin, 1:user',
  `created_id` int NOT NULL COMMENT '作成者',
  `last_login_at` datetime DEFAULT NULL COMMENT '最終ログイン',
  `login_counts` int(6) NOT NULL DEFAULT '0' COMMENT 'ログイン回数',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='アカウント';

CREATE TABLE IF NOT EXISTS `uploads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名前',
  `url_prefix` varchar(64) NOT NULL COMMENT '第1階層',
  `contents_path` varchar(255) NOT NULL COMMENT 'URL',
  `s3_url` varchar(255) NOT NULL COMMENT 'S3 URL',
  `memo` text DEFAULT NULL COMMENT 'メモ',
  `public_started_at` datetime NOT NULL COMMENT '公開開始日時',
  `public_ended_at` datetime NOT NULL COMMENT '公開終了日時',
  `category` set('dummy') DEFAULT NULL COMMENT '検索用カテゴリ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='アップロード';

CREATE TABLE IF NOT EXISTS `upload_histories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `upload_id` int NOT NULL COMMENT 'アップロード id',
  `s3_url` varchar(255) NOT NULL COMMENT 'S3 URL',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='アップロード履歴';

CREATE TABLE IF NOT EXISTS `article_series` (
  `id` int NOT NULL AUTO_INCREMENT,
  `upload_id` int NOT NULL COMMENT 'イメージ画像',
  `title` varchar(255) NOT NULL COMMENT 'シリーズ名',
  `body` text NOT NULL COMMENT 'シリーズ説明',
  `meta_ogp` varchar(255) NOT NULL COMMENT 'OGP画像',
  `meta_keyword` varchar(255) NOT NULL COMMENT 'meta keyword',
  `meta_description` varchar(255) NOT NULL COMMENT 'meta description',
  `memo` text DEFAULT NULL COMMENT 'メモ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='記事シリーズ';

CREATE TABLE IF NOT EXISTS `sources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `upload_id` int NOT NULL COMMENT '出稿元TOP画像',
  `name` varchar(255) NOT NULL COMMENT '出稿元名',
  `url` varchar(255) NOT NULL COMMENT 'リンク先',
  `memo` text DEFAULT NULL COMMENT 'メモ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='記事出稿元';

CREATE TABLE IF NOT EXISTS `article_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'テンプレート名',
  `head` text DEFAULT NULL COMMENT 'HTMLヘッダー',
  `body` text DEFAULT NULL COMMENT 'HTMLボディ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='記事テンプレート';

CREATE TABLE IF NOT EXISTS `reporters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `upload_id_title` varchar(32) DEFAULT NULL COMMENT '記者画像',
  `upload_id_pc` int NOT NULL COMMENT '記者名画像 PC',
  `upload_id_sp` int NOT NULL COMMENT '記者名画像 SP',
  `name` varchar(255) NOT NULL COMMENT '名前',
  `title` varchar(255) NOT NULL COMMENT '肩書',
  `body` text NOT NULL COMMENT '記者説明',
  `meta_ogp` varchar(255) NOT NULL COMMENT 'OGP画像',
  `meta_keyword` varchar(255) NOT NULL COMMENT 'meta keyword',
  `meta_description` varchar(255) NOT NULL COMMENT 'meta description',
  `memo` text DEFAULT NULL COMMENT 'メモ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`upload_id_pc`) REFERENCES `uploads` (`id`),
  FOREIGN KEY (`upload_id_sp`) REFERENCES `uploads` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='記事記者';

CREATE TABLE IF NOT EXISTS `games` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '名前',
  `upload_id` int DEFAULT NULL COMMENT '機種画像',
  `url_prefix` varchar(64) NOT NULL COMMENT '第1階層',
  `memo` text DEFAULT NULL COMMENT 'メモ',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公開フラグ',
  `public_ended_at` datetime NOT NULL DEFAULT '9999-12-31 00:00:00' COMMENT '公開終了日時',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='パチンコ・スロットテーブル';

CREATE TABLE IF NOT EXISTS `game_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL COMMENT 'パチンコスロット id',
  `title` varchar(255) NOT NULL COMMENT 'タイトル',
  `subtitle` varchar(255) NOT NULL COMMENT 'サブタイトル',
  `head` text DEFAULT NULL COMMENT 'HTMLヘッダー',
  `body` text DEFAULT NULL COMMENT 'HTMLボディ',
  `meta_ogp` varchar(255) NOT NULL COMMENT 'OGP画像',
  `meta_keyword` varchar(255) NOT NULL COMMENT 'meta keyword',
  `meta_description` varchar(255) NOT NULL COMMENT 'meta description',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`game_id`) REFERENCES `games` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='記事コンテンツ';

CREATE TABLE IF NOT EXISTS `articles` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '記事名',
  `upload_id` int DEFAULT NULL COMMENT '機種画像',
  `game_id` int NOT NULL COMMENT 'パチンコスロット',
  `reporter_id` int NOT NULL COMMENT '記者 id',
  `series_id` int NOT NULL COMMENT 'シリーズ id',
  `source_id` int NOT NULL COMMENT '出稿元 id',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公開フラグ',
  `public_at` datetime NOT NULL COMMENT '公開開始日日時',
  `start_at` datetime NOT NULL COMMENT '開始日',
  `ended_at` datetime NOT NULL DEFAULT '9999-12-31 00:00:00' COMMENT '終了日時',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`),
  FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`),
  FOREIGN KEY (`series_id`) REFERENCES `article_series` (`id`),
  FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='games table記事';

CREATE TABLE IF NOT EXISTS `article_contents` ( 
  `id` int NOT NULL AUTO_INCREMENT,
  `article_id` varchar(32) NOT NULL COMMENT '記事 id',
  `title` varchar(255) NOT NULL COMMENT 'タイトル',
  `subtitle` varchar(255) NOT NULL COMMENT 'サブタイトル',
  `head` text DEFAULT NULL COMMENT 'HTMLヘッダー',
  `body` text DEFAULT NULL COMMENT 'HTMLボディ',
  `public_status` enum('EDITING','PENDING','REQUEST','APPROVAL') NOT NULL DEFAULT 'EDITING' COMMENT '公開状態',
  `meta_ogp` varchar(255) NOT NULL COMMENT 'OGP画像',
  `meta_keyword` varchar(255) NOT NULL COMMENT 'meta keyword',
  `meta_description` varchar(255) NOT NULL COMMENT 'meta description',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='記事コンテンツ';

CREATE TABLE IF NOT EXISTS `presses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL COMMENT 'パチンコスロット id',
  `reporter_id` int NOT NULL COMMENT '記者 id',
  `source_id` int NOT NULL COMMENT '出稿元 id',
  `url_prefix` varchar(64) NOT NULL COMMENT '第1階層',
  `name` varchar(255) NOT NULL COMMENT '記事名',
  `public_at` datetime NOT NULL COMMENT '公開開始日日時',
  `start_at` datetime NOT NULL COMMENT '開始日',
  `ended_at` datetime NOT NULL DEFAULT '9999-12-31 00:00:00' COMMENT '終了日時',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`),
  FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ニュース系の記事';

CREATE TABLE IF NOT EXISTS `press_contents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `press_id` int NOT NULL COMMENT 'ニュース id',
  `title` varchar(255) NOT NULL COMMENT 'タイトル',
  `subtitle` varchar(255) NOT NULL COMMENT 'サブタイトル',
  `head` text DEFAULT NULL COMMENT 'HTMLヘッダー',
  `body` text DEFAULT NULL COMMENT 'HTMLボディ',
  `public_at` datetime NOT NULL COMMENT '公開日時',
  `public_started_at` datetime NOT NULL COMMENT '公開開始日時',
  `public_status` enum('EDITING','PENDING','REQUEST','APPROVAL') NOT NULL DEFAULT 'EDITING' COMMENT '公開状態',
  `meta_ogp` varchar(255) NOT NULL COMMENT 'OGP画像',
  `meta_keyword` varchar(255) NOT NULL COMMENT 'meta keyword',
  `meta_description` varchar(255) NOT NULL COMMENT 'meta description',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`press_id`) REFERENCES `presses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='ニュース系のコンテンツ';

CREATE TABLE IF NOT EXISTS `specials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url_prefix` varchar(64) NOT NULL COMMENT '第1階層',
  `name` varchar(255) NOT NULL COMMENT '特集名',
  `memo` text DEFAULT NULL COMMENT 'メモ',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公開フラグ',
  `public_at` datetime NOT NULL COMMENT '公開開始日日時',
  `start_at` datetime NOT NULL COMMENT '開始日',
  `ended_at` datetime NOT NULL DEFAULT '9999-12-31 00:00:00' COMMENT '終了日時',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='特集記事';

CREATE TABLE IF NOT EXISTS `special_contents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `special_id` int NOT NULL COMMENT '特集記事 id',
  `title` varchar(255) NOT NULL COMMENT 'タイトル',
  `subtitle` varchar(255) NOT NULL COMMENT 'サブタイトル',
  `head` text DEFAULT NULL COMMENT 'HTMLヘッダー',
  `body` text DEFAULT NULL COMMENT 'HTMLボディ',
  `public_status` enum('EDITING','PENDING','REQUEST','APPROVAL') NOT NULL DEFAULT 'EDITING' COMMENT '公開状態',
  `meta_ogp` varchar(255) NOT NULL COMMENT 'OGP画像',
  `meta_keyword` varchar(255) NOT NULL COMMENT 'meta keyword',
  `meta_description` varchar(255) NOT NULL COMMENT 'meta description',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`special_id`) REFERENCES `specials` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='特集コンテンツ';

CREATE TABLE IF NOT EXISTS `carousel_contents` (
  `id` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'カルーセルコンテンツ名',
  `public_started_at` datetime NOT NULL COMMENT '公開開始日時',
  `public_ended_at` datetime NOT NULL DEFAULT '9999-12-31 00:00:00' COMMENT '公開終了日時',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公開フラグ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='カルーセルコンテンツ';

CREATE TABLE IF NOT EXISTS `carousels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'カルーセル名',
  `content_id_1` varchar(32) NOT NULL COMMENT 'カルーセルコンテンツ id 1',
  `content_id_2` varchar(32) DEFAULT NULL COMMENT 'カルーセルコンテンツ id 2',
  `content_id_3` varchar(32) DEFAULT NULL COMMENT 'カルーセルコンテンツ id 3',
  `content_id_4` varchar(32) DEFAULT NULL COMMENT 'カルーセルコンテンツ id 4',
  `content_id_5` varchar(32) DEFAULT NULL COMMENT 'カルーセルコンテンツ id 5',
  `content_id_6` varchar(32) DEFAULT NULL COMMENT 'カルーセルコンテンツ id 6',
  `is_random` tinyint(1) NOT NULL COMMENT 'ランダム表示フラグ',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公開フラグ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`content_id_1`) REFERENCES `carousel_contents` (`id`),
  FOREIGN KEY (`content_id_2`) REFERENCES `carousel_contents` (`id`),
  FOREIGN KEY (`content_id_3`) REFERENCES `carousel_contents` (`id`),
  FOREIGN KEY (`content_id_4`) REFERENCES `carousel_contents` (`id`),
  FOREIGN KEY (`content_id_5`) REFERENCES `carousel_contents` (`id`),
  FOREIGN KEY (`content_id_6`) REFERENCES `carousel_contents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='カルーセル';

CREATE TABLE IF NOT EXISTS `informations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'タイトル',
  `title` varchar(255) NOT NULL COMMENT '和文タイトル',
  `body` text DEFAULT NULL COMMENT '和文本文',
  `url` varchar(255) DEFAULT NULL COMMENT '和文リンク',
  `level` enum('LOW','MEDIUM','HIGH') NOT NULL DEFAULT 'LOW' COMMENT 'レベル',
  `public_at` datetime NOT NULL COMMENT '表示日時',
  `is_top_displayed` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'TOP公開フラグ',
  `top_start_at` datetime DEFAULT NULL COMMENT 'TOP公開日時',
  `top_ended_at` datetime DEFAULT NULL COMMENT 'TOP終了日時',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公開フラグ',
  `public_started_at` datetime NOT NULL COMMENT '公開日時',
  `public_ended_at` datetime NOT NULL DEFAULT '9999-12-31 00:00:00' COMMENT '終了日時',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='お知らせ';

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'タグ名',
  `is_displayed` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'リスト表示フラグ',
  `category` set('dummy') DEFAULT NULL COMMENT '検索用カテゴリ',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='タグ';

CREATE TABLE IF NOT EXISTS `tag_relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag_id` int NOT NULL COMMENT 'タグ id',
  `table_name` enum('articles','specials','presses') NOT NULL COMMENT 'テーブル名',
  `created_id` int NOT NULL COMMENT '作成者',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  `updated_id` int NOT NULL COMMENT '更新者',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='タグ紐付け';



