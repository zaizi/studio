-- CSTUDIO_ACTIVITY
CREATE TABLE CSTUDIO_ACTIVITY
(
  ID NUMBER(19, 0) NOT NULL
, MODIFIED_DATE DATE NOT NULL
, CREATION_DATE DATE NOT NULL
, SUMMARY CLOB NOT NULL
, SUMMARY_FORMAT NVARCHAR2(255) NOT NULL
, CONTENT_ID NVARCHAR2(2000) NOT NULL
, SITE_NETWORK NVARCHAR2(255) NOT NULL
, ACTIVITY_TYPE NVARCHAR2(255) NOT NULL
, CONTENT_TYPE NVARCHAR2(255) NOT NULL
, POST_USER_ID NVARCHAR2(255) NOT NULL
, CONSTRAINT CSTUDIO_ACTIVITY_PK PRIMARY KEY
  (
    ID
  )
  ENABLE
) ;

CREATE INDEX CSTUDIO_ACTIVITY_CONTENT_IDX ON CSTUDIO_ACTIVITY (CONTENT_ID) ;

CREATE INDEX CSTUDIO_ACTIVITY_SITE_IDX ON CSTUDIO_ACTIVITY (SITE_NETWORK) ;

CREATE INDEX CSTUDIO_ACTIVITY_USER_IDX ON CSTUDIO_ACTIVITY (POST_USER_ID) ;

CREATE SEQUENCE CSTUDIO_ACTIVITY_SEQUENCE INCREMENT BY 1 START WITH 1 ;

CREATE OR REPLACE TRIGGER CSTDUIO_ACTIVITY_TRIGGER
BEFORE INSERT ON CSTUDIO_ACTIVITY
FOR EACH ROW
  BEGIN
    IF INSERTING THEN
      IF :NEW.ID IS NULL THEN
        SELECT CSTUDIO_ACTIVITY_SEQUENCE.NEXTVAL INTO :NEW.ID FROM DUAL;
      END IF;
    END IF;
  END; ;


-- CSTUDIO_DEPENDENCY
CREATE TABLE CSTUDIO_DEPENDENCY
(	ID NUMBER(19,0) NOT NULL ,
   SITE NVARCHAR2(35) NOT NULL ,
   SOURCE_PATH NVARCHAR2(2000) NOT NULL ,
   TARGET_PATH NVARCHAR2(2000) NOT NULL ,
   TYPE NVARCHAR2(20) NOT NULL,
  CONSTRAINT CSTUDIO_DEPENDENCY_PK PRIMARY KEY
    (
      ID
    )
  ENABLE
) ;

CREATE INDEX CS_DEP_SOURCEPATH_IDX ON CSTUDIO_DEPENDENCY (SOURCE_PATH) ;

CREATE INDEX CSTUDIO_DEPENDENCY_SITE_IDX ON CSTUDIO_DEPENDENCY (SITE) ;

CREATE SEQUENCE CSTUDIO_DEPENDENCY_SEQUENCE INCREMENT BY 1 START WITH 1 ;

CREATE OR REPLACE TRIGGER CSTUDIO_DEPENDENCY_TRIGGER
BEFORE INSERT ON CSTUDIO_DEPENDENCY
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    IF :NEW.ID IS NULL THEN
      SELECT CSTUDIO_DEPENDENCY_SEQUENCE.NEXTVAL INTO :NEW.ID FROM DUAL;
    END IF;
  END IF;
END; ;


-- CSTUDIO_OBJECTSTATE
CREATE TABLE CSTUDIO_OBJECTSTATE
(
    OBJECT_ID NVARCHAR2(255) NOT NULL
  , SITE NVARCHAR2(50) NOT NULL
  , PATH NVARCHAR2(2000) NOT NULL
  , STATE NVARCHAR2(255) NOT NULL
  , SYSTEM_PROCESSING NUMBER(1) DEFAULT 0 NOT NULL
  , CONSTRAINT CSTUDIO_OBJECTSTATE_PK PRIMARY KEY
  (
    OBJECT_ID
  )
ENABLE
) ;

