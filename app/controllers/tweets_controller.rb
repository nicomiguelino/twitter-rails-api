class TweetsController < ApplicationController
  def list
    render json: {
      id: 1,
      name: 'Pikachu',
      type: 'Electric'
    }
  end
end
