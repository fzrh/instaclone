require 'rails_helper'

describe 'tagging posts' do
  context 'when logged in' do
    before do
      alex = User.create(email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678')
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
  end
end