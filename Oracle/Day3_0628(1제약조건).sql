-- 제약조건 설정은 create table, alter table 에서 합니다

-- 제약 조건 1: not null : col2컬럼은 반드시 값을 저장해야 한다.
CREATE TABLE tbl# (
	col1 varchar2(10),
	col2 number(3) NOT NULL
);

INSERT INTO tbl#(col2) VALUES (98);
INSERT INTO tbl#(col1) VALUES ('korean'); -- 오류 : col2컬럼의 NOT NULL 제약조건 위반
INSERT INTO tbl# VALUES ('korean', 78);
INSERT INTO tbl# VALUES ('korean', 88);

-- 확인
SELECT * FROM tbl#;

-- 새로운 제약조건을 2) unique를 갖는 col3
ALTER TABLE tbl# ADD col3 varchar2(10) UNIQUE; -- 유일한 값이어야 함 (유니크칼럼에는 null 허용)

-- 다음 insert를 순서대로 실행할때 오류가 발생하는 것은?
INSERT INTO tbl#(col1) VALUES ('english'); -- 오류
INSERT INTO tbl#(col2) VALUES (77);
INSERT INTO tbl#(col3) VALUES ('english'); -- 오류
INSERT INTO tbl#(col1,col2) VALUES ('english',88);
INSERT INTO tbl#(col2,col3) VALUES (88,'science');
INSERT INTO tbl#(col1,col3) VALUES ('science',88); -- 오류 (col2가 없음)
INSERT INTO tbl#(col1,col2,col3) VALUES ('english',89,'science'); -- 오류 : science를 위에서한번 넣어줬기 때문에(unique)
INSERT INTO tbl#(col1,col2,col3) VALUES ('english',89,'math');

-- 제약조건 3) 기본키 (primary key)는 not null 과 unique 제약조건
CREATE TABLE tbl2# (
	tno number(3) PRIMARY KEY,
	tid number(3) UNIQUE 
);
SELECT * FROM "TBL2#";
INSERT INTO tbl2#(tno) VALUES (123);
INSERT INTO tbl2#(tno) VALUES (123); -- 무결성 제약 조건(pk 기본키 컬럼)에 위배됩니다(unique)
INSERT INTO tbl2#(tid) VALUES (123); -- NOT NULL 

-- 제약조건 4) check : 컬럼값의 범위를 설정 -> age 컬럼값은 16~80  null 허용
ALTER TABLE TBL2# ADD age number(3) CHECK (age BETWEEN 16 AND 80);
INSERT INTO TBL2#(tno,tid,age) VALUES (222,123,20);
INSERT INTO TBL2#(tno,tid,age) VALUES (222,123,90); -- 오류 CHECK조건 위배
-- 성별 gender 컬럼 추가
ALTER TABLE "TBL2#" ADD gender char(1) CHECK (gender IN ('M','F'));
INSERT INTO TBL2#(tno,gender) VALUES (224,'F');
INSERT INTO TBL2#(tno,gender) VALUES (225,'M');
INSERT INTO TBL2#(tno,gender) VALUES (226,'m'); -- 체크 제약조건 위반

-- 성별 gender 컬럼의 제약조건 변경은 삭제(drop) 후 추가(add)해야 한다.
ALTER TABLE "TBL2#" DROP CONSTRAINTS tbl2__chk_gender;
ALTER TABLE "TBL2#" ADD CONSTRAINTS tbl2__chk_gender2
CHECK (gender IN ('M','F','m','f'));
-- 현재 gender 컬럼의 제약조건만 변경하는 경우는 다른명령어로 해야한다.
-- alter table ~ drop constraints 로 기존 제약조건을 삭제해야합니다.
INSERT INTO "TBL2#" (tno,gender) VALUES (226,'m');
INSERT INTO "TBL2#" (tno,gender) VALUES (227,'f');



