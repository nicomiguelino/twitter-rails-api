class API::RESTDocsController < ActionController::Base
  def index
  end

  def schema
    openapi_yaml_path = File.join Rails.root, 'doc/openapi.yaml'
    render json: YAML.load(File.read(openapi_yaml_path))
  end
end
