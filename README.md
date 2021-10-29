# BPC-BDS - Semester course project
The database is used for management of penetration testing. Testers can create projects in the application and invite other users to join the project. The application includes all phases of penetration testing according to specific methodologies (e.g. OWASP, OSSTMM, PTES, ISSAF).

Database use case is located in the document in the `docs` directory, see file [BPC_BDS_SP.pdf](docs/BPC_BDS_SP.pdf).

## How to start

Clone the repository: 
```
git clone https://github.com/larescze/bpc-bds.git
```
Run the following command in the root directory:
```shell
$ docker-compose up
```

## MySQL

Docker container is designed for PostgreSQL database. To import MySQL database, use files from `mysql` directory.