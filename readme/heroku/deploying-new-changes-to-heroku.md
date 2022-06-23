# Deploying new changes to Heroku



## Execution

You only need to execute a couple of commands to get things done. The first
command will push your latest changes to your Heroku app. The second command
will apply new database migrations to your heroku app.

If you're working on a Git branch other than `main`, run the following:

```bash
git push heroku ${LOCAL_BRANCH NAME}:main
```

Otherwise, just push to `main`.

```bash
git push origin main
```

We can now apply new database migrations.

```bash
heroku run rake db:migrate
```



## Resetting the PostgreSQL database on Heroku

Refer to [this GitHub gist][1] for details. Run the following commands:

```bash
heroku restart
heroku pg:reset $DATABASE_NAME --app twitter-rails-api
heroku run rake db:migrate
heroku run rake db:seed
```

Make sure to replace `$DATABASE_NAME` with the database named automatically
configured by Heroku for you.

Just go to Heroku &rarr; App (twitter-rails-api) &rarr; Resources &rarr; Heroku
Postgres &rarr; Settings &rarr; Database Credentials &rarr; View Credentials.
From there, you can copy the custom command (see the Heroku CLI for details).



## Notes

- [Not all Rails tasks (Rake commands) are supported by Heroku.][2]
- ["The `db:reset` task is not supported. Heroku apps do not have permission to
drop and create databases. Use the `heroku pg:reset` command instead."][2]



## Related issues

- nicomiguelino/twitter-rails-api#32



## References

- [GitHub Gist - How to reset PG database on Heroku?][1]
- [Heroku Dev Center - Running Rake Commands - Limitations][2]
- [Heroku Dev Center - Getting Started on Heroku with Rails 7.x][3]


[1]: https://gist.github.com/zulhfreelancer/ea140d8ef9292fa9165e
[2]: https://devcenter.heroku.com/articles/rake#limitations
[3]: https://devcenter.heroku.com/articles/getting-started-with-rails7
