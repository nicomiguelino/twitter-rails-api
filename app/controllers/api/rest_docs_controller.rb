class API::RESTDocsController < ActionController::Base
  def index
    render 'api/rest_docs/index'
  end
end
