class GithubController < ApplicationController

	def index
		@gits = 	current_user.git_apis
	end

end
