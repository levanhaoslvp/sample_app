require 'rails_helper'

RSpec.describe "Comments", type: :request do

  let(:current_user){ create(:user)}

  let(:test_post){ create(:post, user: current_user)}

  let(:comment_param) do 
  {
    content: 'abcdef',
    post_id: test_post.id,
    user_id: current_user.id
  }
  end

  before { sign_in current_user}

  describe 'no loggin' do
    before {sign_out current_user}

    it "POST /create" do
      post post_comments_url(test_post),params: {comment: comment_param },xhr: true
      expect(response).to_not be_successful
    end

    it "DELETE /destroy" do
      comment = create(:comment, user_id: current_user.id, post_id: test_post.id)
      delete comment_url(comment), xhr: true
      expect(response).to_not be_successful
    end
  end

  describe "POST /create" do
    it " has a content" do
      expect do
        post post_comments_url(test_post), params: {comment: comment_param }
      end.to change(Comment, :count).by(1)
    end

    it "render to the created comment" do
      post post_comments_url(test_post),
        params: {comment: comment_param}, xhr: true
      expect(response).to render_template('comments/create')
    end
  end

  describe "DELETE /destroy" do

    it "delete a comment" do
      comment = create(:comment, user_id: current_user.id, post_id: test_post.id)
      expect {
        delete comment_url(comment), xhr: true
      }.to change(Comment, :count).by(-1) 
    end

    it "remove comment" do
      comment = create(:comment, user_id: current_user.id, post_id: test_post.id)
      delete comment_url(comment), xhr: true
      expect(response).to be_successful
    end
  end
end
