require 'rails_helper'

RSpec.describe 'Post', type: :model do
  let(:user1) { User.create(name: 'RSpec', email: 'rspec@test.com', password: '123456') }
  let(:post) { Post.create(user_id: user1.id, content: 'test post content por Rspec') }
  let(:inv_post) { Post.create(user_id: user1.id, content: '') }
  let(:user) { Post.reflect_on_association(:user).macro }
  let(:comments) { User.reflect_on_association(:comments).macro }
  let(:likes) { User.reflect_on_association(:likes).macro }

  it 'checks if creating post is correct' do
    expect(post).to be_valid
  end

  it 'check user name validation' do
    expect(inv_post).to_not be_valid
  end

  it 'check correct association between posts and user' do
    expect(user).to eq(:belongs_to)
  end

  it 'check correct association between comments and user' do
    expect(comments).to eq(:has_many)
  end

  it 'check correct association between likes and user' do
    expect(likes).to eq(:has_many)
  end
end