require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end

  describe 'default values' do
    let!(:user) { User.create(email: 'john@example.com', password: 'password') }
    let!(:project) { user.projects.create(name: 'Test Project') }

    it 'sets default status to "created"' do
      expect(project.status).to eq('created')
    end
  end

  describe 'enums' do
    let(:project) { Project.new }

    it 'defines the "status" enum' do
      expect(Project.statuses).to eq({
                                       'created' => 'Created',
                                       'in_progress' => 'In Progress',
                                       'completed' => 'Completed',
                                       'stalled' => 'Stalled'
                                     })
    end
  end

  describe '#owner?' do
    let!(:user) { User.create(email: 'pepe@example.com', password: 'password') }
    let(:project) { Project.create(name: 'Test Project', user: user) }
    
    context 'when the user owns the project' do
      it 'returns true' do
        expect(project.owner?(user)).to be true
      end
    end

    context 'when the user does not own the project' do
      let!(:other_user) { User.create(email: 'mary@example.com', password: 'password') }

      it 'returns false' do
        expect(project.owner?(other_user)).to be false
      end
    end
  end
end
