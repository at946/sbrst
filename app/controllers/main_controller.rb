class MainController < ApplicationController
  def set
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

  def brst_fail
    @problem = params[:problem]
    @limit_time = params[:limit_time]
  end

  def result
    @problem = params[:problem]
    @limit_time = params[:limit_time]
    @categories = params[:categories].permit!.to_hash
    if params[:answers].present?
      @answers = params[:answers].permit!.to_hash
    else
      render :brst_fail if params[:answers].blank?
    end
  end

  def matome
    @problem = params[:problem]
    @limit_time = params[:limit_time]
    @categories = params[:categories].permit!.to_hash
    @answers = params[:answers].permit!.to_hash
  end

  private
    def params_setting
      params.require(:setting).permit(:problem, :limit_time)
    end
end
