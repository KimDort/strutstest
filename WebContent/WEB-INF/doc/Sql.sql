select * from project where project_start >= '2017-01-01' and project_end <= '2017-12-31'
SELECT
					MEMBER_NO, MEMBER_NAME, MEMBER_HAVESKILL, MEMBER_POSITION, MEMBER_ISNEW 
						FROM 
					EMPLOYEE 
				 	WHERE 
							MEMBER_ISEXIT = 'N'
						AND MEMBER_NO NOT IN(SELECT MEMBER_NO FROM PROJECT_JOIN)

SELECT 
						R, MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,
						MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,
						MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,
						CASE 
							WHEN PROJECT_HISTORY > 0 THEN '참가중'
							WHEN PROJECT_HISTORY <= 0 THEN '미참가'
						END AS PROJECT_HISTORY,  
						MEMBER_HAVESKILL, MEMBER_ISEXIT 
						FROM 
						(SELECT ROWNUM AS R,
							MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,
							MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,
							MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,
							PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT 
							FROM 
								(SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,
									MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,
									MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW, 
									(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) 
									AS PROJECT_HISTORY, MEMBER_HAVESKILL, MEMBER_ISEXIT						
								FROM 
									EMPLOYEE 
									ORDER BY MEMBER_NO DESC)
						)
					WHERE R >= 1 
					AND R <= 10  
					AND MEMBER_ISEXIT = 'N'
, 
						CASE ISINPROJECT
							WHEN ISINPROJECT > 0 THEN 'Participating'
							WHEN ISINPROJECT <= 0 THEN 'No participation'
							END
SELECT *  FROM (SELECT ROWNUM AS R, MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER, 
MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL, MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,
PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT 
FROM (SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER, 
MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL, 
MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW, 
(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) AS PROJECT_HISTORY, MEMBER_HAVESKILL, MEMBER_ISEXIT 
FROM EMPLOYEE ORDER BY MEMBER_NAME ASC))WHERE R >=1 AND R <= 5 AND MEMBER_NO NOT IN(SELECT MEMBER_NO FROM PROJECT_JOIN)

SELECT 
	JOIN_NO, MEMBER_NO, PROJECT_NO, JOIN_POSITION, JOIN_IN, JOIN_OUT, 
	(SELECT MEMBER_NAME FROM EMPLOYEE WHERE EMPLOYEE.MEMBER_NO=PROJECT_JOIN.MEMBER_NO)AS MEMBER_NAME 
	FROM PROJECT_JOIN 
	WHERE JOIN_NO=21
SELECT 
	EMPLOYEE.MEMBER_NO, EMPLOYEE.MEMBER_NAME, EMPLOYEE.MEMBER_HAVESKILL  
	FROM EMPLOYEE, PROJECT_JOIN
	WHERE EMPLOYEE.MEMBER_NO=PROJECT_JOIN.MEMBER_NO
	AND PROJECT_JOIN.PROJECT_NO=1

	SELECT 
						PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, PROJECT_END, 
						PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL, PROJECT_ETC, PROJECT_ISDELETE, MEMBER_COUNT 
					FROM 
						(SELECT 
								ROWNUM AS R, PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, 
								PROJECT_END, PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL, PROJECT_ETC, PROJECT_ISDELETE, MEMBER_COUNT 
						FROM 
						(SELECT 
								PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, PROJECT_END, 
								PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL, PROJECT_ETC, PROJECT_ISDELETE,
								(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.PROJECT_NO = PROJECT.PROJECT_NO) AS 
								MEMBER_COUNT
							FROM 
								PROJECT 
								ORDER BY PROJECT_NO DESC)
						)
					WHERE 
						PROJECT_NO > 0 
					AND PROJECT_ISDELETE != 'Y'
					AND R >=1 AND R <= 10 
					AND PROJECT_ISDELETE='N'

