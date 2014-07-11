require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:post) {Post.create }

  describe '#tag_names=' do
    describe 'no tags' do
      it 'does nothing' do
        expect { post.tag_names = '' }.not_to raise_error
      end
    end

    describe 'one tag that does not exist' do
      it 'adds a tag to the post' do
        post.tag_names = '#yolo'
        expect(post.tags.length).to eq 1
      end
    end
  end
end
