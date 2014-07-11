require 'rails_helper'

describe 'tagging posts' do
  context 'when logged in' do
    let!(:alex) { User.create(email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678') }
    before do
      login_as alex
    end

    it 'can add tags to a post' do
      visit '/posts/new'
      fill_in 'Title', with: 'First post'
      fill_in 'Description', with: 'My first post' 
      fill_in 'Tag', with: '#yolo, #swag'
      attach_file 'Image', Rails.root.join('spec/images/bohey_dulang.jpg')
      click_button 'Post it!'
      expect(current_path).to eq posts_path
      expect(page).to have_link '#yolo'
      expect(page).to have_link '#swag'
    end

    it 'should filter posts by selected tags' do
      alex.posts.create title: 'First post', tag_names: 'yolo', image: File.new(Rails.root + 'spec/images/bohey_dulang.jpg')
      alex.posts.create title: 'Second post', tag_names: 'swag', image: File.new(Rails.root + 'spec/images/bohey_dulang.jpg')
      visit '/posts'
      click_link 'yolo'
      expect(page).to have_css 'h1', 'Posts associated with yolo'
      expect(page).to have_content 'First post'
      expect(page).not_to have_content 'Second post'
    end
  end
end