SELECT * FROM (SELECT ROWNUM AS R, MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,
					MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL
					MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW,
					PROJECT_HISTORY,  MEMBER_HAVESKILL, MEMBER_ISEXIT 
					FROM (SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,
					MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,
					MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_ISNEW, ROWNUM AS numRow,
					(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) AS PROJECT_HISTORY,
					 MEMBER_HAVESKILL, MEMBER_ISEXIT FROM EMPLOYEE ORDER BY MEMBER_NO DESC)
					 )WHERE R >= 1 AND R <= 100 AND MEMBER_ISEXIT = 'N'
CREATE SEQUENCE EMPLOYEESEQ START WITH 1 INCREMENT BY 1;
UPDATE CAREER SET CAREER_PERIOD_END=(SELECT NVL(CAREER_PERIOD_END, SYSDATE) FROM CAREER) WHERE MEMBER_NO=2
UPDATE CAREER SET CAREER_PERIOD_END=(SELECT NVL(CAREER_PERIOD_END, SYSDATE) FROM CAREER WHERE MEMBER_NO=15)
SELECT PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, PROJECT_END, PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL,
PROJECT_ETC FROM

SELECT CAREER_NO, MEMBER_NO, CAREER_PERIOD_START, NVL(CAREER_PERIOD_END,SYSDATE)AS CAREER_PERIOD_END FROM CAREER;

(SELECT ROWNUM AS R, PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, PROJECT_END, PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL,
PROJECT_ETC FROM
(SELECT PROJECT_NO, PROJECT_NAME, PROJECT_CONTENT, PROJECT_START, PROJECT_END, PROJECT_ORDER_COMPANY, PROJECT_CREATE_SKILL,
PROJECT_ETC FROM PROJECT ORDER BY PROJECT_NO DESC))
WHERE PROJECT_NO > 0 AND R >=1 AND R <= 10 AND PROJECT_NAME LIKE '%KIM%';
UPDATE CAREER SET CAREER_PERIOD_END=(SELECT NVL(CAREER_PERIOD_END, SYSDATE) FROM CAREER WHERE MEMBER_NO=2);
SELECT * FROM (SELECT ROWNUM AS R,  
	MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,
	MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,
	MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_WORK,
	PROJECT_HISTORY, MEMBER_WORK_DETAIL, MEMBER_HAVESKILL 
	FROM (SELECT MEMBER_NO, MEMBER_NAME, MEMBER_COMPANY, MEMBER_IDNUMBER,
				MEMBER_ZIPCODE, MEMBER_ADDRESS, MEMBER_ADDRESS_DETAIL,
				MEMBER_RANK, MEMBER_JOIN, MEMBER_OUT, MEMBER_WORK,
				(SELECT COUNT(*) FROM PROJECT_JOIN WHERE PROJECT_JOIN.MEMBER_NO=EMPLOYEE.MEMBER_NO) AS PROJECT_HISTORY,
				MEMBER_WORK_DETAIL, MEMBER_HAVESKILL 
				FROM EMPLOYEE ORDER BY MEMBER_NO DESC
	))WHERE R >= 1 AND R <= 10 
	AND Member_work LIKE '%Regular%'
	AND MEMBER_Work_detail LIKE '%%'
	AND Member_name LIKE '%源�%'
	UPDATE CAREER SET CAREER_PERIOD_END=(SELECT NVL(CAREER_PERIOD_END, SYSDATE) FROM CAREER WHERE MEMBER_NO=1);
	select * from career;
	select * from employee;
	(SELECT NVL(CAREER_PERIOD_END,SYSDATE) AS CAREER_PERIOD_END FROM CAREER WHERE career_no=1)
	SELECT CASE 
			WHEN CAREER_PERIOD_END IS NULL THEN SYSDATE 
			WHEN CAREER_PERIOD_END='' THEN SYSDATE 
			ELSE CAREER_PERIOD_END
		END AS CARRER_END 
	FROM CAREER;
	((SELECT NVL(CAREER_PERIOD_END,SYSDATE) AS CAREER_PERIOD_END FROM CAREER) )
	INSERT INTO CAREER VALUES((SELECT NVL(MAX(CAREER_NO),0)+1 FROM CAREER),
					(SELECT MAX(MEMBER_NO) FROM EMPLOYEE), '2016-04-10', 
					(SELECT CASE 
					WHEN CAREER_PERIOD_END IS NULL THEN SYSDATE  
					WHEN CAREER_PERIOD_END='' THEN SYSDATE 
					ELSE CAREER_PERIOD_END 
					END AS CARRER_END 
					FROM CAREER),
					 '�븘�씠罹붾ℓ�땲吏�癒쇳듃', 'Staff', 'SI')
					 
					 
