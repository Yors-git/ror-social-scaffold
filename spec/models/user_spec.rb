require 'rails_helper'

RSpec.describe 'User', type: :model do
  let(:user) { User.create(name: 'rspec', email: 'rspec@test.com', password: '123456') }
  let(:inv_user) { User.create(name: '', email: 'rspec@test.com', password: '123456') }
  let(:posts) { User.reflect_on_association(:posts).macro }
  let(:comments) { User.reflect_on_association(:comments).macro }
  let(:likes) { User.reflect_on_association(:likes).macro }
  let(:friends) { User.reflect_on_association(:friends).macro }
  let(:pending_friends) { User.reflect_on_association(:pending_friends).macro }
  let(:friend_requests) { User.reflect_on_association(:friend_requests).macro }

  it 'checks if creating user is correct' do
    expect(user).to be_valid
  end

  it 'check user name validation' do
    expect(inv_user).to_not be_valid
  end

  it 'check correct association between posts and user' do
    expect(posts).to eq(:has_many)
  end

  it 'check correct association between comments and user' do
    expect(comments).to eq(:has_many)
  end

  it 'check correct association between likes and user' do
    expect(likes).to eq(:has_many)
  end

  it 'check correct association between friendships and user' do
    expect(friends).to eq(:has_many)
  end

  it 'check correct association between inverse_friendships and user ' do
    expect(pending_friends).to eq(:has_many)
  end

  it 'check correct association between inverse_friendships and user ' do
    expect(friend_requests).to eq(:has_many)
  end
end
