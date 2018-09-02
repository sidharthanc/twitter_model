class PostsController < ApplicationController

    before_action :authenticate_user!

    def new
        @post=Post.new
    end

    def create
        puts post_params
        @post =Post.new(post_params)
        
        @post.user_id = current_user.id
        if @post.save() 
            redirect_to @post
        else
            render 'new'
        end
    end

    def show
        @post=Post.find(params[:id])
    end

    def index
        @posts = Post.where("user_id IN (?)",current_user.id)
    end

    def edit
        @post=Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(params[:post].permit(:title, :text))
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy 
        @retweet=Retweet.find_by_post_id(params[:id].to_i)
        if !@retweet.blank?
            @delete_post=Retweet.find(@retweet.id.to_i)
            @delete_post.destroy
         end   
        @post=Post.find(params[:id])
        @post.destroy

        redirect_to @post
    end

    private

    def post_params
        params.require(:post).permit(:title, :text, :image)
    end
    


end