/* Drop Tables */

DROP TABLE CAREER CASCADE CONSTRAINTS;
DROP TABLE LICENSE CASCADE CONSTRAINTS;
DROP TABLE PROJECT_JOIN CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE PROJECT CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE CAREER
(
	CAREER_NO number NOT NULL,
	MEMBER_NO number NOT NULL,
	CAREER_PERIOD_START date NOT NULL,
	CAREER_PERIOD_END date,
	CAREER_COMPANY varchar2(100) NOT NULL,
	CAREER_RANK varchar2(9) NOT NULL,
	CAREER_POSITION varchar2(100),
	PRIMARY KEY (CAREER_NO)
);


CREATE TABLE Employee
(
	MEMBER_NO number NOT NULL,
	MEMBER_NAME varchar2(28) NOT NULL,
	MEMBER_COMPANY varchar2(38),
	MEMBER_IDNUMBER varchar2(30) NOT NULL,
	MEMBER_ZIPCODE varchar2(10) NOT NULL,
	MEMBER_ADDRESS varchar2(200) NOT NULL,
	MEMBER_ADDRESS_DETAIL varchar2(100),
	MEMBER_RANK varchar2(50) NOT NULL,
	MEMBER_JOIN date NOT NULL,
	MEMBER_OUT date,
	MEMBER_ISNEW varchar2(20),
	MEMBER_HAVESKILL varchar2(1000),
	MEMBER_ISEXIT char,
	MEMBER_POSITION varchar2(100),
	PRIMARY KEY (MEMBER_NO)
);


CREATE TABLE LICENSE
(
	LICENSE_NO number NOT NULL,
	MEMBER_NO number NOT NULL,
	LICENSE_NAME varchar2(50) NOT NULL,
	LICENSE_LEVEL varchar2(10),
	LICENSE_GETDATE date,
	LICENSE_PUBLISHER varchar2(100),
	PRIMARY KEY (LICENSE_NO)
);


CREATE TABLE PROJECT
(
	PROJECT_NO number NOT NULL,
	PROJECT_NAME varchar2(1000) NOT NULL,
	PROJECT_CONTENT varchar2(1000),
	PROJECT_START date,
	PROJECT_END date,
	PROJECT_ORDER_COMPANY varchar2(200),
	PROJECT_CREATE_SKILL varchar2(500),
	PROJECT_ETC varchar2(1000),
	PROJECT_ISDELETE char,
	PRIMARY KEY (PROJECT_NO)
);


CREATE TABLE PROJECT_JOIN
(
	JOIN_NO number NOT NULL,
	MEMBER_NO number NOT NULL,
	PROJECT_NO number NOT NULL,
	JOIN_POSITION varchar2(500) NOT NULL,
	JOIN_IN date,
	JOIN_OUT date,
	PRIMARY KEY (JOIN_NO)
);



/* Create Foreign Keys */

ALTER TABLE CAREER
	ADD FOREIGN KEY (MEMBER_NO)
	REFERENCES Employee (MEMBER_NO)
;


ALTER TABLE LICENSE
	ADD FOREIGN KEY (MEMBER_NO)
	REFERENCES Employee (MEMBER_NO)
;


ALTER TABLE PROJECT_JOIN
	ADD FOREIGN KEY (MEMBER_NO)
	REFERENCES Employee (MEMBER_NO)
;


ALTER TABLE PROJECT_JOIN
	ADD FOREIGN KEY (PROJECT_NO)
	REFERENCES PROJECT (PROJECT_NO)
;



