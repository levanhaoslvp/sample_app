# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Applications', type: :request do
  describe 'GET #index' do
    it 'returns a 302 OK status' do
      get '/home'
      expect(response).to have_http_status(200)
    end
  end
end
