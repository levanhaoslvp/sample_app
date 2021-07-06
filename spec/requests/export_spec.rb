require 'rails_helper'

RSpec.describe "Exports", type: :request do
  let(:current_user){ create(:user)}

  before {sign_in current_user}

  describe 'no loggin' do
    before {sign_out current_user}

    it 'redirect to sign-in when GET /index' do 
      get export_index_url()
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe ' logged ' do
    it 'returns success if request format is CSV' do 
      get export_index_url(format: :csv, user_id: current_user.id)
      expect(response).to have_http_status(:success)
      expect(response.header['Content-Type']).to include 'application/zip'
    end
  end
end
