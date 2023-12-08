# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @commentable = find_commentable
    @comment = @commentable.comments.build
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to url_for(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable

    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to url_for(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to url_for(@commentable), alert: t('errors.messages.unauthorized') }
        format.json { head :no_content }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    if params[:report_id]
      Report.find(params[:report_id])
    elsif params[:book_id]
      Book.find(params[:book_id])
    end
  end
end
