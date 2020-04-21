/* first drop test tables from previous session so we have a clean database */
/* DROP SCHEMA public cascade; http://stackoverflow.com/a/13823560/1148249 */
/* CREATE SCHEMA IF NOT EXISTS public; */

DROP DATABASE IF EXISTS people;
DROP DATABASE IF EXISTS "Patient";

/* CREATE DATABASE test; */
/* create the people table */
CREATE TABLE IF NOT EXISTS "Patient" (
  patient_id SERIAL PRIMARY KEY,
  patient_id, patient_email VARCHAR(254) UNIQUE NOT NULL,
  patient_name VARCHAR(100) DEFAULT NULL,
  patient_password VARCHAR(60) NOT NULL,
  patient_phone VARCHAR(15) NOT NULL,
  patient_sex VARCHAR(10) NOT NULL
);

/* insert a person into the people table if it does not already exist */
/* http://stackoverflow.com/questions/4069718/postgres-insert-if-does-not-exist-already */
INSERT INTO "Patient" (patient_id, patient_email, patient_name, patient_password, patient_phone, patient_sex)
  SELECT patient_id, patient_email, patient_name, patient_password, patient_phone, patient_sex FROM "Patient"
  UNION
  VALUES (
    123450987,
    'test@test.net',
    'Jimmy Tester',
    '$2a$12$OgPE9DUNM0KaSodSQVJvw.36GjolssAeO.dfi7a9cmc9KbQTDTj7W',
    '(+52)5511004433',
    'unknown'
  )
  EXCEPT
  SELECT patient_id, patient_email, patient_name, patient_password, patient_phone, patient_sex FROM "Patient";

/* sessions */
CREATE TABLE IF NOT EXISTS sessions (
  session_id VARCHAR(36),
  patient_id INTEGER NOT NULL REFERENCES "Patient" (patient_id),
  start_timestamp INTEGER DEFAULT EXTRACT(EPOCH FROM CURRENT_TIMESTAMP),
  end_timestamp INTEGER DEFAULT null
);

INSERT INTO sessions (session_id, person_id)
VALUES (
  '525be54a-1101-46bf-97d7-2e9c89dd1b16',
  '1'
);