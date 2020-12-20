require 'rails_helper'

RSpec.describe 'Like', type: :model do
  let(:user1) { User.create(name: 'RSpec', email: 'rspec@test.com', password: '123456') }
  let(:post1) { Post.create(user_id: user1.id, content: 'test post content por Rspec') }
  let(:like) { Like.create(user_id: user1.id, post_id: post1.id) }
  let(:inv_like) { Like.create(user_id: user1.id, post_id: '') }
  let(:user) { Like.reflect_on_association(:user).macro }
  let(:post) { Like.reflect_on_association(:post).macro }

  it 'checks if creating comment is correct' do
    expect(like).to be_valid
  end

  it 'check like validation' do
    expect(inv_like).to_not be_valid
  end

  it 'check correct association between user and likes' do
    expect(user).to eq(:belongs_to)
  end

  it 'check correct association between post and likes' do
    expect(post).to eq(:belongs_to)
  end
end
