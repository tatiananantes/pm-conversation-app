require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { User.create(email: 'john@example.com', password: 'password') }
  let!(:project) { user.projects.create(name: 'Test Project', description: "Project Description", status: "Created") }

  before do
    sign_in user
    get :index, params: { project_id: project.id }
  end

  describe 'GET #index' do
    it 'returns 200 status code' do
        expect(response.status).to eq(200)
    end
    it 'assigns the project to all projects' do
      expect(Project.all).to include(project)
    end
  end


  describe 'POST #create' do
    let(:valid_params) { { project: { name: 'New project name', description: "Project Description", status: "Created" } } }
    let(:invalid_params) { { project:  { name: '' } } }

    context 'with valid params' do
      it 'creates a new comment' do
        expect do
          post :create, params: valid_params
        end.to change { Project.count }.by(1)
      end

      it 'redirects to the project page' do
        post :create, params: valid_params
        new_project = Project.last
        expect(response).to redirect_to(project_url(new_project))
      end
    end

    context 'with invalid params' do
      it 'does not create a new comment' do
        expect do
          post :create, params: invalid_params
        end.not_to change { Project.count }
      end
    end
  end

  describe 'PATCH #update' do
    let(:updated_project) { { name: 'update name', description: "update Project Description", status: "Stalled" } }

    before do
      sign_in user
      patch :update, params: { id: project.id, project: updated_project}
    end

    it 'updates the status' do
      expect(project.reload.status).to eq('stalled')
      expect(project.reload.name).to eq('update name')
      expect(project.reload.description).to eq('update Project Description')

    end

    it 'redirects to the project' do
      expect(response).to redirect_to(project_path(project))
    end

    it 'sets a flash notice message' do
      expect(flash[:notice]).to eq('Project was successfully updated.')
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in user
    end
  
    it 'deletes the project' do
      expect do
        delete :destroy, params: { id: project.id }
      end.to change { Project.count }.by(-1)
    end
  
    it 'redirects to the projects index' do
      delete :destroy, params: { id: project.id }
      expect(response).to redirect_to(projects_url)
    end
  
    it 'sets a flash notice message' do
      delete :destroy, params: { id: project.id }
      expect(flash[:notice]).to eq('Project was successfully destroyed.')
    end
  end

end