CREATE INDEX CSTUDIO_OBJECTSTATE_PATH_IDX ON CSTUDIO_OBJECTSTATE (PATH) ;

CREATE INDEX CSTUDIO_OBJECTSTATE_SITE_IDX ON CSTUDIO_OBJECTSTATE (SITE) ;

ALTER TABLE CSTUDIO_OBJECTSTATE
ADD CONSTRAINT UQ_OS_SITE_PATH UNIQUE
  (
    SITE
    , PATH
  )
ENABLE ;


-- CSTUDIO_PAGENAVORDERSEQUENCE
CREATE TABLE CSTUDIO_PAGENAVORDERSEQUENCE
(
    FOLDER_ID NVARCHAR2(100) NOT NULL
  , SITE NVARCHAR2(50) NOT NULL
  , PATH NVARCHAR2(255) NOT NULL
  , MAX_COUNT FLOAT NOT NULL
  , CONSTRAINT CSTUDIO_PAGENAVORDERSEQUEN_PK PRIMARY KEY
  (
    FOLDER_ID
  )
ENABLE
) ;

-- CSTUDIO_COPYTOENVIRONMENT
CREATE TABLE CSTUDIO_COPYTOENVIRONMENT
(
    ID NUMBER(19, 0) NOT NULL
  , SITE NVARCHAR2(50) NOT NULL
  , ENVIRONMENT NVARCHAR2(20) NOT NULL
  , PATH NVARCHAR2(200) NOT NULL
  , OLDPATH CLOB
  , USERNAME NVARCHAR2(255)
  , SCHEDULEDDATE DATE NOT NULL
  , STATE NVARCHAR2(50) NOT NULL
  , ACTION NVARCHAR2(20) NOT NULL
  , CONTENTTYPECLASS NVARCHAR2(20)
  , SUBMISSIONCOMMENT CLOB
  , CONSTRAINT CSTUDIO_COPYTOENVIRONMENT_PK PRIMARY KEY
  (
    ID
  )
ENABLE
) ;

CREATE INDEX CSTUDIO_CTE_ENVIRONMENT_IDX ON CSTUDIO_COPYTOENVIRONMENT (ENVIRONMENT) ;

CREATE INDEX CSTUDIO_CTE_PATH_IDX ON CSTUDIO_COPYTOENVIRONMENT (PATH) ;

CREATE INDEX CSTUDIO_CTE_SITEPATH_IDX ON CSTUDIO_COPYTOENVIRONMENT (SITE, PATH) ;

CREATE INDEX CSTUDIO_CTE_SITE_IDX ON CSTUDIO_COPYTOENVIRONMENT (SITE) ;

CREATE INDEX CSTUDIO_CTE_STATE_IDX ON CSTUDIO_COPYTOENVIRONMENT (STATE) ;

CREATE SEQUENCE  CSTUDIO_COPYTOENVIRONMENT_SEQ INCREMENT BY 1 START WITH 1 ;

CREATE OR REPLACE TRIGGER CS_COPYTOENV_TRIGGER
BEFORE INSERT ON CSTUDIO_COPYTOENVIRONMENT
FOR EACH ROW
  BEGIN
    IF INSERTING THEN
      IF :NEW.ID IS NULL THEN
        SELECT CSTUDIO_COPYTOENVIRONMENT_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
      END IF;
    END IF;
  END; ;


  -- CSTUDIO_PUBLISHTOTARGET
CREATE TABLE CSTUDIO_PUBLISHTOTARGET
(
    ID NUMBER(19, 0) NOT NULL
  , SITE NVARCHAR2(50) NOT NULL
  , ENVIRONMENT NVARCHAR2(20) NOT NULL
  , PATH NVARCHAR2(2000) NOT NULL
  , OLDPATH CLOB
  , USERNAME NVARCHAR2(255) NOT NULL
  , VERSION NUMBER(19, 0) NOT NULL
  , ACTION NVARCHAR2(20) NOT NULL
  , CONTENTTYPECLASS NVARCHAR2(20)
  , CONSTRAINT CSTUDIO_PUBLISHTOTARGET_PK PRIMARY KEY
  (
    ID
  )
ENABLE
) ;

