desc 'Update the REST API doc template based on doc/openapi.yaml'

namespace :tra do
  task :generate_openapi_yaml do
    OPENAPI_YAML_PATH = File.expand_path './doc/openapi.yaml'
    ENV['OPENAPI'] = '1'

    File.delete OPENAPI_YAML_PATH if File.exists? OPENAPI_YAML_PATH
    system 'bundle exec rspec'
  end
end
