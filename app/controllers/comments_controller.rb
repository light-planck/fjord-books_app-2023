class CommentsController < ApplicationController
  def new
    @report = Report.find(params[:report_id])
    @comment = @report.comments.build
  end

  def create
    @report = Report.find(params[:report_id])
    @comment = @report.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
