require 'rails_helper'

RSpec.describe Post, type: :model do
  
  current_user = User.create(email: 'fake@example.com',
    password: 'password12',password_confirmation: 'password12',confirmed_at: Time.now)
  
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
    post = build(:post_no_title)
    post.user = current_user
    expect(post).to_not be_valid

    post.title = 'Has a title'
    expect(post).to be_valid
  end

  it 'has a content' do
    post = build(:post_no_content)
    post.user = current_user
    expect(post).to_not be_valid

    post.content = 'Has a title'
    expect(post).to be_valid
  end

  it 'has a title at least 2 characters long' do
    post = build(:post)
    post.user = current_user
    post.title = '1'
    expect(post).to_not be_valid

    post.title = '12'
    expect(post).to be_valid
  end

  it 'has a content between 5 and 100 characters' do
    post = build(:post)
    post.user = current_user
    post.content = '1234'
    expect(post).to_not be_valid

    post.content = '12345'
    expect(post).to be_valid

    hundred_char_string = '123456789 123456789 123456789 123456789 123456789 123456789 123456789'+
      ' 123456789 123456789 0123456789'
    post.content = hundred_char_string
    expect(post).to be_valid

    post.content = hundred_char_string + '1'
    expect(post).to_not be_valid
  end

  it 'has a image' do
    post = build(:post_no_image)
    post.user = current_user
    expect(post).to be_valid

    post.image = 'https://vcdn-thethao.vnecdn.net/2021/06/20/1-2426-1624149210.jpg'
    expect(post).to be_valid
  end
  
end
