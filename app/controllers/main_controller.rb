class MainController < ApplicationController
  def top
    @setting = Setting.new
  end

  def terms_of_service
  end

  def privacy_policy
  end

  def run
    @setting = Setting.new(params_setting)
    if @setting.valid?
      @answers = []
      @setting.limit_time = @setting.limit_time.to_i * 60 * 1000
      render layout: 'layout_run'
    else
      render :top
    end
  end

  def add
    @answers = params[:answers]
    @answers = [] if @answers.blank?
    @answers.unshift params[:answer] if params[:answer].present?
  end

  def result
    @problem = params[:problem]
    @answers = params[:answers]
    @answers = [] if @answers.blank?
  end

  def redirect_top
    redirect_to root_path
  end

  private
    def params_setting
      params.require(:setting).permit(:problem, :limit_time)
    end
end
