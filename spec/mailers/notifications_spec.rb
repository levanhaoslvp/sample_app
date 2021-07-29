require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe "notify" do
    let(:mail) { NotificationsMailer.send_notification(user).deliver_now }
    let(:user) {create(:user)}

    it 'sends an email' do
      expect { NotificationsMailer.send_notification(user).deliver_now }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "renders the headers" do
      expect(mail.subject).to eq("you just got a new notification")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end
    
    it "renders the body" do
        expect(mail.body.encoded).to match("#{user.email}, you just got a new notification")
      end
    end
end
