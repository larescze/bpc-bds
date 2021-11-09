-- -----------------------------------------------------
-- Table public.persons
-- -----------------------------------------------------
CREATE TABLE public.persons (
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
ALTER TABLE public.persons OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.role_types
-- -----------------------------------------------------
CREATE TABLE public.role_types (
  id_role_type bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.role_types OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.roles
-- -----------------------------------------------------
CREATE TABLE public.roles (
  id_role bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  id_role_type bigint NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.roles OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.person2role
-- -----------------------------------------------------
CREATE TABLE public.person2role (
  id_person bigserial NOT NULL,
  id_role bigint NOT NULL
);
ALTER TABLE public.person2role OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.permissions
-- -----------------------------------------------------
CREATE TABLE public.permissions (
  id_permission bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.permissions OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.role2permission
-- -----------------------------------------------------
CREATE TABLE public.role2permission (
  id_role bigint NOT NULL,
  id_permission bigint NOT NULL
);
ALTER TABLE public.role2permission OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.projects
-- -----------------------------------------------------
CREATE TABLE public.projects (
  id_project bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  description character varying(10000),
  start_date date NOT NULL,
  end_date date NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.projects OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.tasks
-- -----------------------------------------------------
CREATE TABLE public.tasks (
  id_task bigserial NOT NULL,
  id_project bigint NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  description character varying(10000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.tasks OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.documents
-- -----------------------------------------------------
CREATE TABLE public.documents (
  id_document bigserial NOT NULL,
  id_person bigint NOT NULL,
  document_name character varying(100) NOT NULL,
  document_path character varying(255) NOT NULL
);
ALTER TABLE public.documents OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.document2project
-- -----------------------------------------------------
CREATE TABLE public.document2project (
  id_document bigint NOT NULL,
  id_project bigint NOT NULL
);
ALTER TABLE public.document2project OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.person2project
-- -----------------------------------------------------
CREATE TABLE public.person2project (
  id_person2project bigserial NOT NULL,
  id_person bigint NOT NULL,
  id_project bigint NOT NULL,
  id_role bigint NOT NULL,
  invited_at timestamp without time zone NOT NULL,
  joined_at timestamp without time zone
);
ALTER TABLE public.person2project OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.categories
-- -----------------------------------------------------
CREATE TABLE public.categories (
  id_category bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.categories OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.checklists
-- -----------------------------------------------------
CREATE TABLE public.checklists (
  id_checklist bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  description character varying(10000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.checklists OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.checklist2category
-- -----------------------------------------------------
CREATE TABLE public.checklist2category (
  id_checklist bigint NOT NULL,
  id_category bigint NOT NULL
);
ALTER TABLE public.checklist2category OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.vulnerabilities
-- -----------------------------------------------------
CREATE TABLE public.vulnerabilities (
  id_vulnerability bigserial NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
  cve character varying(100) NULL,
  description character varying(100000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.vulnerabilities OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.targets
-- -----------------------------------------------------
CREATE TABLE public.targets (
  id_target bigserial NOT NULL,
  id_category bigint NOT NULL,
  slug character varying(255) NOT NULL,
  title character varying(255) NOT NULL,
    ADDress character varying(512) NULL,
  description character varying(100000),
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.targets OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.vulnerability2target
-- -----------------------------------------------------
CREATE TABLE public.vulnerability2target (
  id_vulnerability bigint NOT NULL,
  id_target bigint NOT NULL,
  description character varying(100000)
);
ALTER TABLE public.vulnerability2target OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.person2task
-- -----------------------------------------------------
CREATE TABLE public.person2task (
  id_person2project bigint NOT NULL,
  id_task bigint NOT NULL
);
ALTER TABLE public.person2task OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.target2task
-- -----------------------------------------------------
CREATE TABLE public.target2task (
  id_target bigint NOT NULL,
  id_task bigint NOT NULL
);
ALTER TABLE public.target2task OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.document_metadata
-- -----------------------------------------------------
CREATE TABLE public.document_metadata (
  id_document_metadata bigserial NOT NULL,
  id_document bigint NOT NULL,
  file_extension character varying(45) NOT NULL,
  file_type character varying(45) NOT NULL,
  file_size bigint NOT NULL,
  created_at timestamp without time zone NOT NULL,
  updated_at timestamp without time zone NOT NULL
);
ALTER TABLE public.document_metadata OWNER TO postgres;
-- -----------------------------------------------------
-- Table public.logs
-- -----------------------------------------------------
CREATE TABLE public.logs (
  id_log bigserial NOT NULL,
  id_person bigint NOT NULL,
  log_event character varying(255) NOT NULL,
  log_timestamp timestamp without time zone NOT NULL
);
ALTER TABLE public.logs OWNER TO postgres;
-- -----------------------------------------------------
-- Primary keys
-- -----------------------------------------------------
ALTER TABLE public.role_types
  ADD CONSTRAINT pk_role_types PRIMARY KEY (id_role_type);
ALTER TABLE public.persons
  ADD CONSTRAINT pk_persons PRIMARY KEY (id_person);
ALTER TABLE public.roles
  ADD CONSTRAINT pk_roles PRIMARY KEY (id_role);
ALTER TABLE public.person2role
  ADD CONSTRAINT pk_person2role PRIMARY KEY (id_person, id_role);
ALTER TABLE public.permissions
  ADD CONSTRAINT pk_permissions PRIMARY KEY (id_permission);
ALTER TABLE public.role2permission
  ADD CONSTRAINT pk_role2permission PRIMARY KEY (id_role, id_permission);
ALTER TABLE public.projects
  ADD CONSTRAINT pk_projects PRIMARY KEY (id_project);
ALTER TABLE public.tasks
  ADD CONSTRAINT pk_tasks PRIMARY KEY (id_task);
ALTER TABLE public.documents
  ADD CONSTRAINT pk_documents PRIMARY KEY (id_document);
ALTER TABLE public.document2project
  ADD CONSTRAINT pk_document2project PRIMARY KEY (id_document, id_project);
ALTER TABLE public.person2project
  ADD CONSTRAINT pk_person2project PRIMARY KEY (id_person2project);
ALTER TABLE public.categories
  ADD CONSTRAINT pk_categories PRIMARY KEY (id_category);
ALTER TABLE public.checklists
  ADD CONSTRAINT pk_checklists PRIMARY KEY (id_checklist);
ALTER TABLE public.checklist2category
  ADD CONSTRAINT pk_checklist2category PRIMARY KEY (id_checklist, id_category);
ALTER TABLE public.vulnerabilities
  ADD CONSTRAINT pk_vulnerabilities PRIMARY KEY (id_vulnerability);
ALTER TABLE public.targets
  ADD CONSTRAINT pk_targets PRIMARY KEY (id_target);
ALTER TABLE public.vulnerability2target
  ADD CONSTRAINT pk_vulnerability2target PRIMARY KEY (id_vulnerability, id_target);
ALTER TABLE public.person2task
  ADD CONSTRAINT pk_person2task PRIMARY KEY (id_person2project, id_task);
ALTER TABLE public.target2task
  ADD CONSTRAINT pk_target2task PRIMARY KEY (id_target, id_task);
ALTER TABLE public.document_metadata
  ADD CONSTRAINT pk_document_metadata PRIMARY KEY (id_document_metadata);
ALTER TABLE public.logs
  ADD CONSTRAINT pk_logs PRIMARY KEY (id_log);
-- -----------------------------------------------------
-- Unique Constraints
-- -----------------------------------------------------
ALTER TABLE public.role_types
  ADD CONSTRAINT uc_role_types UNIQUE (slug);
ALTER TABLE public.persons
  ADD CONSTRAINT uc_persons UNIQUE (email);
ALTER TABLE public.roles
  ADD CONSTRAINT uc_roles UNIQUE (slug);
ALTER TABLE public.permissions
  ADD CONSTRAINT uc_permissions UNIQUE (slug);
ALTER TABLE public.projects
  ADD CONSTRAINT uc_projects UNIQUE (slug);
ALTER TABLE public.tasks
  ADD CONSTRAINT uc_tasks UNIQUE (slug);
ALTER TABLE public.documents
  ADD CONSTRAINT uc_document_metadata UNIQUE (document_name, document_path);
ALTER TABLE public.categories
  ADD CONSTRAINT uc_categories UNIQUE (slug);
ALTER TABLE public.checklists
  ADD CONSTRAINT uc_checklists UNIQUE (slug);
ALTER TABLE public.vulnerabilities
  ADD CONSTRAINT uc_vulnerabilities UNIQUE (slug);
ALTER TABLE public.targets
  ADD CONSTRAINT uc_targets UNIQUE (slug);
-- -----------------------------------------------------
-- Unique Indexes
-- -----------------------------------------------------
CREATE UNIQUE INDEX idx_role_types_title ON public.role_types(title);
CREATE UNIQUE INDEX idx_persons_email ON public.persons(email);
CREATE UNIQUE INDEX idx_roles_title ON public.roles(title);
CREATE UNIQUE INDEX idx_permissions_title ON public.permissions(title);
CREATE UNIQUE INDEX idx_projects_title ON public.projects(title);
CREATE UNIQUE INDEX idx_tasks_title ON public.tasks(title);
CREATE UNIQUE INDEX idx_categories_title ON public.categories(title);
CREATE UNIQUE INDEX idx_checlists_title ON public.checklists(title);
CREATE UNIQUE INDEX idx_vulnerabilities_title ON public.vulnerabilities(title);
CREATE UNIQUE INDEX idx_targets_title ON public.targets(title);
-- -----------------------------------------------------
-- Foreign keys
-- -----------------------------------------------------
ALTER TABLE public.roles
  ADD CONSTRAINT fk_roles FOREIGN KEY (id_role_type) REFERENCES public.role_types(id_role_type) ON DELETE SET NULL;
ALTER TABLE public.person2role
  ADD CONSTRAINT fk_person2role1 FOREIGN KEY (id_person) REFERENCES public.persons(id_person) ON DELETE CASCADE;
ALTER TABLE public.person2role
  ADD CONSTRAINT fk_person2role2 FOREIGN KEY (id_role) REFERENCES public.roles(id_role) ON DELETE CASCADE;
ALTER TABLE public.role2permission
  ADD CONSTRAINT fk_role2permission1 FOREIGN KEY (id_role) REFERENCES public.roles(id_role) ON DELETE CASCADE;
ALTER TABLE public.role2permission
  ADD CONSTRAINT fk_role2permission2 FOREIGN KEY (id_permission) REFERENCES public.permissions(id_permission) ON DELETE CASCADE;
ALTER TABLE public.tasks
  ADD CONSTRAINT fk_tasks_projects FOREIGN KEY (id_project) REFERENCES public.projects(id_project) ON DELETE CASCADE;
ALTER TABLE public.documents
  ADD CONSTRAINT fk_documents FOREIGN KEY (id_person) REFERENCES public.persons(id_person) ON DELETE CASCADE;
ALTER TABLE public.document2project
  ADD CONSTRAINT fk_document2project FOREIGN KEY (id_project) REFERENCES public.projects(id_project) ON DELETE CASCADE;
ALTER TABLE public.person2project
  ADD CONSTRAINT fk_person2project1 FOREIGN KEY (id_person) REFERENCES public.persons(id_person) ON DELETE CASCADE;
ALTER TABLE public.person2project
  ADD CONSTRAINT fk_person2project2 FOREIGN KEY (id_project) REFERENCES public.projects(id_project) ON DELETE CASCADE;
ALTER TABLE public.person2project
  ADD CONSTRAINT fk_person2project3 FOREIGN KEY (id_role) REFERENCES public.roles(id_role) ON DELETE SET NULL;
ALTER TABLE public.checklist2category
  ADD CONSTRAINT fk_checklist2category1 FOREIGN KEY (id_checklist) REFERENCES public.checklists(id_checklist) ON DELETE CASCADE;
ALTER TABLE public.checklist2category
  ADD CONSTRAINT fk_checklist2category2 FOREIGN KEY (id_category) REFERENCES public.categories(id_category) ON DELETE CASCADE;
ALTER TABLE public.targets
  ADD CONSTRAINT fk_targets FOREIGN KEY (id_category) REFERENCES public.categories(id_category) ON DELETE SET NULL;
ALTER TABLE public.vulnerability2target
  ADD CONSTRAINT fk_vulnerability2target1 FOREIGN KEY (id_target) REFERENCES public.targets(id_target) ON DELETE CASCADE;
ALTER TABLE public.vulnerability2target
  ADD CONSTRAINT fk_vulnerability2target2 FOREIGN KEY (id_vulnerability) REFERENCES public.vulnerabilities(id_vulnerability) ON DELETE CASCADE;
ALTER TABLE public.person2task
  ADD CONSTRAINT fk_person2task1 FOREIGN KEY (id_person2project) REFERENCES public.person2project(id_person2project) ON DELETE CASCADE;
ALTER TABLE public.person2task
  ADD CONSTRAINT fk_person2task2 FOREIGN KEY (id_task) REFERENCES public.tasks (id_task) ON DELETE CASCADE;
ALTER TABLE public.target2task
  ADD CONSTRAINT fk_target2task1 FOREIGN KEY (id_target) REFERENCES public.targets(id_target) ON DELETE CASCADE;
ALTER TABLE public.target2task
  ADD CONSTRAINT fk_target2task2 FOREIGN KEY (id_task) REFERENCES public.tasks(id_task) ON DELETE CASCADE;
ALTER TABLE public.document_metadata
  ADD CONSTRAINT fk_document_metadata FOREIGN KEY (id_document) REFERENCES public.documents(id_document) ON DELETE CASCADE;
ALTER TABLE public.logs
  ADD CONSTRAINT fk_logs FOREIGN KEY (id_person) REFERENCES public.persons(id_person) ON DELETE SET NULL;