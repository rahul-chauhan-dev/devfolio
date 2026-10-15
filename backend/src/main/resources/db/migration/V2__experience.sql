CREATE TABLE experience(
	id	BIGINT GENERATED ALWAYS AS IDENTITY,
	type	VARCHAR(30) NOT NULL,
	title	VARCHAR(100) NOT NULL,
	organization	 VARCHAR(100) NOT NULL,
	start_date	DATE NOT NULL,
	end_date	DATE,
	description	VARCHAR(500) NOT NULL,
	display_order	INTEGER NOT NULL DEFAULT 0,
	CONSTRAINT pk_experience PRIMARY KEY(id),
	CONSTRAINT ck_experience_type CHECK (type in ('WORK','EDUCATION','CERTIFICATION', 'VOLUNTEERING')),
	CONSTRAINT ck_experience_end_after_start CHECK (end_date IS NULL OR end_date>=start_date)

);
