require 'rails_helper'

RSpec.describe Notification, type: :model do
    let(:user){ create(:user) }
    let(:recipient){ create(:user, email: "tests_99@gmail.com") }
    let(:post){ create(:post, user: user) }

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
      noti_test = build(:notification, recipient: recipient, user: nil, notifiable: post)
      expect(noti_test).to_not be_valid

      noti_test.user = user
      expect(noti_test).to be_valid
    end

    it "has a recipent" do
      noti_test = build(:notification, user: user, recipient: nil, notifiable: post)
      expect(noti_test).to_not be_valid

      noti_test.recipient = recipient
      expect(noti_test).to be_valid
    end

    it "has a notifiable" do
      noti_test = build(:notification, user: user, recipient: recipient, notifiable: nil)
      expect(noti_test).to_not be_valid

      noti_test.notifiable = post
      expect(noti_test).to be_valid
    end

end
