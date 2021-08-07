require 'rails_helper'

describe ExportCsvService do
  let(:current_user) { create(:user)}
  let(:user_follow) { create(:user, email: "followtests@gamil.com", name: "Mr.Follow")}
  let(:follower) {User.follower_a_month_ago(current_user)}
  let(:following) {User.following_a_month_ago(current_user)}
  let(:csv_post) do
    ExportCsvService.new(current_user.posts, Post::CSV_ATT).perform
  end
  let(:csv_follower) do
    ExportCsvService.new(follower, User::CSV_ATT).perform
  end
  let(:csv_following) do
    ExportCsvService.new(following, User::CSV_ATT).perform
  end

  describe 'Export csv service' do
    before(:each) do
        user_follow.follow(current_user)
        current_user.follow(user_follow)
    end

    it "should include header file user_post.csv" do
      expect(csv_post).to include("content")
      expect(csv_post).to include("created_at")
    end

    it "should include content file user_post.csv" do
      create(:post, user: current_user)
      expect(csv_post).to include("my content")
    end

    it "should include header file user_follower.csv" do
      expect(csv_follower).to include("name")
      expect(csv_follower).to include("created_at")
    end

    it "should include content file user_follower.csv" do
      expect(csv_follower).to include("Mr.Follow")
    end

    it "should include header file user_following.csv" do
      expect(csv_following).to include("name")
      expect(csv_following).to include("created_at") 
    end

    it "should include content file user_following.csv" do
      expect(csv_following).to include("Mr.Follow")
    end
  end
end
