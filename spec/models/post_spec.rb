require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'creation of post' do

    before do
      @post = Post.create(date: Time.now, rationale: 'anything')
    end
    it 'can be created' do

      expect(@post).to be_valid
    end

    it 'can not be created without a date and rationale' do
      @post.date = ' '
      @post.rationale = nil
      expect(@post).to_not be_valid
    end
  end
end
