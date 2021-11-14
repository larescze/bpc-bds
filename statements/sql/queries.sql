-- ------------------------------------------------------------------------------------
-- Query – retrieve only selected columns from the selected table
-- ------------------------------------------------------------------------------------
SELECT first_name, last_name, email FROM bds.persons;
-- ------------------------------------------------------------------------------------
-- Query – select person based on the email
-- ------------------------------------------------------------------------------------
SELECT first_name, last_name, email, phone FROM bds.persons WHERE email = 'bsavinec@techcrunch.com';
-- ------------------------------------------------------------------------------------
-- Query – UPDATE, INSERT, DELETE, and ALTER TABLE
-- ------------------------------------------------------------------------------------
UPDATE bds.projects SET description = 'Pentesting website vut.cz' WHERE slug = 'but';
INSERT INTO bds.vulnerabilities (slug, title, cve, description, created_at, updated_at) VALUES ('jetbrains-hub','JetBrains Hub XSS','CVE-2021-43181', 'In JetBrains Hub before 2021.1.13690, stored XSS is possible.', now(), now());
DELETE FROM bds.projects WHERE slug = 'muni';
ALTER TABLE bds.checklists ALTER description TYPE character varying(12000);
-- ------------------------------------------------------------------------------------
--  Query – WHERE
-- ------------------------------------------------------------------------------------
SELECT title FROM bds.categories 
  WHERE slug = 'apache';
-- ------------------------------------------------------------------------------------
--  Query – LIKE
-- ------------------------------------------------------------------------------------  
SELECT first_name, last_name, email FROM bds.persons 
  WHERE email LIKE 'c%';
-- ------------------------------------------------------------------------------------
--  Query – NOT LIKE
-- ------------------------------------------------------------------------------------    
SELECT title, description FROM bds.checklists 
  WHERE title NOT LIKE '%AVSS%';
-- ------------------------------------------------------------------------------------
--  Query – SUBSTRING
-- ------------------------------------------------------------------------------------
SELECT CONCAT(SUBSTRING(first_name, 1, 1), '.', SUBSTRING(last_name, 1, 1), '.') AS initials FROM bds.persons;
-- ------------------------------------------------------------------------------------
--  Query – TRIM
-- ------------------------------------------------------------------------------------
SELECT TRIM(title) AS title_trim FROM bds.checklists;
-- ------------------------------------------------------------------------------------
--  Query – COUNT
-- ------------------------------------------------------------------------------------
SELECT COUNT(id_project) AS total_projects FROM bds.projects;
-- ------------------------------------------------------------------------------------
--  Query – SUM
-- ------------------------------------------------------------------------------------
SELECT SUM(file_size) AS total_files_size FROM bds.document_metadata;
-- ------------------------------------------------------------------------------------
--  Query – MIN
-- ------------------------------------------------------------------------------------
SELECT MIN(file_size) AS smallest_file FROM bds.document_metadata;
-- ------------------------------------------------------------------------------------
--  Query – MAX
-- ------------------------------------------------------------------------------------
SELECT MAX(file_size) AS biggest_file FROM bds.document_metadata;
-- ------------------------------------------------------------------------------------
--  Query – AVG
-- ------------------------------------------------------------------------------------
SELECT AVG(file_size)::numeric(10,2) AS average_file_size FROM bds.document_metadata;
-- ------------------------------------------------------------------------------------
--  Query – GROUP BY
-- ------------------------------------------------------------------------------------
SELECT COUNT(id_target)::numeric(10,2) AS targets_per_category FROM bds.targets 
  GROUP BY id_category;
-- ------------------------------------------------------------------------------------
--  Query – GROUP BY and HAVING; GROUP BY, HAVING, and WHERE
-- ------------------------------------------------------------------------------------
SELECT id_person, COUNT(id_log) AS logs_per_person FROM bds.logs 
  GROUP BY id_person 
  HAVING COUNT(id_log) > 5;
-- ------------------------------------------------------------------------------------
--  Query – GROUP BY, HAVING, and WHERE
-- ------------------------------------------------------------------------------------
SELECT id_category, AVG(id_category)::numeric(10,2) AS target_category_average FROM bds.targets 
  WHERE address LIKE '%.com' 
  GROUP BY id_category 
  HAVING COUNT(id_target) > 5;
-- ------------------------------------------------------------------------------------
--  Query – UNION
-- ------------------------------------------------------------------------------------
SELECT p1.title, p1.start_date, p1.end_date 
  FROM bds.projects p1 
  WHERE p1.start_date < '2021-08-20 12:00:00' 
UNION 
  SELECT p2.title, p2.start_date, p2.end_date 
  FROM bds.projects p2 
  WHERE p2.start_date > '2021-09-20 12:00:00';
-- ------------------------------------------------------------------------------------
--  Query – DISTINCT
-- ------------------------------------------------------------------------------------
SELECT DISTINCT file_type FROM bds.document_metadata;
-- ------------------------------------------------------------------------------------
--  Query – GROUP BY; GROUP BY and HAVING; GROUP BY, HAVING, and WHERE
-- ------------------------------------------------------------------------------------
SELECT t.title, t.address, v2t.description FROM bds.targets t 
  LEFT JOIN bds.vulnerability2target v2t ON v2t.id_target = t.id_target;
