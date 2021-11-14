-- ------------------------------------------------------------------------------------
-- Database procedure
-- ------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE bds.remove_person_from_project(IN person int, IN project int) 
LANGUAGE SQL
AS $$
    DELETE FROM bds.person2project 
		WHERE id_person = person AND id_project = project;
    DELETE FROM bds.document2project d2p
        USING bds.documents d
		WHERE d.id_person = person AND id_project = project;
    INSERT INTO bds.logs (id_person, log_event, log_timestamp) VALUES (person, 'User has been removed from the project', now());
$$;
-- ------------------------------------------------------------------------------------
-- Database function
-- ------------------------------------------------------------------------------------
CREATE FUNCTION bds.check_file_extension() RETURNS trigger AS $$
    BEGIN
        IF NEW.file_type NOT IN ('pdf', 'ppt', 'jpeg') THEN
            RAISE EXCEPTION 'This file extension is not allowed!';
        END IF;
        NEW.created_at := current_timestamp;
        NEW.updated_at := current_timestamp;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql; 
-- ------------------------------------------------------------------------------------
-- Database trigger
-- ------------------------------------------------------------------------------------
CREATE TRIGGER check_file_extension
  BEFORE INSERT ON bds.document_metadata
  FOR EACH ROW EXECUTE PROCEDURE bds.check_file_extension();
-- ------------------------------------------------------------------------------------
-- Database view
-- ------------------------------------------------------------------------------------
CREATE VIEW bds.persons_view AS SELECT id_person, first_name, last_name, email, phone FROM bds.persons;
-- ------------------------------------------------------------------------------------
-- Database materialized view
-- ------------------------------------------------------------------------------------
CREATE MATERIALIZED VIEW project_vulnerabilities AS
  SELECT p.title, COUNT(v2t.id_vulnerability) FROM bds.projects p 
  JOIN bds.tasks t1 ON t1.id_project = p.id_project 
  JOIN bds.target2task t2t ON t2t.id_task = t1.id_task
  JOIN bds.targets t2 ON t2.id_target = t2t.id_target
  JOIN bds.vulnerability2target v2t ON v2t.id_target = t2.id_target
  JOIN bds.vulnerabilities v ON v.id_vulnerability = v2t.id_vulnerability
  JOIN bds.categories c ON c.id_category = t2.id_category
  WHERE v.cve IS NOT NULL
  GROUP BY p.id_project
  HAVING COUNT(t1.id_task) > 5;
-- ------------------------------------------------------------------------------------
-- Roles and privileges
-- ------------------------------------------------------------------------------------
CREATE ROLE teacher NOSUPERUSER LOGIN ENCRYPTED PASSWORD 'P0KgQv3cg*!7Pw2@9$2d';
GRANT ALL ON bds.projects TO teacher;
GRANT ALL ON bds.documents TO teacher;
GRANT SELECT ON bds.persons_view TO teacher;
CREATE ROLE student NOSUPERUSER LOGIN ENCRYPTED PASSWORD 'o5tqOuATEV5H@GH9&GSx';
GRANT SELECT ON bds.projects TO student;
GRANT SELECT ON bds.documents TO student;