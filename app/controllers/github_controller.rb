class GithubController < ApplicationController

	def index
		@gits = 	GitApi.all
	end

end
