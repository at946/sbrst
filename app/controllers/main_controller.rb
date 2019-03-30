class MainController < ApplicationController
  def set
    # @setting = Setting.new(params_setting)
    @setting = Setting.new(problem: params[:problem], limit_time: params[:limit_time])
  end

  def brst
    @setting = Setting.new(params_setting)
    @setting.problem.gsub!(/(^[[:space:]]+)|([[:space:]]+$)/, '')
    if @setting.valid?
      @answers = []
      @setting.limit_time = @setting.limit_time.to_i * 60 * 1000
    else
      render :set
    end
  end

  def ks
    @problem = params[:problem]
    @limit_time = params[:limit_time]
    @answers = params[:answers]
    render :brst_fail if @answers.blank?
  end

  def result
    @problem = params[:problem]
    @categories = params[:categories]
    @categories = [] if @categories.blank?
    @answers = params[:answers]
    @answers = [] if @answers.blank?
  end

  def brst_fail
    @problem = params[:problem]
    @limit_time = params[:limit_time]
  end

  private
    def params_setting
      params.require(:setting).permit(:problem, :limit_time)
    end
end
