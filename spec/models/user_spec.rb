require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  let!(:user1) {create :user}
  let!(:user2) {create :user}
  let!(:user3) {create :user}

  describe '.find_match' do
    it "should get matches" do
    match = user.find_match

    expect(match[0]).to include(user1.email)
    end
  end
end
