module ObjectCreators

    def create_user(params = {})
      last_id = User.limit(1).order(id: :desc).pluck(:id).first || 0
      user = User.new(
        email: "testtest"+last_id.to_s+"@test.com",
        password: 'testtest',
        password_confirmation: 'testtest',
        provider: nil
      )
      user.skip_confirmation!
      user.save!
      user
    end
  end
  
  RSpec.configure do |config|
    config.include ObjectCreators
  end
  