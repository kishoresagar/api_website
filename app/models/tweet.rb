class Tweet < ActiveRecord::Base
	include ActiveModel::MassAssignmentSecurity

  attr_accessible :username, :latest
end
