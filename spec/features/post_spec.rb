require 'rails_helper'

describe 'navigate' do

  before do
    @user = User.create(email: 'test@test.com', password: 'asdfasdf',
                        password_confirmation: 'asdfasdf', first_name: 'Jon',
                        last_name: 'Snow')
    login_as(@user, scope: :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = Post.create(date: Date.today, rationale: 'Post1', user_id: @user.id)
      post2 = Post.create(date: Date.today, rationale: 'Post2', user_id: @user.id)
      visit posts_path
      expect(page).to have_content(/Post1|Post2/)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'it has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale'
      click_on 'Save'

      expect(page).to have_content('Some rationale')
    end

    it 'can not create a post with missing date' do
      post = Post.new(date: nil)
      post.valid?
      expect(post.errors[:date]).to include("can't be blank")
      visit new_post_path
    end

    it 'can not create a post with missing rationale' do
      post = Post.new(rationale: nil)
      post.valid?
      expect(post.errors[:rationale]).to include("can't be blank")
      visit new_post_path
    end

    it 'will have the user associated with it ' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User_Association'
      click_on 'Save'

      expect(User.last.posts.last.rationale).to eq('User_Association')
    end
  end
end
