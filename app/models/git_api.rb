class GitApi < ActiveRecord::Base

	belongs_to :user

	def self.add_repo_lists(user)
		repo_lists = Github.repos.list user: user.username
		repo_lists.each do |l|
			git_api = user.git_apis.new
			git_api.clone_url = l.clone_url
			git_api.name = l.full_name
			git_api.save
		end
	end
end
