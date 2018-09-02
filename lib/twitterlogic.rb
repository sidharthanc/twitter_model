require 'pp'
module TWITTERLOGIC

  # define custom exception
  class CustomException < Exception
  end


  # Code to initialize Module
  # create struct to hold medical notes and prescriptions
  Struct.new("TwitterLogicFrientPost",:file)
  Struct.new("TwitterLogicAllUsers",:file,:follow)
  Struct.new("TwitterLogicMessages",:file,:create,:send)
  #
  #

  # utility_methods
  # return roles of the gven user
  def self.user_posts(current_user)
    posts=Post.where("user_id=?",current_user.id.to_i)
    posts
  end

  def self.getfriends(current_user,name_val)
    param = "%#{name_val}%"
    available_users_file=[]
    follow=''
    allPersons = User.where("name like ? and id!=?",param,current_user.id.to_i)
    allPersons.each do |persons|
      follow_people=Follow.where("owner=? and user_id=?",current_user.id.to_i,persons.id.to_i)
      if follow_people.blank?
        follow='follow'
        available_users_file.append Struct::TwitterLogicAllUsers.new(persons,follow)
      else
        follow='unfollow'
       available_users_file.append Struct::TwitterLogicAllUsers.new(persons,follow)
      end
     end
     pp available_users_file
  end

  def self.getFriendTweets(current_user)
    available_friend_posts=[]
    follow=Follow.where("owner=?",current_user.id.to_i)
    follow.each do |follow|
    friend_posts=Post.where("user_id=?",follow.user_id)
     friend_posts.each do |friend_post|
     available_friend_posts.append Struct::TwitterLogicFrientPost.new(friend_post)
      end
    end
    pp available_friend_posts
  end

  def self.follow_or_unfollow(current_user,user_id)
   follow_people=Follow.where("owner=? and user_id=?",current_user.id.to_i,user_id.to_i)
     if follow_people.blank?
      #follow that particular user
      follow=Follow.create :user_id => user_id, :owner => current_user.id.to_i
      follow.save!
      else
        #make unfollow person
       Follow.find(follow_people.first.id.to_i).destroy
      end
  end

  def self.getMessages(current_user,send_to)
   available_msgs=[] 
   msgs = Message.where("(create_by= #{current_user.id.to_i} OR create_by= #{send_to.to_i}) AND (send_to=#{current_user.id.to_i} OR send_to=#{send_to.to_i})")
   msgs.each do |msg|
  
    create_by=User.find_by_id(msg.create_by.to_i) 
    send_to=User.find_by_id(msg.send_to.to_i)
    available_msgs.append Struct::TwitterLogicMessages.new(msg,create_by.name.to_s,send_to.name.to_s)
   end
   pp available_msgs
  end

  def self.reTweets(current_user,post_id)
  friend_post=Post.find_by_id(post_id)
  post_user=User.find_by_id(friend_post.user_id.to_i)
  msg=''
  post=Post.create :title => friend_post.title.to_s, :text => friend_post.title.to_s, :user_id => current_user.id.to_i 
    if post.save
      re_tweet=Retweet.create :post_id => post_id.to_i , :user_id => current_user.id.to_i
      re_tweet.save!
      msg="You shared #{post_user.name.to_s}'s post "
      else
       msg="cant share the post"
    end
    pp msg
  end

  def self.checkOnceTweeted(current_user,post_id)
   retweet_list=Retweet.where("user_id=? and post_id=?",current_user.id.to_i,post_id.to_i)
   pp retweet_list
  end

  def self.createMsg(current_user,body,send_to)
   message=Message.create :body => body.to_s , :create_by => current_user.id.to_i, :send_to => send_to.to_i
   if message.save
     msg=1
    else
    msg=0
   end
   pp msg
  end
end
