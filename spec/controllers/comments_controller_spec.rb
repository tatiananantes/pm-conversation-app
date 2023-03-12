require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { User.create(email: 'john@example.com', password: 'password') }
  let!(:project) { user.projects.create(name: 'Test Project') }
  let!(:comment) { project.comments.create(user: user, body: 'Test comment') }

  before do
    sign_in user
    get :index, params: { project_id: project.id }
  end

  describe 'GET #index' do
    it 'returns 200 status code' do
        expect(response.status).to eq(200)
    end
    
    it 'assigns the comments for the project' do
      expect(comment.project).to eq(project)
      expect(project.comments).to include(comment)
    end
  end


  describe 'POST #create' do
    let(:valid_params) { { comment: { body: 'New comment' }, project_id: project.id } }
    let(:invalid_params) { { comment: { body: '' }, project_id: project.id } }

    context 'with valid params' do
      it 'creates a new comment' do
        expect do
          post :create, params: valid_params
        end.to change { Comment.count }.by(1)
      end

      it 'redirects to the project page' do
        post :create, params: valid_params
        expect(response).to redirect_to(project_url(project))
      end
    end

    context 'with invalid params' do
      it 'does not create a new comment' do
        expect do
          post :create, params: invalid_params
        end.not_to change { Comment.count }
      end
    end
  end

  describe 'PATCH #update' do
    let(:updated_comment) { { body: 'Updated comment' } }

    before do
      sign_in user
      patch :update, params: { project_id: project.id, id: comment.id, comment: updated_comment }
    end

    it 'updates the comment' do
      expect(comment.reload.body).to eq('Updated comment')
    end

    it 'redirects to the project' do
      expect(response).to redirect_to(project_path(project))
    end

    it 'sets a flash notice message' do
      expect(flash[:notice]).to eq('Comment was successfully updated.')
    end
  end

end
