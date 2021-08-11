# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe 'Comments', type: :request do
  let(:current_user) { create(:user) }
  let(:other_user) { create(:user, email: "test99@gmsil.com") }
  let(:test_post) { create(:post, user: current_user) }
  let(:post_of_other_user) { create(:post, user: other_user) }

  let(:comment_param) do
    {
      content: 'abcdef',
      post_id: test_post.id,
      user_id: current_user.id
    }
  end

  let(:comment_param_other_user) do
    {
      content: 'abcdef',
      post_id: test_post.id,
      user_id: other_user.id
    }
  end

  let(:invalid_comment_param) do
    {
      post_id: test_post.id,
      user_id: current_user.id
    }
  end

  before {
    current_user.add_role :admin 
    sign_in current_user 
  }

  describe 'no loggin' do
    before { sign_out current_user }

    it 'redirect to sign-in when POST /create' do
      post post_comments_url(test_post), params: { comment: comment_param }
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'redirect to sign-in when DELETE /destroy' do
      comment = create(:comment, user_id: current_user.id, post_id: test_post.id)
      delete comment_url(comment)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe ' logged as admin' do
    context 'with valid parameter (POST/create)' do
      it 'creates a new Comment' do
        expect do
          post post_comments_url(test_post), params: { comment: comment_param }
        end.to change(Comment, :count).by(1)
      end

      it 'render to the created comment' do
        post post_comments_url(test_post),
             params: { comment: comment_param }, xhr: true
        expect(response).to render_template('comments/create')
      end
    end

    context 'with invalid parameter (POST/create)' do
      it 'does not creates a new Comment' do
        expect do
          post post_comments_url(test_post), params: { comment: invalid_comment_param }
        end.to change(Comment, :count).by(0)
      end
    end

    context 'with valid parameter (DELETE /destroy)' do
      it 'delete a comment' do
        comment = create(:comment, user_id: current_user.id, post_id: test_post.id)
        expect do
          delete comment_url(comment), xhr: true
        end.to change(Comment, :count).by(-1)
      end

      it 'delete a comment of other user' do
        comment = create(:comment, user_id: other_user.id, post_id: test_post.id)
        expect do
          delete comment_url(comment), xhr: true
        end.to change(Comment, :count).by(-1)
      end

      it 'renders a successful response' do
        comment = create(:comment, user_id: current_user.id, post_id: test_post.id)
        delete comment_url(comment), xhr: true
        expect(response).to be_successful
      end
    end
  end

  describe ' logged as client' do
    before do
      sign_out current_user
      other_user.add_role :client
      sign_in other_user
    end

    context 'with valid parameter (POST/create)' do
      it 'creates a new Comment' do
        expect do
          post post_comments_url(test_post), params: { comment: comment_param_other_user }
        end.to change(Comment, :count).by(1)
      end

      it 'render to the created comment' do
        post post_comments_url(test_post),
             params: { comment: comment_param_other_user }, xhr: true
        expect(response).to render_template('comments/create')
      end
    end

    context 'with invalid parameter (POST/create)' do
      it 'does not creates a new Comment' do
        expect do
          post post_comments_url(post_of_other_user), params: { comment: invalid_comment_param, user_id: other_user.id }
        end.to change(Comment, :count).by(0)
      end
    end

    context 'with valid parameter (DELETE /destroy)' do
      it 'delete a comment' do
        comment = create(:comment, user_id: other_user.id, post_id: test_post.id)
        expect do
          delete comment_url(comment), xhr: true
        end.to change(Comment, :count).by(-1)
      end

      it 'cant delete a comment of other user' do
        comment = create(:comment, user_id: other_user.id, post_id: test_post.id)
        expect do
          delete comment_url(comment), xhr: true
        end.to change(Comment, :count).by(-1)
      end

      it 'renders a successful response' do
        comment = create(:comment, user_id: other_user.id, post_id: test_post.id)
        delete comment_url(comment), xhr: true
        expect(response).to be_successful
      end
    end
  end
end
