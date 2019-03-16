class MainController < ApplicationController
  def top
    render layout: 'layout_top'
  end

  def set
    @setting = Setting.new
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
  end

  def result
    @problem = params[:problem]
    @answers = params[:answers]
    @answers = [] if @answers.blank?
  end

  private
    def params_setting
      params.require(:setting).permit(:problem, :limit_time)
    end
end
