/* DIAGRAMS table*/
CREATE TABLE  "DIAGRAMS" 
   (	"DGM_NAME" VARCHAR2(150), 
	"DGM_CONTENT" CLOB, 
	 CONSTRAINT "DGM_UK" UNIQUE ("DGM_NAME")
  USING INDEX  ENABLE
   )
/


/* OBJECTS table*/
CREATE TABLE  "OBJECTS" 
   (	"OBJ_ID" VARCHAR2(50), 
	"OBJ_NAME" VARCHAR2(200), 
	"OBJ_DGM_NAME" VARCHAR2(150), 
	 CONSTRAINT "OBJ_PK" PRIMARY KEY ("OBJ_DGM_NAME", "OBJ_ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "OBJECTS" ADD CONSTRAINT "OBJ_DGM_FK" FOREIGN KEY ("OBJ_DGM_NAME")
	  REFERENCES  "DIAGRAMS" ("DGM_NAME") ON DELETE CASCADE ENABLE
/


/*CONNECTIONS table*/
CREATE TABLE  "CONNECTIONS" 
   (	"CON_ID" VARCHAR2(50), 
	"CON_NAME" VARCHAR2(100), 
	"CON_SOURCE_REF" VARCHAR2(50), 
	"CON_TARGET_REF" VARCHAR2(50), 
	"CON_DGM_NAME" VARCHAR2(150), 
	 CONSTRAINT "CON_PK" PRIMARY KEY ("CON_ID")
  USING INDEX  ENABLE
   )
/

/*PROCESSES table*/
CREATE TABLE  "PROCESSES" 
   (	"PRC_ID" NUMBER GENERATED ALWAYS AS IDENTITY, 
	"PRC_NAME" VARCHAR2(150), 
	"PRC_DGM_NAME" VARCHAR2(150), 
	"PRC_CURRENT" VARCHAR2(50), 
	"PRC_INIT_DATE" DATE, 
	"PRC_LAST_UPDATE" DATE, 
	 CONSTRAINT "PROCESSES_PK" PRIMARY KEY ("PRC_ID")
  USING INDEX  ENABLE
   )
/

ALTER TABLE  "CONNECTIONS" ADD CONSTRAINT "CON_OBJ_FK" FOREIGN KEY ("CON_DGM_NAME", "CON_SOURCE_REF")
	  REFERENCES  "OBJECTS" ("OBJ_DGM_NAME", "OBJ_ID") ENABLE
/
ALTER TABLE  "CONNECTIONS" ADD CONSTRAINT "CON_OBJ_FK2" FOREIGN KEY ("CON_DGM_NAME", "CON_TARGET_REF")
	  REFERENCES  "OBJECTS" ("OBJ_DGM_NAME", "OBJ_ID") ENABLE
/
ALTER TABLE  "CONNECTIONS" ADD CONSTRAINT "CON_DGM_FK" FOREIGN KEY ("CON_DGM_NAME")
	  REFERENCES  "DIAGRAMS" ("DGM_NAME") ON DELETE CASCADE ENABLE
/

ALTER TABLE  "PROCESSES" ADD CONSTRAINT "PRC_DGM_FK" FOREIGN KEY ("PRC_DGM_NAME")
	  REFERENCES  "DIAGRAMS" ("DGM_NAME") ON DELETE CASCADE ENABLE
/

ALTER TABLE  "PROCESSES" ADD CONSTRAINT "PRC_OBJ_FK" FOREIGN KEY ("PRC_DGM_NAME", "PRC_CURRENT")
	  REFERENCES  "OBJECTS" ("OBJ_DGM_NAME", "OBJ_ID") DISABLE
/