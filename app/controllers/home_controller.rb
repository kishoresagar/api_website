class HomeController < ApplicationController
  def index
  	if current_user.present?
  		if current_user.provider == "twitter"
  			redirect_to user_tweets_path(current_user)
  		elsif current_user.provider == "github"
  			redirect_to user_github_index_path(current_user)
  		end
  	else 
  		redirect_to root_url
  	end


  end
end
