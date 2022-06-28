# Setting up the Dockerized development instance



## Prerequisites

- Your machine runs a Debian-based Linux distribution (e.g., Ubuntu).
- You have Docker installed in your development or deployment machine.



## Setup


### Go to our project directory

```bash
cd $PATH_TO_PROJECT/twitter-rails-api/
# For example, cd ~/Code/twitter-rails-api/
```


### Build images based on the services defined in our `docker-compose.dev.yml`

```bash
docker-compose -f docker-compose.dev.yml build
```


### Start our API service (as a background process)

```bash
docker-compose -f docker-compose.dev.yml up -d
```


### Open the PostgreSQL interactive terminal, `psql`

Take note that the first occurrence of `postgres` refers to the service name,
which is the name of the relevant service defined in our `docker-compose.dev.yml`.

```bash
docker-compose -f docker-compose.dev.yml exec postgres-dev psql -U postgres
```

If you didn't set the `TRA_DEV_USER_PASSWORD` recently, enter the following
SQL commands:

```sql
CREATE USER tra_user WITH PASSWORD 'password';
ALTER USER tra_user CREATEDB;
```

Say that you've set `TRA_DEV_USER_PASSWORD` to `nokia3310`. If so, enter the
following instead:

```sql
CREATE USER tra_user WITH PASSWORD 'nokia3310';
ALTER USER tra_user CREATEDB;
```

Quit the interactive terminal.

```sql
\q -- Quit the psql terminal
```


### Setup the database

Executing the command below will "[create] all databases, loads all schemas,
and initializes with the seed data [defined in `db/seeds.rb`]."

```bash
docker-compose -f docker-compose.dev.yml exec app-dev bundle exec rails db:setup
```



### Starting our development server

Run the following command:

```bash
docker-compose -f docker-compose.dev.yml exec app-dev \
    bin/rails server -b 0.0.0.0
```

Now you can open your browser and go to `http://localhost:3000`.

Unlike in the [Dockerized production instance][1], there's not need to restart
the containers upon changing the source code (for most situations). Just refresh
your browser page.

If a simple page refresh won't cut it, try to run the following:

```bash
docker-compose -f docker-compose.dev.yml down
docker-compose -f docker-compose.dev.yml build
docker-compose -f docker-compose.dev.yml up -d
docker-compose -f docker-compose.dev.yml exec app-dev bin/rails db:migrate
```



<!-- References -->

[1]: /readme/docker/setting-up-dockerized-prod-instance.md
