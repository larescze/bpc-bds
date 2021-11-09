CREATE DATABASE db-pentesting OWNER postgres;

CREATE SCHEMA bds
    AUTHORIZATION postgres;

COMMENT ON SCHEMA bds
    IS 'pentesting schema';

GRANT ALL ON SCHEMA bds TO postgres;