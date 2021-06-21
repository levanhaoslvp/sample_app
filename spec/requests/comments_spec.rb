require 'rails_helper'

RSpec.describe "Comments", type: :request do

  let(:valid_post) do 
    {
      'id' => 1,
      'title' => 'my tittle',
      'content' => 'abc xyz'
    }
  end

  let(:valid_comment) do 
    {
      'content' => 'abc xyz'
    }
  end

  let(:invalid_comment) do 
    {
      'content' => ''
    }
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "no sign-in no pass" do
        current_user = create_user
        post = current_user.posts.create! valid_post
        post post_comments_url(post),
          params: {comment: {user_id: current_user.id, post_id: post.id, content: 'abc'}},xhr: true
        expect(response).to_not be_successful
      end
      it "create a new comment" do
        expect do
          current_user = create_user
          sign_in current_user
          post = current_user.posts.create! valid_post
          post post_comments_url(post), params: {comment: {user_id: current_user.id,
             post_id: post.id, content: 'abc'}}
        end.to change(Comment, :count).by(1)
      end

      it "render to the created comment" do
        current_user = create_user
        sign_in current_user
        post = current_user.posts.create! valid_post
        comment_new = Comment.new(user_id: current_user.id, post_id: post.id, content: 'abc')
        post post_comments_url(post),
          params: {comment: {user_id: current_user.id, post_id: post.id, content: 'abc'}},xhr: true
        expect(response).to render_template('comments/create')
      end
    end

    context "with invalid parameters" do
      it " no sign-in no pass" do
        current_user = create_user
        post = current_user.posts.create! valid_post
        comment_new = Comment.new(user_id: current_user.id, post_id: post.id, content: 'abc')
        post post_comments_url(post),
          params: {comment: {user_id: current_user.id, post_id: post.id, content: 'abc'}},xhr: true
        expect(response).to_not be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    context "with valid parameters" do
      it "no sign-in no pass" do
        current_user = create_user
        post = current_user.posts.create! valid_post
        comment = Comment.create!(user_id: current_user.id, post_id: post.id, content: 'abc')
        delete comment_url(comment),xhr: true
        expect(response).to_not be_successful
      end

      it "delete a comment" do
        current_user = create_user
        sign_in current_user
        post = current_user.posts.create! valid_post
        comment = Comment.create!(user_id: current_user.id, post_id: post.id, content: 'abc')
        expect {
          delete comment_url(comment), xhr: true
        }.to change(Comment, :count).by(-1) 
      end

      it "remove comment" do
        current_user = create_user
        sign_in current_user
        post = current_user.posts.create! valid_post
        comment = Comment.create!(user_id: current_user.id, post_id: post.id, content: 'abc')
        delete comment_url(comment), xhr: true
        expect(response).to be_successful
      end
    end
  end
  
end
