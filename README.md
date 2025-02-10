
Project kali ini menginmplementasikan DBT untuk membuat 3 Database, yakni: raw, intermediate, and mart

Start Postgres Database on Docker/Device Host
Sample Data Here: https://www.postgresqltutorial.com/postgresql-getting-started/load-postgresql-sample-database/
Downloads dvdrental.zip
Extract dvdrental.zip as directory
For you that run Postgres in Docker
If you run Postgres with docker then run this command to mount path to container
docker run --name postgres-test -e PGDATA=/var/lib/postgresql/data -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=postgres -p 5433:5432 -v ./dvdrental:/dvdrental -v dbt-postgres:/var/lib/postgresql/data -d postgres-test:12
​
Run this to restore backup file
docker exec -it <postgres container name> bash
create database data_warehouse
# quit database
\q

# Run in terminal
pg_restore -U postgres -d data_warehouse /dvdrental
​
For you that run Postgres not Using Docker
Open Terminal/PowerShell
Run
psql -U postgres
create database data_warehouse
# quit database
\q

# Run in terminal
pg_restore -U postgres -d data_warehouse /path/to/dvdrental
​
DBT
Create new Python Virtual Environment: python3 -m venv env
Activate Virtual Environment: source env/bin/activate
Install DBT libraries: 
pip3 install dbt-core
pip3 install dbt-postgres
Initiate DBT project
dbt init
​
Create profiles.yml
data_warehouse:
  outputs:
    dev:
      dbname: data_warehouse
      host: localhost
      pass: postgres
      port: 5433
      schema: dbt_dev
      threads: 1
      type: postgres
      user: postgres
    prod:
      dbname: data_warehouse
      host: localhost
      pass: postgres
      port: 5433
      schema: dbt
      threads: 1
      type: postgres
      user: postgres
  target: dev

​
Run debug, if all connections passed then move to next step
dbt debug
​
Data Modelling
Create Schema medallion architecture :
raw: Raw data
intermediete: Fact and dim table
gold: Mart
Login to Postgres 
\c data_warehouse

create schema dbt_dev_raw;
create schema dbt_dev_intermediate;
create schema dbt_dev_mart;
​
Create raw model and write it to raw_dev schema using DBT
payment
rental
staff
customer
address
inventory
film
film_actor
actor
Create sources.yml
version: 2

sources:
  - name: public
    database: data_warehouse
    schema: public
    tables:
      - name: payment
​
Create intermediete model and write it to intermediete_dev schema using DBT
fact_payment
dim_rental
dim_staff
dim_customer
dim_address
dim_inventory
dim_film
dim_film_actor
dim_actor
Create mart model and write it to mart_dev schema using DBT
How many monthly total revenue ?
What is the best selling film ?
Who is the actor who plays the most roles in films ?
DBT UI
Generate docs
dbt docs generate
​
Run UI
dbt docs serve

Berikut ini screenshot saat berhasil run dbt:

![Screenshot dari hasil run dbt](https://github.com/triutama133/ftde2_Project2/blob/main/Screenshot.png)





### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
