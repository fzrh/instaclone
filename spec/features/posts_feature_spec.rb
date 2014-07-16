require 'rails_helper'

describe 'Posts' do
  it 'displays no posts on homepage' do
    visit '/posts'
    expect(page).to have_content 'No posts yet'
  end

  it 'prompts to create a new post' do
    visit '/posts'
    expect(page).to have_content 'No posts yet'
    expect(page).to have_link 'New post'
  end
end

describe 'Creating posts' do
  context 'when logged out' do
    before do
      alex = User.create email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678'
      alex.posts.create title: 'First post', description: 'My first post', image: File.new(Rails.root + 'spec/images/bohey_dulang.jpg')
    end

    it 'displays the posts on homepage' do
      visit '/posts'
      expect(page).to have_css 'img.uploaded-pic'
    end

    it 'is impossible' do
      visit '/posts'
      click_link 'New post'
      expect(page).to have_content 'Sign in'
      expect(page).not_to have_field 'Title'
    end
  end

  context 'when logged in' do
    before do
      alex = User.create(email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678')
      login_as alex
      # Post.create title: 'First post', description: 'My first post', image: File.new(Rails.root + 'spec/images/bohey_dulang.jpg')
    end

    it 'can add a photo to a post' do
      visit '/posts/new'
      fill_in 'Title', with: 'First post'
      fill_in 'Description', with: 'My first post' 
      attach_file 'Image', Rails.root.join('spec/images/bohey_dulang.jpg')
      click_button 'Post it!'
      expect(current_path).to eq posts_path
      expect(page).to have_content 'Posted by: alex@alex.com'
      expect(page).to have_css 'img.uploaded-pic'
    end

    it 'cannot adds a new post without an image' do
      visit '/posts/new'
      fill_in 'Title', with: 'First post'
      fill_in 'Description', with: 'My first post'
      click_button 'Post it!'
      expect(current_path).to eq posts_path
      expect(page).to have_content 'Errors'
    end

    it 'can add an address to a post' do
      visit '/posts/new'
      fill_in 'Title', with: 'First post' 
      attach_file 'Image', Rails.root.join('spec/images/bohey_dulang.jpg')
      fill_in 'Address', with: '25 City Road, London'
      click_button 'Post it!'
      expect(current_path).to eq posts_path
      expect(page).to have_content 'Posted by: alex@alex.com'
      expect(page).to have_css 'img.uploaded-pic'      
    end

  end
end