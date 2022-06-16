desc 'Update the REST API doc template based on doc/openapi.yaml'

# TODO: Consider yarn:install as a dependency task.
# TODO: Make this task more flexible.
namespace :tra do
  task :generate_openapi_yaml do
    system 'OPTION=1 bundle exec rspec'
  end

  task update_rest_api_doc: [:generate_openapi_yaml]  do
    system 'yarn redoc-cli ' \
      '--output app/views/api/rest_docs/index.html ' \
      'doc/openapi.yaml'
  end
end
