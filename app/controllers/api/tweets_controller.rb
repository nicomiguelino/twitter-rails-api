class API::TweetsController < ApplicationController
  before_action :authorize_request

  def index
    render json: Tweet.all,
      except: [:user_id],
      methods: [:url],
      include: {
        user: {
          except: [:password_digest, :created_at, :updated_at]
        }
      }
  end

  def create
    tweet = @current_user.tweets.create(**tweets_create_params)
    render json: tweet
  end

  def show
    begin
      render json: Tweet.find(params[:id]),
        except: [:user_id], include: {
          user: {
            except: [:password_digest, :created_at, :updated_at]
          }
        }
    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  private

  def tweets_create_params
    params.require(:tweet).permit(:content)
  end
end
