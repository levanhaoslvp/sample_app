require 'rails_helper'

describe GetDataService do
  let(:current_user) { create(:user)}
  let(:user_follow) { create(:user, email: "followtests@gamil.com", name: "Mr.Follow")}
  let(:post_test) { create(:post, user: current_user)}
  let(:follower) {User.follower_a_month_ago(current_user)}
  let(:following) {User.following_a_month_ago(current_user)}
  let(:data) do
    GetDataService.new(current_user)
  end
  describe 'Get data service' do
    before(:each) do
      user_follow.follow(current_user)
      current_user.follow(user_follow)
    end

    it "should return all posts by current_user" do
      expect(data.post_a_month).to include(post_test)
    end

    it "should return all follower by current_user" do
      expect(data.follower_a_month).to include(user_follow)
    end

    it "should return all posts by current_user" do
      expect(data.following_a_month).to include(user_follow)
    end
  end
end