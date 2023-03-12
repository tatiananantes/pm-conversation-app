require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe '#owner?' do
    let!(:user) { User.create(email: 'john@example.com', password: 'password') }
    let(:project) { Project.create(name: 'Test Project', user: user) }
    let(:comment) { Comment.create(body: 'Test Comment', user: user, project: project) }

   
      context 'when the comment belongs to the user' do
        it 'returns true' do
          expect(comment.owner?(user)).to be true
        end
      end

      context 'when the comment does not belong to the user' do
        let(:other_user) { User.create(email: 'pepe@example.com', password: 'password122') }

        it 'returns false' do
          expect(comment.owner?(other_user)).to be false
        end
      end
    end
  end