require 'rails_helper'

RSpec.describe Comment, type: :model do
  current_user = User.create(email: 'fake@example.com',
    password: 'password12',password_confirmation: 'password12',confirmed_at: Time.now)
  
  let(:post_test) {
    Post.new(:title => "post test", :content => "hello ",
       :user_id => current_user.id, :created_at => DateTime.now, :image => "path" )
  }
  
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe "Validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:post) }
    it { should validate_presence_of(:content) }
  end

  it "has a content" do
    comment = build(:comment_no_content)
    comment.post = post_test
    comment.user = current_user
    expect(comment).to_not be_valid

    comment.content = "my comment"
    expect(comment).to be_valid
  end

  it "has a post" do
    comment = build(:comment)
    comment.user = current_user
    expect(comment).to_not be_valid

    comment.post = post_test
    expect(comment).to be_valid
  end

  it "has a user" do
    comment = build(:comment)
    comment.post = post_test
    expect(comment).to_not be_valid

    comment.user = current_user
    expect(comment).to be_valid
  end
end
