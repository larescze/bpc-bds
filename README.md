# BPC-BDS - Semester course project
The database is used for management of penetration testing. Testers can create projects in the application and invite other users to join the project. The application includes all phases of penetration testing according to specific methodologies (e.g. OWASP, OSSTMM, PTES, ISSAF).

Semestral project repository: [https://github.com/larescze/bpc-bds-xlazar15](https://github.com/larescze/bpc-bds-xlazar15).

## Features

The repository includes:
- Docker project with containers
- Project documentation
- PostgreSQL - Container, ERD, DDL, DML, MySQL export
- Database migrations with Flyway
- Advanced SQL statements with examples
- Database automated backups
- Web application
   - SPA - Vue.js, TypeScript, Sass
   - Django - app logic, DB connection, REST API 
   - Authentication and authorization functions
   - User roles and permissions
   - UI for CRUD operations
   - Secure source code
   - SQL Injection example
   - Logging and log files
   - Application licence
   - Depedencies licences
   - Unit tests for CRUD
   - GitHub Actions

## Docs
All documentation can be found in the [docs](./docs) directory, see file [BPC_BDS_SP_Use-case.pdf](docs/BPC_BDS_SP_Use-case.pdf).

## SQL statements
All advanced SQL queries can be found in the [statements](./statements) directory.

### PostgreSQL
- Database schema (pgAdmin): [DB_Schema_pgAdmin.pdf](docs/DB_Schema_pgAdmin.pdf)
- Database example (pgAdmin): [DB_pgAdmin](docs/DB_pgAdmin.pdf)

### MySQL
- Database schema (MySQL Workbench): [DB_Schema_MySQL-Workbench.pdf](docs/DB_Schema_MySQL-Workbench.pdf)
- Database example (phpMyAdmin): [DB_phpMyAdmin.pdf](docs/DB_phpMyAdmin.pdf)


## Setup

Clone the repository: 
```
git clone https://github.com/larescze/bpc-bds-xlazar15.git
```
Run the following command in the root directory:
```
docker-compose up
```

## Install certificates for application

Download certificates:

- [Application certificate](./certs/cert.ca)
- [Development server certificate](./certs/localhost.ca)

## Run the application

Run the following command in the root directory:
```
cd ./app/frontend; npm install; npm run serve
```

Follow these steps:

1. Open Web application [https://localhost](https://localhost)
2. Login with username **xlazar15** and password **#IloveBDS_2021**
3. Explore the application
4. (OPTIONAL) If you want to perform SQL Injection atttack, visit https://localhost/try-to-hack-me

## Access the database

Follow these steps:

1. Make sure the docker container is up.
2. Open pgAdmin [http://localhost:5080/browser/](http://localhost:5080/browser/)
3. Login with username **xlazar15@vut.cz** and password **postgres**
4. Right click on: `Servers > Create > Server` fill the following fields:
   1. General > Name: **BPC-BDS-xlazar15**
   2. Connection > Host name: **xlazar15-db-postgres**
   3. Connection > Username: **postgres**
   4. Connection > Password: **postgres**
5. Database is located at: `Databases > db-pentesting`
6. Database tables are located at: `Databases > db-pentesting > Schemas > Public > Tables`
7. ERD diagram is available at: `Databases > db-pentesting (right click) > Generate ERD`

## Manual imports

### PostgreSQL

For manual import, use files containing words ***db-postgres-schema*** and ***db-postgres-data*** with the highest ***V*** prefix from the `db/migration/postgresql` directory.

Follow these steps:

1. Open pgAdmin
2. Connect to Server
3. Import migrations: `Tools > Query Tool > Open File > Upload File > Select`
   1. Database schema  `Tools > Query Tool > Open File > Upload File > Select`
   2. Database data  `Tools > Query Tool > Open File > Upload File > Select`

### MySQL

Docker container is designed for PostgreSQL database. To import MySQL database, use files from the `mysql` directory.

1. Open phpMyAdmin
2. Import migrations:  `Import > Select file > Go`
   1. Database schema: [db/migration/db-mysql-schema.sql](db/migration/db-mysql-schema.sql)
   2. Database data: [db/migration/db-mysql-data.sql](db/migration/db-mysql-data.sql)

## Third Normal Form (3NF)

This database is in 3rd normal form, which also means that database is in 2rd normal form (2NF) and first normal form (1NF). There is no transitive dependency for non-prime attributes and all non-primary key attributes are transitively dependent only on the primary key.
