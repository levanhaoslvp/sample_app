# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:current_user) { create(:user) }

  describe 'Associations' do
    it { should have_and_belong_to_many(:users) }
  end
end
