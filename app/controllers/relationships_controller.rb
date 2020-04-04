class RelationshipsController < ApplicationController
	def create
		current_user.follow(params[:user_id])
		redirect_back(fallback_location: root_url)
	end
	def destroy
		current_user.unfollow(params[:user_id])
		redirect_back(fallback_location: root_url)
	end
	def follower
		user = User.find(params[:user_id])
		@follows = user.followings
	end
	def followed
		user = User.find(params[:user_id])
		@followers = user.followers
	end
end
