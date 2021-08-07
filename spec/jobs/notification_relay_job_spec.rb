require 'rails_helper'

RSpec.describe NotificationRelayJob, type: :job do
    let(:current_user){ create(:user) }
    let(:recipient){ create(:user, email: "tests_99@gmail.com") }
    let(:post){ create(:post, user: current_user) }
    let(:noti_test){ create(:notification, recipient: recipient, user: current_user, notifiable: post) }

    before { ActiveJob::Base.queue_adapter = :test }
    describe "#perform_later" do
      it "matches with enqueued job" do
          expect {
            NotificationRelayJob.perform_later
          }.to have_enqueued_job
      end
      it "add job to queue" do
          expect {
            NotificationRelayJob.perform_later
          }.to have_enqueued_job(NotificationRelayJob)
      end

      it "add a new jobs" do
        expect {
          NotificationRelayJob.perform_later
        }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
      end

      it "matches with enqueued job" do
        expect {
          NotificationRelayJob.perform_later(noti_test, 3)
        }.to have_enqueued_job.with(noti_test, 3)
      end
    end

    it "matches with enqueued job" do
      expect {
        NotificationRelayJob.set(:wait_until => Date.tomorrow.noon).perform_later
      }.to have_enqueued_job.at(Date.tomorrow.noon)
    end
end
