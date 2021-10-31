# BPC-BDS - Semester course project
The database is used for management of penetration testing. Testers can create projects in the application and invite other users to join the project. The application includes all phases of penetration testing according to specific methodologies (e.g. OWASP, OSSTMM, PTES, ISSAF).

The use case for the database can be found in the `docs` directory, see file [BPC_BDS_SP.pdf](docs/BPC_BDS_SP.pdf).

Database schema (MySQL Workbench): [DB_Schema_MySQL-Workbench](docs/DB_Schema_MySQL-Workbench.pdf).

Database schema (pgAdmin): [DB_Schema_pgAdmin](docs/DB_Schema_pgAdmin.png).

## Setup

Clone the repository: 
```
git clone https://github.com/larescze/bpc-bds-xlazar15.git
```
Run the following command in the root directory:
```
docker-compose up
```

## Run environmen

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

## PostgreSQL

For manual import, use files containing words ***db-postgres-schema*** and ***db-postgres-data*** with the highest ***V*** prefix from the `db/migration/postgresql` directory.

Follow these steps:

1. Open pgAdmin
2. Connect to Server
3. Import migrations: `Tools > Query Tool > Open File > Upload File > Select`
   1. Database schema  `Tools > Query Tool > Open File > Upload File > Select`
   2. Database data  `Tools > Query Tool > Open File > Upload File > Select`

## MySQL

Docker container is designed for PostgreSQL database. To import MySQL database, use files from the `mysql` directory.

1. Open phpMyAdmin
2. Import migrations:  `Import > Select file > Go`
   1. Database schema: [db/migration/db-mysql-schema.sql](db/migration/db-mysql-schema.sql)
   2. Database data: [db/migration/db-mysql-data.sql](db/migration/db-mysql-data.sql)