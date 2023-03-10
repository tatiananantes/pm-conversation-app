class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_comment, only: %i[ show edit update destroy ]

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

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_url(@project), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def project_comments
    @comments = @project.comments
    render "index"
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
end
