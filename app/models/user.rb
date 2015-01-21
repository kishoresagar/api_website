class User < ActiveRecord::Base
	include ActiveModel::MassAssignmentSecurity
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable



    def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.nickname
        user.password = Devise.friendly_token[0,20]
      end
    end

    def self.new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end

     def self.find_for_oauth(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.username = auth.info.nickname
        user.password = Devise.friendly_token[0,20]
      end
    end

    def password_required?
      super && provider.blank?
    end

    after_create do |obj|
    consumer = OAuth::Consumer.new(AppConfig['twitter']['consumer_key'], AppConfig['twitter']['consumer_secret'], :site => "https://twitter.com/")
    @request_token = consumer.get_request_token
    token = @request_token.authorize_url
    obj.tw_token = token.split('=')[1]
    obj.save
    Tweet.add_tweets(obj)

  end

  after_create do |obj|
     github = Github.new :client_id => "1960c9297914a720bb88", :client_secret => "e3a5cdd6e393b5aff09083e09dfdbf2741e53e74"
     github.authorize_url redirect_uri: 'http://localhost', scope: 'repo'
     token = github.get_token( authorization_code )
     obj.git_token = token.token
     obj.save
  end  
end
