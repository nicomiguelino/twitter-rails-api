# Setting up our containerized production-ready API



## Prerequisites

- Your machine runs a Debian-based Linux distribution (e.g., Ubuntu).
- You have Docker installed in your development or deployment machine.



## Setup


### Go to our project directory

```bash
cd $PATH_TO_PROJECT/twitter-rails-api/
# For example, cd ~/Code/twitter-rails-api/
```


### Build images based on the services defined in our `docker-compose.yml`

```bash
docker-compose build
```


### Start our API service (as a background process)

```bash
docker-compose up -d
```


### Open the PostgreSQL interactive terminal, `psql`

Take note that the first occurrence of `postgres` refers to the service name,
which is the name of the relevant service defined in our `docker-compose.yml`.

```bash
docker-compose exec postgres psql -U postgres
```

Enter the following SQL commands.

```sql
CREATE USER tra_user WITH PASSWORD 'password';
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
docker-compose exec app bundle exec rails db:setup
```



## Related Issues

- nicomiguelino/twitter-rails-api#24



## References

- [Semaphore - Dockerizing a Ruby on Rails Application][1]
- [Docker Documentation - Quickstart: Compose and Rails][2]
- [Medium - (2021) Docker + Ruby 3 + Rails 6 + Puma + Nginx + Postgres][3]
- [GitHub - joaoscotto/docker-ruby-puma-nginx-postgres][4]
- [GitHub - nicomiguelino/docker-ruby-puma-nginx-postgres][5]
- [GitHub - nodesource/distributions - Installation instructions][6]
- [Docker - Dockerfile returns `npm not found` on build][7]
- [Geshan's Blog - PostgreSQL with `docker-compose`][8]



<!-- References -->

[1]: https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application
[2]: https://docs.docker.com/samples/rails/
[3]: https://scotto.medium.com/2021-docker-ruby-3-rails-6-puma-nginx-postgres-d84c95f68637
[4]: https://github.com/joaoscotto/docker-ruby-puma-nginx-postgres
[5]: https://github.com/nicomiguelino/docker-ruby-puma-nginx-postgres
[6]: https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
[7]: https://stackoverflow.com/a/49088882
[8]: https://geshan.com.np/blog/2021/12/docker-postgres/#postgresql-with-docker-compose
