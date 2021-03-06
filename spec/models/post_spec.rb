require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let(:current_user){ create(:user)}
  
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:title) }
  end

  it 'has a user' do
    post = build(:post)
    expect(post).to_not be_valid

    post.user = current_user
    expect(post).to be_valid
  end

  it 'has a title' do
    post = build(:post_no_title, user: current_user)
    expect(post).to_not be_valid

    post.title = 'Has a title'
    expect(post).to be_valid
  end

  it 'has a content' do
    post = build(:post_no_content, user: current_user)
    expect(post).to_not be_valid

    post.content = 'Has a title'
    expect(post).to be_valid
  end

  it 'has a title at least 2 characters long' do
    post = build(:post, title: '1', user: current_user)
    expect(post).to_not be_valid

    post.title = '12'
    expect(post).to be_valid
  end

  it 'has a content between 5 and 100 characters' do
    post = build(:post, content: '1234', user: current_user)
    expect(post).to_not be_valid

    post.content = '12345'
    expect(post).to be_valid

    hundred_char_string = '123456789 123456789 123456789 123456789 123456789 '+
    '123456789 123456789 123456789 123456789 123456789 '
    post.content = hundred_char_string
    expect(post).to be_valid

    post.content = hundred_char_string + '1'
    expect(post).to_not be_valid
  end

  it 'has a image' do
    post = build(:post_no_image, user: current_user)
    expect(post).to be_valid

    post.image = 'https://vcdn-thethao.vnecdn.net/2021/06/20/1-2426-1624149210.jpg'
    expect(post).to be_valid
  end
  
end
