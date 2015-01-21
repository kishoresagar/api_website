class TweetsController < ApplicationController

	def index
		@tweets = current_user.tweets
	end

  def new
  end
end
