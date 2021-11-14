-- -----------------------------------------------------
-- Table bds.persons
-- -----------------------------------------------------
CREATE TABLE bds.persons (
  id_person bigserial NOT NULL,
  email character varying(100) NOT NULL,
  first_name character varying(45) NOT NULL,
  last_name character varying(45) NOT NULL,
  pwd character varying(255) NOT NULL,
  avatar character varying(255),
  phone character varying(45),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.persons OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.role_types
-- -----------------------------------------------------
CREATE TABLE bds.role_types (
  id_role_type bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.role_types OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.roles
-- -----------------------------------------------------
CREATE TABLE bds.roles (
  id_role bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  id_role_type bigint NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.roles OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.person2role
-- -----------------------------------------------------
CREATE TABLE bds.person2role (
  id_person bigserial NOT NULL,
  id_role bigint NOT NULL
);
ALTER TABLE bds.person2role OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.permissions
-- -----------------------------------------------------
CREATE TABLE bds.permissions (
  id_permission bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.permissions OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.role2permission
-- -----------------------------------------------------
CREATE TABLE bds.role2permission (
  id_role bigint NOT NULL,
  id_permission bigint NOT NULL
);
ALTER TABLE bds.role2permission OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.projects
-- -----------------------------------------------------
CREATE TABLE bds.projects (
  id_project bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  description character varying(10000),
  start_date date NOT NULL,
  end_date date NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.projects OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.tasks
-- -----------------------------------------------------
CREATE TABLE bds.tasks (
  id_task bigserial NOT NULL,
  id_project bigint NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  description character varying(10000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.tasks OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.documents
-- -----------------------------------------------------
CREATE TABLE bds.documents (
  id_document bigserial NOT NULL,
  id_person bigint NOT NULL,
  document_name character varying(100) NOT NULL,
  document_path character varying(255) NOT NULL
);
ALTER TABLE bds.documents OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.document2project
-- -----------------------------------------------------
CREATE TABLE bds.document2project (
  id_document bigint NOT NULL,
  id_project bigint NOT NULL
);
ALTER TABLE bds.document2project OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.person2project
-- -----------------------------------------------------
CREATE TABLE bds.person2project (
  id_person2project bigserial NOT NULL,
  id_person bigint NOT NULL,
  id_project bigint NOT NULL,
  id_role bigint NOT NULL,
  invited_at timestamp without time zone NOT NULL,
  joined_at timestamp without time zone
);
ALTER TABLE bds.person2project OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.categories
-- -----------------------------------------------------
CREATE TABLE bds.categories (
  id_category bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.categories OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.checklists
-- -----------------------------------------------------
CREATE TABLE bds.checklists (
  id_checklist bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  description character varying(10000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.checklists OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.checklist2category
-- -----------------------------------------------------
CREATE TABLE bds.checklist2category (
  id_checklist bigint NOT NULL,
  id_category bigint NOT NULL
);
ALTER TABLE bds.checklist2category OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.vulnerabilities
-- -----------------------------------------------------
CREATE TABLE bds.vulnerabilities (
  id_vulnerability bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  cve character varying(100) NULL,
  description character varying(100000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.vulnerabilities OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.targets
-- -----------------------------------------------------
CREATE TABLE bds.targets (
  id_target bigserial NOT NULL,
  id_category bigint NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
    ADDress character varying(512) NULL,
  description character varying(100000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.targets OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.vulnerability2target
-- -----------------------------------------------------
CREATE TABLE bds.vulnerability2target (
  id_vulnerability bigint NOT NULL,
  id_target bigint NOT NULL,
  description character varying(100000)
);
ALTER TABLE bds.vulnerability2target OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.person2task
-- -----------------------------------------------------
CREATE TABLE bds.person2task (
  id_person2project bigint NOT NULL,
  id_task bigint NOT NULL
);
ALTER TABLE bds.person2task OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.target2task
-- -----------------------------------------------------
CREATE TABLE bds.target2task (
  id_target bigint NOT NULL,
  id_task bigint NOT NULL
);
ALTER TABLE bds.target2task OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.document_metadata
-- -----------------------------------------------------
CREATE TABLE bds.document_metadata (
  id_document_metadata bigserial NOT NULL,
  id_document bigint NOT NULL,
  file_extension character varying(45) NOT NULL,
  file_type character varying(45) NOT NULL,
  file_size bigint NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE bds.document_metadata OWNER TO postgres;
-- -----------------------------------------------------
-- Table bds.logs
-- -----------------------------------------------------
CREATE TABLE bds.logs (
  id_log bigserial NOT NULL,
  id_person bigint NOT NULL,
  log_event character varying(255) NOT NULL,
  log_timestamp timestamp without time zone NOT NULL
);
ALTER TABLE bds.logs OWNER TO postgres;
-- -----------------------------------------------------
-- Primary keys
-- -----------------------------------------------------
ALTER TABLE bds.role_types
  ADD CONSTRAINT pk_role_types PRIMARY KEY (id_role_type);
ALTER TABLE bds.persons
  ADD CONSTRAINT pk_persons PRIMARY KEY (id_person);
ALTER TABLE bds.roles
  ADD CONSTRAINT pk_roles PRIMARY KEY (id_role);
ALTER TABLE bds.person2role
  ADD CONSTRAINT pk_person2role PRIMARY KEY (id_person, id_role);
ALTER TABLE bds.permissions
  ADD CONSTRAINT pk_permissions PRIMARY KEY (id_permission);
ALTER TABLE bds.role2permission
  ADD CONSTRAINT pk_role2permission PRIMARY KEY (id_role, id_permission);
ALTER TABLE bds.projects
  ADD CONSTRAINT pk_projects PRIMARY KEY (id_project);
ALTER TABLE bds.tasks
  ADD CONSTRAINT pk_tasks PRIMARY KEY (id_task);
ALTER TABLE bds.documents
  ADD CONSTRAINT pk_documents PRIMARY KEY (id_document);
ALTER TABLE bds.document2project
  ADD CONSTRAINT pk_document2project PRIMARY KEY (id_document, id_project);
ALTER TABLE bds.person2project
  ADD CONSTRAINT pk_person2project PRIMARY KEY (id_person2project);
ALTER TABLE bds.categories
  ADD CONSTRAINT pk_categories PRIMARY KEY (id_category);
ALTER TABLE bds.checklists
  ADD CONSTRAINT pk_checklists PRIMARY KEY (id_checklist);
ALTER TABLE bds.checklist2category
  ADD CONSTRAINT pk_checklist2category PRIMARY KEY (id_checklist, id_category);
ALTER TABLE bds.vulnerabilities
  ADD CONSTRAINT pk_vulnerabilities PRIMARY KEY (id_vulnerability);
ALTER TABLE bds.targets
  ADD CONSTRAINT pk_targets PRIMARY KEY (id_target);
ALTER TABLE bds.vulnerability2target
  ADD CONSTRAINT pk_vulnerability2target PRIMARY KEY (id_vulnerability, id_target);
ALTER TABLE bds.person2task
  ADD CONSTRAINT pk_person2task PRIMARY KEY (id_person2project, id_task);
ALTER TABLE bds.target2task
  ADD CONSTRAINT pk_target2task PRIMARY KEY (id_target, id_task);
ALTER TABLE bds.document_metadata
  ADD CONSTRAINT pk_document_metadata PRIMARY KEY (id_document_metadata);
ALTER TABLE bds.logs
  ADD CONSTRAINT pk_logs PRIMARY KEY (id_log);
-- -----------------------------------------------------
-- Unique Constraints
-- -----------------------------------------------------
ALTER TABLE bds.role_types
  ADD CONSTRAINT uc_role_types UNIQUE (slug);
ALTER TABLE bds.persons
  ADD CONSTRAINT uc_persons UNIQUE (email);
ALTER TABLE bds.roles
  ADD CONSTRAINT uc_roles UNIQUE (slug);
ALTER TABLE bds.permissions
  ADD CONSTRAINT uc_permissions UNIQUE (slug);
ALTER TABLE bds.projects
  ADD CONSTRAINT uc_projects UNIQUE (slug);
ALTER TABLE bds.tasks
  ADD CONSTRAINT uc_tasks UNIQUE (slug);
ALTER TABLE bds.documents
  ADD CONSTRAINT uc_documents UNIQUE (document_name, document_path);
ALTER TABLE bds.document_metadata
  ADD CONSTRAINT uc_document_metadata UNIQUE (id_document);  
ALTER TABLE bds.categories
  ADD CONSTRAINT uc_categories UNIQUE (slug);
ALTER TABLE bds.checklists
  ADD CONSTRAINT uc_checklists UNIQUE (slug);
ALTER TABLE bds.vulnerabilities
  ADD CONSTRAINT uc_vulnerabilities UNIQUE (slug);
ALTER TABLE bds.targets
  ADD CONSTRAINT uc_targets UNIQUE (slug);
-- -----------------------------------------------------
-- Unique Indexes
-- -----------------------------------------------------
CREATE UNIQUE INDEX idx_role_types_title ON bds.role_types(title);
CREATE UNIQUE INDEX idx_persons_email ON bds.persons(email);
CREATE UNIQUE INDEX idx_roles_title ON bds.roles(title);
CREATE UNIQUE INDEX idx_permissions_title ON bds.permissions(title);
CREATE UNIQUE INDEX idx_projects_title ON bds.projects(title);
CREATE UNIQUE INDEX idx_tasks_title ON bds.tasks(title);
CREATE UNIQUE INDEX idx_categories_title ON bds.categories(title);
CREATE UNIQUE INDEX idx_checlists_title ON bds.checklists(title);
CREATE UNIQUE INDEX idx_vulnerabilities_title ON bds.vulnerabilities(title);
CREATE UNIQUE INDEX idx_targets_title ON bds.targets(title);
-- -----------------------------------------------------
-- Foreign keys
-- -----------------------------------------------------
ALTER TABLE bds.roles
  ADD CONSTRAINT fk_roles FOREIGN KEY (id_role_type) REFERENCES bds.role_types(id_role_type) ON DELETE SET NULL;
ALTER TABLE bds.person2role
  ADD CONSTRAINT fk_person2role1 FOREIGN KEY (id_person) REFERENCES bds.persons(id_person) ON DELETE CASCADE;
ALTER TABLE bds.person2role
  ADD CONSTRAINT fk_person2role2 FOREIGN KEY (id_role) REFERENCES bds.roles(id_role) ON DELETE CASCADE;
ALTER TABLE bds.role2permission
  ADD CONSTRAINT fk_role2permission1 FOREIGN KEY (id_role) REFERENCES bds.roles(id_role) ON DELETE CASCADE;
ALTER TABLE bds.role2permission
  ADD CONSTRAINT fk_role2permission2 FOREIGN KEY (id_permission) REFERENCES bds.permissions(id_permission) ON DELETE CASCADE;
ALTER TABLE bds.tasks
  ADD CONSTRAINT fk_tasks_projects FOREIGN KEY (id_project) REFERENCES bds.projects(id_project) ON DELETE CASCADE;
ALTER TABLE bds.documents
  ADD CONSTRAINT fk_documents FOREIGN KEY (id_person) REFERENCES bds.persons(id_person) ON DELETE CASCADE;
ALTER TABLE bds.document2project
  ADD CONSTRAINT fk_document2project FOREIGN KEY (id_project) REFERENCES bds.projects(id_project) ON DELETE CASCADE;
ALTER TABLE bds.person2project
  ADD CONSTRAINT fk_person2project1 FOREIGN KEY (id_person) REFERENCES bds.persons(id_person) ON DELETE CASCADE;
ALTER TABLE bds.person2project
  ADD CONSTRAINT fk_person2project2 FOREIGN KEY (id_project) REFERENCES bds.projects(id_project) ON DELETE CASCADE;
ALTER TABLE bds.person2project
  ADD CONSTRAINT fk_person2project3 FOREIGN KEY (id_role) REFERENCES bds.roles(id_role) ON DELETE SET NULL;
ALTER TABLE bds.checklist2category
  ADD CONSTRAINT fk_checklist2category1 FOREIGN KEY (id_checklist) REFERENCES bds.checklists(id_checklist) ON DELETE CASCADE;
ALTER TABLE bds.checklist2category
  ADD CONSTRAINT fk_checklist2category2 FOREIGN KEY (id_category) REFERENCES bds.categories(id_category) ON DELETE CASCADE;
ALTER TABLE bds.targets
  ADD CONSTRAINT fk_targets FOREIGN KEY (id_category) REFERENCES bds.categories(id_category) ON DELETE SET NULL;
ALTER TABLE bds.vulnerability2target
  ADD CONSTRAINT fk_vulnerability2target1 FOREIGN KEY (id_target) REFERENCES bds.targets(id_target) ON DELETE CASCADE;
ALTER TABLE bds.vulnerability2target
  ADD CONSTRAINT fk_vulnerability2target2 FOREIGN KEY (id_vulnerability) REFERENCES bds.vulnerabilities(id_vulnerability) ON DELETE CASCADE;
ALTER TABLE bds.person2task
  ADD CONSTRAINT fk_person2task1 FOREIGN KEY (id_person2project) REFERENCES bds.person2project(id_person2project) ON DELETE CASCADE;
ALTER TABLE bds.person2task
  ADD CONSTRAINT fk_person2task2 FOREIGN KEY (id_task) REFERENCES bds.tasks (id_task) ON DELETE CASCADE;
ALTER TABLE bds.target2task
  ADD CONSTRAINT fk_target2task1 FOREIGN KEY (id_target) REFERENCES bds.targets(id_target) ON DELETE CASCADE;
ALTER TABLE bds.target2task
  ADD CONSTRAINT fk_target2task2 FOREIGN KEY (id_task) REFERENCES bds.tasks(id_task) ON DELETE CASCADE;
ALTER TABLE bds.document_metadata
  ADD CONSTRAINT fk_document_metadata FOREIGN KEY (id_document) REFERENCES bds.documents(id_document) ON DELETE CASCADE;
ALTER TABLE bds.logs
  ADD CONSTRAINT fk_logs FOREIGN KEY (id_person) REFERENCES bds.persons(id_person) ON DELETE SET NULL;