CREATE INDEX CSTUDIO_PTT_ENVIRONMENT_IDX ON CSTUDIO_PUBLISHTOTARGET (ENVIRONMENT) ;

CREATE INDEX CSTUDIO_PTT_PATH_IDX ON CSTUDIO_PUBLISHTOTARGET (PATH) ;

CREATE INDEX CSTUDIO_PTT_SITEPATH_IDX ON CSTUDIO_PUBLISHTOTARGET (SITE, PATH) ;

CREATE INDEX CSTUDIO_PTT_SITE_IDX ON CSTUDIO_PUBLISHTOTARGET (SITE) ;

CREATE SEQUENCE CSTUDIO_PUBLISHTOTARGET_SEQ INCREMENT BY 1 START WITH 1 ;

CREATE OR REPLACE TRIGGER CS_PUBTOTARGET_TRIGGER
BEFORE INSERT ON CSTUDIO_PUBLISHTOTARGET
FOR EACH ROW
  BEGIN
    IF INSERTING THEN
      IF :NEW.ID IS NULL THEN
        SELECT CSTUDIO_PUBLISHTOTARGET_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
      END IF;
    END IF;
  END; ;


-- CSTUDIO_DEPLOYMENTSYNCHISTORY
CREATE TABLE CSTUDIO_DEPLOYMENTSYNCHISTORY
(
    ID NUMBER(19, 0) NOT NULL
  , SYNCDATE DATE NOT NULL
  , SITE NVARCHAR2(50) NOT NULL
  , ENVIRONMENT NVARCHAR2(20) NOT NULL
  , PATH NVARCHAR2(2000) NOT NULL
  , TARGET NVARCHAR2(50) NOT NULL
  , USERNAME NVARCHAR2(255) NOT NULL
  , CONTENTTYPECLASS NVARCHAR2(20)
  , CONSTRAINT CSTUDIO_DEPLOYMENTSYNCHIST_PK PRIMARY KEY
  (
    ID
  )
ENABLE
) ;

CREATE INDEX CS_DEPSYNCHIST_CTC_IDX ON CSTUDIO_DEPLOYMENTSYNCHISTORY (CONTENTTYPECLASS) ;

CREATE INDEX CS_DEPSYNCHIST_ENV_IDX ON CSTUDIO_DEPLOYMENTSYNCHISTORY (ENVIRONMENT) ;

CREATE INDEX CS_DEPSYNCHIST_PATH_IDX ON CSTUDIO_DEPLOYMENTSYNCHISTORY (PATH) ;

CREATE INDEX CS_DEPSYNCHIST_SITEPATH_IDX ON CSTUDIO_DEPLOYMENTSYNCHISTORY (SITE, PATH) ;

CREATE INDEX CS_DEPSYNCHIST_SITE_IDX ON CSTUDIO_DEPLOYMENTSYNCHISTORY (SITE) ;

CREATE INDEX CS_DEPSYNCHIST_TARGET_IDX ON CSTUDIO_DEPLOYMENTSYNCHISTORY (TARGET) ;

CREATE INDEX CS_DEPSYNCHIST_USER_IDX ON CSTUDIO_DEPLOYMENTSYNCHISTORY (USERNAME) ;

CREATE SEQUENCE CSTUDIO_DEPSYNCHISTORY_SEQ INCREMENT BY 1 START WITH 1 ;

CREATE OR REPLACE TRIGGER CS_DEPSYNCHISTORY_TRIGGER
BEFORE INSERT ON CSTUDIO_DEPLOYMENTSYNCHISTORY
FOR EACH ROW
  BEGIN
    IF INSERTING THEN
      IF :NEW.ID IS NULL THEN
        SELECT CSTUDIO_DEPSYNCHISTORY_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
      END IF;
    END IF;
  END; ;


