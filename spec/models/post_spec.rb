require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'creation of post' do

    before do
      @user = User.create(email: 'user@example.com', password: 'password',
                          password_confirmation: 'password', first_name: 'Jon',
                          last_name: 'Dow')
      login_as(@user)
      @post = Post.create(date: Time.now, rationale: 'anything', user_id: @user.id)
    end

    it 'can be created' do
      expect(@post).to be_valid
    end

    it 'can not be created without a date and rationale' do
      @post.date = nil
      @post.rationale = nil
      expect(@post).to_not be_valid
    end
  end
end
