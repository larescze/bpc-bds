CREATE DATABASE db-pentesting OWNER postgres;

CREATE SCHEMA bds
    AUTHORIZATION postgres;

COMMENT ON SCHEMA bds
    IS 'pentesting schema';

GRANT ALL ON SCHEMA bds TO postgres;

CREATE ROLE xlazar15 NOSUPERUSER LOGIN ENCRYPTED PASSWORD 'P0KgQv3cg*!7Pw2@9$2d';
GRANT ALL ON bds.projects TO xlazar15;
GRANT ALL ON bds.documents TO xlazar15;
GRANT SELECT ON bds.persons_view TO xlazar15;