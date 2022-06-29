# Getting started with the GraphQL API



## Notes


### Development

- The project now supports GraphQL.
- The GraphQL endpoint URL is `/graphql`.
- The GraphiQL (an IDE for our API) URL is `/graphiql`, which can only be
accessed during development. This will be **deprecated soon**.
- The GraphQL Playground can be accessed on the browser via
`/graphql/playground`


### Production (Heroku)

- Checkout the GraphQL Playground at
https://twitter-rails-api.herokuapp.com/graphql/playground



## Limitations

- Almost all of the fields in the GraphQL API are accessible only if you're
logged in.
- Authentication (login) is not currently supported in GraphQL. You must login
via the REST API first.
- A static GraphQL API doc is not yet available. Stay tuned for details.
