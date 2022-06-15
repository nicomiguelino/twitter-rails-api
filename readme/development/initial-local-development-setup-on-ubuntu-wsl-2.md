# Initial local development setup on Ubuntu (WSL 2)



## Prerequisites

The following is already installed on your local development machine.

- WSL 2 ([Windows Subsystem for Linux][1]), defaults to the latest LTS version
    of Ubuntu (for instance, 20.04 LTS) on clean install
- Ruby (3.1.2, based on the version indicated in the [Gemfile][4])
- PostgreSQL 13



## Go to our project directory

```bash
cd $PATH_TO_PROJECT/twitter-rails-api/
# For example, cd ~/Code/twitter-rails-api/
```



## Install dependencies

Install the dependencies inside the [Gemfile][4] by running the following:

```bash
bundle install
```



## Database setup


### Open up a PostgreSQL shell

```bash
sudo -u postgres psql
```

Type your user password when prompted with the following:

```
[sudo] password for <username>:
```

When successful, you should be able to see the following `psql` prompt:

```
psql (13.7 (Ubuntu 13.7-1.pgdg20.04+1), server 13.4 (Ubuntu 13.4-4.pgdg20.04+1))
Type "help" for help.

postgres=#
```


### Initial PostgreSQL setup

You'll only need to do this once. There are two possible ways for doing so.
Before going further, make sure that you have your `psql` shell open.

#### Option 1: Create a user

Execute the following SQL commands:

```sql
-- The password should be inside single quotes.
CREATE USER <username> WITH PASSWORD '<password>';
```

The `<username>` and `<password>` depends on the values configured in
[config/database.yml][3].

In our case, the `username` and `password` is the same across all environments
(`development`, `test`, and `production`), configured to `tra_user` and
`password`, respectively.

Give the new user the permission to create new databases. We'll be having issues
with creating a new database when running `bin/rails db:setup` later on in this
documentation.

```sql
ALTER USER <username> CREATEDB;
```

Here's the sample commands with values inside [database.yml][3]:

```sql
CREATE USER tra_user WITH PASSWORD 'password';
ALTER USER tra_user CREATEDB;
```

#### Option 2: Create a database and a user

If [Option 1][2] didn't work, you may want to try this method. [Option 1][2]
should be fine. If you're to paranoide, execute the following SQL commands
instead, for each of the following database that we need to create:

```sql
CREATE DATABASE <database>;
GRANT ALL PRIVILEGES ON DATABASE <database> to <username>;
```

Here's an example:

```sql
-- Create a user and give it with the necessary permission.
CREATE USER <username> WITH PASSWORD '<password>';
ALTER USER <username> CREATEDB;

-- Create and setup a database for our development environment.
CREATE DATABASE tra_development;
GRANT ALL PRIVILEGES ON DATABASE tra_development TO tra_user;

-- Create and setup a database for local unit testing.
CREATE DATABASE tra_test;
GRANT ALL PRIVILEGES ON DATABASE tra_test TO tra_user;
```


### Run Rails commands to complete database setup

Now quit the `psql` shell by entering `\q`. You should now be back to your
primary session.

Make sure that you're still inside the [twitter-rails-app][5] directory. If not,
you might want to [do this first][6].

Run the following:

```bash
bin/rails db:setup
```

If you've followed the steps under [Option 1][2], expect the following console
output:

```
Created database 'tra_development'
Created database 'tra_test'
```

However, if you've followed the steps under [Option 2][7], expect the following
console output:

```
Database 'tra_development' already exists
Database 'tra_test' already exists
```

Regardless of the option that you've followed, the expected behavior should be
almost the same.

The command `bin/rails db:setup` does the following:

- Creates all database
- Loads all schemas (thus creating the database tables)
- Initializes the database with the seed data specified inside [db/seeds.rb][8]

We can check the database (via `psql`) whether the seed data has been loaded
into the database. But first, we must [go back to the `psql` shell][9].

Go inside the `tra_development` database by executing the following SQL
commands:

```sql
\c tra_development
```

For instance, we can check the rows inside the `tweets` table.

```sql
SELECT * FROM tweets;
```

Here's a sample output:

```
id |       content        |         created_at         |         updated_at         | user_id
----+----------------------+----------------------------+----------------------------+---------
  1 | My first post.       | 2022-06-15 06:14:56.479398 | 2022-06-15 06:14:56.479398 |       1
  2 | Another one.         | 2022-06-15 06:14:56.484106 | 2022-06-15 06:14:56.484106 |       1
  3 | Lucas, do you copy?! | 2022-06-15 06:14:56.844287 | 2022-06-15 06:14:56.844287 |       3
```

Once you're done, you can just quit the database shell by running `\q`.



<!-- References -->

[1]: https://docs.microsoft.com/en-us/windows/wsl/
[2]: #option-1-create-a-user
[3]: /config/database.yml
[4]: /Gemfile
[5]: /
[6]: #go-to-our-project-directory
[7]: #option-2-create-a-database-and-a-user
[8]: /db/seeds.rb
[9]: #open-up-a-postgresql-shell
