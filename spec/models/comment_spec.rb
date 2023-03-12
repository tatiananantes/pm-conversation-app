RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe 'methods' do
    let(:user) { User.create(email: 'john@example.com', password: 'password') }
    let(:project) { user.projects.create(name: 'Test Project') }
    let(:comment) { Comment.create(user: user, project: project, body: 'Test comment') }

    describe '#owner?' do
      context 'when the comment belongs to the user' do
        it 'returns true' do
          expect(comment.owner?(user)).to be true
        end
      end

      context 'when the comment does not belong to the user' do
        let(:other_user) { User.create(email: 'jane@example.com', password: 'password') }
        let(:other_project) { other_user.projects.create(name: 'Other Test Project') }
        let(:other_comment) { Comment.create(user: other_user, project: other_project, body: 'Other Test comment') }

        it 'returns false' do
          expect(other_comment.owner?(user)).to be false
        end
      end
    end
  end
end