require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  let(:user1) { User.create(name: 'RSpec', email: 'rspec@test.com', password: '123456') }
  let(:post1) { Post.create(user_id: user1.id, content: 'test post content por Rspec') }
  let(:comment) { Comment.create(user_id: user1.id, post_id: post1.id, content: 'test comment content por Rspec') }
  let(:inv_comment) { Comment.create(user_id: user1.id, post_id: post1.id, content: '') }
  let(:user) { Comment.reflect_on_association(:user).macro }
  let(:post) { Comment.reflect_on_association(:post).macro }

  it 'checks if creating comment is correct' do
    expect(comment).to be_valid
  end

  it 'check comment content validation' do
    expect(inv_comment).to_not be_valid
  end

  it 'check correct association between user and comments' do
    expect(user).to eq(:belongs_to)
  end

  it 'check correct association between post and comments' do
    expect(post).to eq(:belongs_to)
  end
end
