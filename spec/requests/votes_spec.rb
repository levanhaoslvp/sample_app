require 'rails_helper'

RSpec.describe "Votes", type: :request do

  let(:current_user){ create(:user)}

  let(:test_post){ create(:post, user: current_user)}

  let(:comment_post){ create(:comment, post_id: test_post.id, user_id: current_user.id)}

  before {sign_in current_user}

  describe "no loggin" do
    before {sign_out current_user}

    context "when like a post" do
      it "redirect to sign-in" do
        post post_votes_url(test_post)
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when like a comment" do
      it "returns http success" do
        post comment_votes_path(comment_post)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "logged" do
    context "when like a post" do
      it "returns http success (POST/craete)" do
        post post_votes_url(test_post), xhr: true
        expect(response).to have_http_status(:success)
        expect(response).to render_template('votes/vote_post')
      end
    end

    context "when like a comment" do
      it "returns http success (POST/create)" do
        post comment_votes_path(comment_post), xhr: true
        expect(response).to have_http_status(:success)
        expect(response).to render_template('votes/vote_comment')
      end
    end

    context "when unlike a post" do
      it "returns http success (DELETE/destroy)" do
        post post_votes_url(test_post), params: {post_id: test_post.id}, xhr: true
        delete post_vote_url(test_post,0), xhr: true
        expect(response).to render_template('votes/vote_post')
        expect(response).to render_template('votes/vote_post')
      end
    end

    context "when unlike a comment" do
      it "returns http success (DELETE/destroy)" do
        delete comment_vote_path(comment_post,0), xhr: true
        expect(response).to have_http_status(:success)
        expect(response).to render_template('votes/vote_comment')
      end
    end
  end
end
