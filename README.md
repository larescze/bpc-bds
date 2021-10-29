# BPC-BDS - Semester course project
The database is used for management of penetration testing. Testers can create projects in the application and invite other users to join the project. The application includes all phases of penetration testing according to specific methodologies (e.g. OWASP, OSSTMM, PTES, ISSAF).

Database use case is located in the document in the `docs` directory, see file [BPC_BDS_SP.pdf](docs/BPC_BDS_SP.pdf).

## Setup

Clone the repository: 
```
git clone https://github.com/larescze/bpc-bds-xlazar15.git
```
Run the following command in the root directory:
```shell
$ docker-compose up
```

## Run environmen

Follow these steps:

1. Make sure the docker container is up.
2. Open pgAdmin [http://localhost:5080/browser/](http://localhost:5080/browser/);
3. Click on: `Servers > Create > Server` fill the following fields:
   1. General > Name: **BPC-BDS-xlazar15**
   2. Connection > Host name: **xlazar15-db-postgres**
   3. Connection > Username: **postgres**
   4. Connection > Password: **postgres**
4. Database tables are located at: `Databases > db-pentesting > Schemas > Public > Tables`
5. ERD diagram is available at: `Databases > db-pentesting (right click) > Generate ERD`

## MySQL

Docker container is designed for PostgreSQL database. To import MySQL database, use files from `mysql` directory.
