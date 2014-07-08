require 'rails_helper'

describe 'Posts' do
  context 'with no posts' do
    it 'displays no posts on homepage' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
    end

    it 'prompts to create a new post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'New post'
    end

    it 'display a link to create a new post' do
      visit '/posts'
      click_link 'New post'
      expect(current_path).to eq '/posts/new'
      expect(page).to have_content 'Create a post'
    end
  end

  context 'with images' do
    before do
      Post.create title: 'First post', description: 'My first post', image: File.new(Rails.root + 'spec/images/bohey_dulang.jpg')
    end

    it 'displays the posts on homepage' do
      visit '/posts'
      expect(page).to have_css 'img.uploaded-pic'
    end

    it 'adds a new post without image' do
      visit '/posts/new'
      fill_in 'Title', with: 'First post'
      fill_in 'Description', with: 'My first post'
      # attach_file 'Image', Rails.root.join('spec/images/bohey_dulang.jpg')
      click_button 'Post it!'
      expect(current_path).to eq posts_path
      expect(page).to have_content 'Errors'
    end

    it 'can add a photo to post' do
      visit '/posts/new'
      fill_in 'Title', with: 'First post'
      fill_in 'Description', with: 'My first post' 
      attach_file 'Image', Rails.root.join('spec/images/bohey_dulang.jpg')
      click_button 'Post it!'
      expect(current_path).to eq posts_path
      expect(page).to have_css 'img.uploaded-pic'
    end 
  end
end