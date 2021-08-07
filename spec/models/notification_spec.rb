require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user){ create(:user) }
  let(:recipient){ create(:user, email: "tests_99@gmail.com") }
  let(:post){ create(:post, user: user) }
  let(:noti_test){ build(:notification, recipient: recipient, user: user, notifiable: post, viewed: false)}

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:notifiable) }
    it { should belong_to(:recipient) }
  end

  describe "Validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:notifiable) }
    it { should validate_presence_of(:recipient) }
  end

  it "has a user" do
    noti = noti_test
    noti.user = nil
    expect(noti).to_not be_valid

    noti.user = user
    expect(noti).to be_valid
  end

  it "has a recipent" do
    noti = noti_test
    noti.recipient = nil
    expect(noti).to_not be_valid

    noti.recipient = recipient
    expect(noti).to be_valid
  end

  it "has a notifiable" do
    noti = noti_test
    noti.notifiable = nil
    expect(noti).to_not be_valid

    noti.notifiable = post
    expect(noti).to be_valid
  end

  it "Update notifications as seen" do
    noti = noti_test
    noti.save
    Notification.update_viewed(recipient)
    expect(noti.reload.viewed).to eq(true)
  end

end
