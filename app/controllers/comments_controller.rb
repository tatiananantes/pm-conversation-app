class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build
  end

  def edit
  end

  def create
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to project_url(@project), notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to project_url(@project), notice: 'Comment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  def project_comments
    @comments = @project.comments
    render 'index'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :created_at, :updated_at).merge(project_id: params[:project_id])
  end

  def check_user
    return if @comment.owner?(current_user)

    redirect_to @project, alert: "You don't have permission to access this resource."
  end
end
