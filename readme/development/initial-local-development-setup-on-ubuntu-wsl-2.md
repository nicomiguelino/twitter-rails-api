# Initial local development setup on Ubuntu (WSL 2)



## Prerequisites

The following is already installed on your local development machine.

- WSL 2 ([Windows Subsystem for Linux][1]), defaults to the latest LTS version
    of Ubuntu (for instance, 20.04 LTS) on clean install
- Ruby (3.1.2, based on the version indicated in the [Gemfile](/Gemfile))
- PostgreSQL 13



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

Execute the following SQL statements:

```sql
-- The password should be inside single quotes.
CREATE USER <username> WITH PASSWORD '<password>';
```

Now quit the `psql` shell by entering `\q`. You should now be back to your
primary session.

#### Option 2: Create a database and a user

If [Option 1][2] didn't work, you may want to try this method.


### Initialize databases and tables by running built-in Rails commands

This page is under construction. Stay tuned for more updates. :radio:



<!-- References -->

[1]: https://docs.microsoft.com/en-us/windows/wsl/
[2]: #option-1-create-a-user
