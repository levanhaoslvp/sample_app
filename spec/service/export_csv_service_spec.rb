require 'rails_helper'

describe ExportCsvService do
  let(:current_user){ create(:user)}
  let(:test_post){ create(:post, user: current_user)}
  let(:user_follower){ create(:user, email: "followertests@gamil.com", name: "mr follower")}
  let(:user_following){ create(:user, email: "followingtest@gmail.com", name: "mr following")}

  describe 'Export csv service' do
    before(:each) do
        user_follower.follow(current_user)
        current_user.follow(user_following)
    end
    it "export file csv - post" do
      post = current_user.posts
      header = %w(created_at content)
      csv = ExportCsvService.new(post, header).perform
      expect(csv).to include("content")
      expect(csv).to include("created_at")
    end

    it "export file csv - follower" do
      follower = User.follower_a_month_ago(current_user)
      header = %w(name created_at)
      csv = ExportCsvService.new(follower, header).perform
      expect(csv).to include("name")
      expect(csv).to include("created_at")
      expect(csv).to include("mr follower")
    end

    it "export file csv - following" do
      following = User.following_a_month_ago(current_user)
      header = %w(name created_at)
      csv = ExportCsvService.new(following, header).perform
      expect(csv).to include("name")
      expect(csv).to include("created_at")
      expect(csv).to include("mr following")
    end
  end
end