-- ------------------------------------------------------------------------------------
--  Query – UNION
-- ------------------------------------------------------------------------------------
SELECT r.title AS role_title, rt.title AS role_type_title FROM bds.roles r 
  RIGHT JOIN bds.role_types rt ON rt.id_role_type = r.id_role_type;
-- ------------------------------------------------------------------------------------
--  Query – DISTINCT
-- ------------------------------------------------------------------------------------
SELECT p.title AS project_title, t.title AS task_title, t.description AS task_description FROM bds.projects p 
  FULL OUTER JOIN bds.tasks t ON t.id_project = p.id_project;
-- ------------------------------------------------------------------------------------
--  Query – LEFT JOIN; RIGHT JOIN; FULL OUTER JOIN
-- ------------------------------------------------------------------------------------
SELECT DISTINCT p.title, AVG(dm.file_size) AS average_project_files_size FROM bds.projects p 
  LEFT JOIN bds.document2project d2p ON d2p.id_project = p.id_project 
  JOIN bds.documents d ON d.id_document = d2p.id_document
  JOIN bds.document_metadata dm ON dm.id_document = d.id_document
  GROUP BY p.id_project 
  HAVING p.start_date > '2021-05-20 12:00:00'
  ORDER BY p.title DESC;
-- ------------------------------------------------------------------------------------
--  Query – select data from an arbitrary table for the last one and half days
-- ------------------------------------------------------------------------------------    
SELECT log_event FROM bds.logs
  WHERE log_timestamp > current_timestamp - interval '1 day' + '12 hours';
-- ------------------------------------------------------------------------------------
--  Query – select data from the last month
-- ------------------------------------------------------------------------------------    
SELECT log_event FROM bds.logs
  WHERE log_timestamp >= date_trunc('month', current_date - interval '1' month) AND log_timestamp < date_trunc('month', current_date);
-- ------------------------------------------------------------------------------------
--  Query – remove accents on a selected string
-- ------------------------------------------------------------------------------------
CREATE EXTENSION unaccent;
SELECT unaccent(first_name) AS first_name, unaccent(last_name) AS last_name FROM bds.persons;
-- ------------------------------------------------------------------------------------
--  Query – LIMIT and OFFSET
-- ------------------------------------------------------------------------------------
SELECT first_name, last_name, email FROM bds.persons LIMIT 5 OFFSET 2;
-- ------------------------------------------------------------------------------------
--  Query – subquery in FROM
-- ------------------------------------------------------------------------------------
SELECT id_role_type, total_roles FROM (SELECT id_role_type, COUNT(id_role_type) AS total_roles FROM bds.roles 
  GROUP BY id_role_type) AS roles;
-- ------------------------------------------------------------------------------------
--  Query – subquery in WHERE condition
-- ------------------------------------------------------------------------------------
SELECT p.first_name, p.last_name, p.email FROM bds.persons p 
  WHERE 2 = (SELECT count(id_person) FROM bds.person2project b2p WHERE b2p.id_person = p.id_person);
-- ------------------------------------------------------------------------------------
--  Query – aggregate function and GROUP BY with HAVING
-- ------------------------------------------------------------------------------------
SELECT t.title, t.address, COUNT(v2t.id_target) as total_vulnerabilites FROM bds.targets t 
  JOIN bds.vulnerability2target v2t ON v2t.id_target = t.id_target 
  GROUP BY t.id_target 
  HAVING COUNT(v2t.id_target) > 1;
-- ------------------------------------------------------------------------------------
-- Query – join 5 tables
-- ------------------------------------------------------------------------------------
SELECT p.title AS project_title, v.title AS vulnerablity_title, v.cve, v.description FROM bds.projects p 
  JOIN bds.tasks t1 ON t1.id_project = p.id_project 
  JOIN bds.target2task t2t ON t2t.id_task = t1.id_task
  JOIN bds.targets t2 ON t2.id_target = t2t.id_target
  JOIN bds.vulnerability2target v2t ON v2t.id_target = t2.id_target
  JOIN bds.vulnerabilities v ON v.id_vulnerability = v2t.id_vulnerability;
-- ------------------------------------------------------------------------------------
--  Query – join 4 tables and use GROUP BY, HAVING, and WHERE
-- ------------------------------------------------------------------------------------
SELECT c.title, COUNT(t2.id_target) FROM bds.projects p
  JOIN bds.tasks t1 ON t1.id_project = p.id_project 
  JOIN bds.target2task t2t ON t2t.id_task = t1.id_task
  JOIN bds.targets t2 ON t2.id_target = t2t.id_target
  JOIN bds.categories c ON c.id_category = t2.id_category
  WHERE p.slug = 'but'
  GROUP BY c.id_category
  HAVING COUNT(t2.id_target) > 1;