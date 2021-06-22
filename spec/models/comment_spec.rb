require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:current_user){
    create(:user)
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
    comment = build(:comment_no_content,:user => current_user)
    comment.post = create(:post, :user => current_user)
    expect(comment).to_not be_valid

    comment.content = "my comment"
    expect(comment).to be_valid
  end

  it "has a post" do
    comment = build(:comment, :user => current_user)
    expect(comment).to_not be_valid

    comment.post = create(:post, :user => current_user)
    expect(comment).to be_valid
  end

  it "has a user" do
    comment = build(:comment)
    comment.post = create(:post, :user => current_user)
    expect(comment).to_not be_valid

    comment.user = current_user
    expect(comment).to be_valid
  end
end
