require 'rails_helper'

describe 'maps' do
  context 'posts with addresses' do
    before do
      alex = User.create email: 'alex@alex.com', password: '12345678', password_confirmation: '12345678'
      login_as alex
      alex.posts.create title: 'First post', description: 'My first post', address: '25 City Road, London', image: File.new(Rails.root + 'spec/images/bohey_dulang.jpg')

    end

    it 'displays a map', js: true do
      visit '/posts'
      click_link 'Map'
      expect(page).to have_map
      # expect(page).to have_css '.gm-style'
    end
  end
end