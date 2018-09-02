class WelcomeController < ApplicationController
  before_action :authenticate_user!
  require "#{Rails.root}/lib/twitterlogic.rb"
  
  def index
      @posts=TWITTERLOGIC.user_posts(current_user)
      @friend_tweets=TWITTERLOGIC.getFriendTweets(current_user)
  end

  def search_user
    @persons=TWITTERLOGIC.getfriends(current_user,params[:name].to_s)
    respond_to do |format|
      format.html
      format.json { render :json => @persons }
    end

 end

 def follow_or_unfollow
  puts "user_idddddd"+params[:user_id].to_s
  @follow_or_unfollow=TWITTERLOGIC.follow_or_unfollow(current_user,params[:user_id].to_i)
    respond_to do |format|
      format.html
      format.json { render :json => @follow_or_unfollow }
    end
  end
  def re_tweet
   @re_tweets_msg=TWITTERLOGIC.reTweets(current_user,params[:post_id].to_i)
   flash[:notice] = @re_tweets_msg.to_s 
     #return redirect_to superadmin_home_path
     return redirect_to :controller => 'welcome', :action => 'index' 

  end

  def messages
  	@msgs=TWITTERLOGIC.getMessages(current_user,params[:send_to].to_i)
  end
  def getrealtime_msgs
   @msgs=TWITTERLOGIC.getMessages(current_user,params[:send].to_i)
    respond_to do |format|
      format.html
      format.json { render :json => @msgs }
    end
  end

  def create_msg
   @create_msg=TWITTERLOGIC.createMsg(current_user,params[:message].to_s,params[:send_to].to_i)
   @msgs=TWITTERLOGIC.getMessages(current_user,params[:send_to].to_i)
    respond_to do |format|
      format.html
      format.json { render :json => @msgs }
    end
  end
end
