drop table if exists emails;

CREATE TABLE emails (
 	id 			BIGINT 			NOT NULL AUTO_INCREMENT ,
	name 		VARCHAR( 150 ) 	NOT NULL ,
	domain 		VARCHAR( 100 ) 	NOT NULL ,
	to_all 		TEXT 			NOT NULL ,
	cc_email	TEXT,
	bcc_email	TEXT,	
	from_email	VARCHAR( 250 ) 	NOT NULL ,
	subject 	VARCHAR( 250 ) 	NOT NULL ,
	body 		LONGTEXT 		NOT NULL ,
	header 		TEXT 			NOT NULL ,
	message_id	varchar(250),
	date 		DATETIME 		NOT NULL ,
	created_at 	DATETIME 		DEFAULT NULL,
	PRIMARY KEY(id ),
	INDEX (name, message_id)
);
