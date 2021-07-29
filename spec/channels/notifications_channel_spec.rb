require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  let(:current_user){ create(:user)}
  let(:user){ create(:user, email: "test98@gmail.com")}
  let(:invalid_user){build(:user, email: "test98@gmail.com", id: nil)}
  let(:noti){ create(:notification, user: current_user)}

  describe "have_streams" do
    it "successfully subscribes" do
      stub_connection current_user: current_user
      subscribe
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from("notifications:1")
      expect(subscription.current_user.id).to eq 1
      perform :unsubscribed
      expect(subscription).not_to have_streams
    end

    it "rejects subscribes to user's stream" do
      stub_connection current_user: invalid_user
      subscribe
      expect(subscription).to_not have_stream_from("notifications:1")
    end

    it "raises when no subscription started" do
      stub_connection current_user: current_user
      expect {
        expect(subscription).to have_streams
      }.to raise_error(/Must be subscribed!/)
    end

  end
end
