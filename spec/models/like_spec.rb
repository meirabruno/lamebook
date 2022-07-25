# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { build(:like) }

  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
end
