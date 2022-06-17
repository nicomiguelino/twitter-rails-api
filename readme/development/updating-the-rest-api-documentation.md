# Updating the REST API documentation



## Introduction

The documentation for the REST API can be accessed via `/api/docs`,
(e.g., http://localhost:3000/api/docs). However, the documentation never
updates itself. We need to run a utility command (a.k.a. "tasks" in Ruby)
for updating the docs, which is a static HTML file.



## Prerequisites

Before proceeding, make sure that you're inside the project directory.

```bash
cd $PATH_TO_PROJECT/twitter-rails-api/
# For example, cd ~/Code/twitter-rails-api/
```



## Running the utility command to update the documentation

You just need to run one command.

```bash
bin/rails tra:update_rest_api_doc
```

Here's a sample output (on successful command execution):

```
[1/4] Resolving packages...
success Already up-to-date.
Done in 0.16s.
*.

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) User add some examples to (or delete) /home/nicomiguelino/Code/GitHub/nicomiguelino/twitter-rails-api/spec/models/user_spec.rb
     # Not yet implemented
     # ./spec/models/user_spec.rb:4


Finished in 0.04882 seconds (files took 0.70506 seconds to load)
2 examples, 0 failures, 1 pending

yarn run v1.22.15
$ /home/nicomiguelino/Code/GitHub/nicomiguelino/twitter-rails-api/node_modules/.bin/redoc-cli --output app/views/api/rest_docs/index.html doc/openapi.yaml
Done in 0.36s.
```



## Check your browser to see the changes

Go ahead and run `bin/rails server` to start the development server.
On your browser, go to `http://localhost:3000/api/docs`. Now we're done.
