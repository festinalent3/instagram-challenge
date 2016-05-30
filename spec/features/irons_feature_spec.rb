require 'rails_helper'

feature "User can iron a post" do
  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
    @user = User.find_by(email: 'test@example.com')

    visit '/posts'
    click_link 'New Post'
    fill_in 'Title', with: 'Iron Man Beta'
    attach_file('Image', Rails.root + "spec/fixtures/Iron-Man-Beta.jpg")

    click_button 'Create Post'
    @post = Post.find_by(title: 'Iron Man Beta')

  end

  context "user is on /posts" do
    it "should see an iron link" do
      visit('/posts')
      expect(page).to have_link('Iron')
    end

    it "clicking iron link increases iron count by one" do
      visit('/posts')
      click_link 'Iron'
      expect(@post.irons.count).to eq 1
      expect(@user.irons.count).to eq 1

      expect(page).to have_content('1')

    end

    it "user can only iron a post once" do
      visit('/posts')
      click_link 'Iron'
      expect(@post.irons.count).to eq 1
      expect(@user.irons.count).to eq 1
      click_link 'Iron'
      expect(@user.irons.count).to eq 1
      expect(@post.irons.count).to eq 1
      expect(page).to have_content("you have ironed this post already")

    end
  #
  #   it "submits a comment" do
  #     visit('/posts')
  #     click_link 'Leave Comment'
  #     fill_in 'Name', with: 'User'
  #     fill_in 'Body', with: 'My opinion'
  #     click_button 'Create Comment'
  #     expect(@user.comments.count).to eq 1
  #     expect(@post.comments.count).to eq 1
  #   end
   end
end