-- CSTUDIO_SITE
CREATE TABLE CSTUDIO_SITE
(
    ID NUMBER(19, 0) NOT NULL
  , SITE_ID NVARCHAR2(255) NOT NULL
  , NAME NVARCHAR2(255) NOT NULL
  , DESCRIPTION CLOB
  , STATUS NVARCHAR2(255)
  , CONSTRAINT CSTUDIO_SITE_PK PRIMARY KEY
  (
    ID
  )
ENABLE
) ;

ALTER TABLE CSTUDIO_SITE
ADD CONSTRAINT CSTUDIO_SITE_UK2 UNIQUE
  (
    SITE_ID
  )
  USING INDEX
    (
    CREATE UNIQUE INDEX CSTUDIO_SITE_SITEID_UNIQUE ON CSTUDIO_SITE (SITE_ID ASC)
    )
ENABLE ;

CREATE SEQUENCE CSTUDIO_SITE_SEQUENCE INCREMENT BY 1 START WITH 1 ;

CREATE OR REPLACE TRIGGER CSTUDIO_SITE_TRIGGER
BEFORE INSERT ON CSTUDIO_SITE
FOR EACH ROW
  BEGIN
    IF INSERTING THEN
      IF :NEW.ID IS NULL THEN
        SELECT CSTUDIO_SITE_SEQUENCE.NEXTVAL INTO :NEW.ID FROM DUAL;
      END IF;
    END IF;
  END; ;


-- CSTUDIO_OBJECTMETADATA
CREATE TABLE CSTUDIO_OBJECTMETADATA
(
    ID NUMBER(19) NOT NULL
  , SITE NVARCHAR2(50) NOT NULL
  , PATH NVARCHAR2(2000) NOT NULL
  , NAME NVARCHAR2(255)
  , MODIFIED DATE
  , MODIFIER NVARCHAR2(255)
  , OWNER NVARCHAR2(255)
  , CREATOR NVARCHAR2(255)
  , FIRSTNAME NVARCHAR2(255)
  , LASTNAME NVARCHAR2(255)
  , LOCKOWNER NVARCHAR2(255)
  , EMAIL NVARCHAR2(255)
  , RENAMED NUMBER(1)
  , OLDURL CLOB
  , DELETEURL CLOB
  , IMAGEWIDTH INT
  , IMAGEHEIGHT INT
  , APPROVEDBY NVARCHAR2(255)
  , SUBMITTEDBY NVARCHAR2(255)
  , SUBMITTEDFORDELETION NUMBER(1)
  , SENDEMAIL NUMBER(1)
  , SUBMISSIONCOMMENT CLOB
  , LAUNCHDATE DATE
  , CONSTRAINT CSTUDIO_OBJECTMETADA_PK PRIMARY KEY
  (
    ID
  )
ENABLE
) ;

CREATE INDEX CSTUDIO_OBJECTMETADA_PATH_IDX ON CSTUDIO_OBJECTMETADA (PATH) ;

CREATE INDEX CSTUDIO_OBJECTMETADA_SITE_IDX ON CSTUDIO_OBJECTMETADA (SITE) ;

ALTER TABLE CSTUDIO_OBJECTMETADA
ADD CONSTRAINT CSTUDIO_OBJECTMETADA_UK1 UNIQUE
  (
    SITE
    , PATH
  )
ENABLE ;

CREATE SEQUENCE CSTUDIO_OBJECTMETADATA_SEQ INCREMENT BY 1 START WITH 1 ;

CREATE OR REPLACE TRIGGER CSTUDIO_OBJECTMETADA_TRIGGER
BEFORE INSERT ON CSTUDIO_OBJECTMETADATA
FOR EACH ROW
  BEGIN
    IF INSERTING THEN
      IF :NEW.ID IS NULL THEN
        SELECT CSTUDIO_OBJECTMETADATA_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
      END IF;
    END IF;
  END; ;
