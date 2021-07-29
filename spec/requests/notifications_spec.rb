require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:current_user){ create(:user) }
  let(:other_user){ create(:user, email: "test99@gmail.com") }
  let(:test_post){ create(:post, user: current_user)}

  before { sign_in current_user}

  describe "no loggin" do
    before {sign_out current_user}

    it "redirect to sign-in when POST /create" do
      post notifications_url(id: current_user.id)
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe " logged " do
    it "renders a successful response when POST /create" do
      post notifications_url(), params: {id: current_user.id}, xhr: true
      expect(response).to render_template("notifications/create")
    end

    it "set viewed for Notification" do
      noti_new = create(:notification, user: other_user, recipient: current_user, notifiable: test_post, viewed: false)
      post notifications_url(), params: {id: current_user.id}, xhr: true
      expect(noti_new.reload.viewed).to eq(true)
    end
  end

end
