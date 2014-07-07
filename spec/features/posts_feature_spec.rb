require 'rails_helper'

describe 'Posts' do
  context 'no posts' do
    it 'displays no posts' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
    end

    it 'prompts to create a new post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'New post'
    end

    it 'create a post' do
      visit '/posts'
      click_link 'New post'
      expect(current_path).to eq '/posts/new'
      expect(page).to have_content 'Create a post'
    end
  end

  context 'with posts' do
    before { Post.create(title: 'First post', description: 'My first post') }

    it 'displays the posts' do
      visit '/posts'
      expect(page).to have_content 'First post'
    end
    
    it 'can display post with image' do

    end
  end
end