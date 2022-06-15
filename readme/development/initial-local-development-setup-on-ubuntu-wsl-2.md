# Initial local development setup on Ubuntu (WSL 2)



## Prerequisites

The following is already installed on your local development machine.

- WSL 2 ([Windows Subsystem for Linux][1]), defaults to the latest LTS version
    of Ubuntu (for instance, 20.04 LTS) on clean install
- Ruby (3.1.2, based on the version indicated in the [Gemfile](/Gemfile))
- PostgreSQL 13



## Database Setup


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

This page is under construction. Stay tuned for more updates. :construction:



<!-- References -->

[1]: https://docs.microsoft.com/en-us/windows/wsl/
