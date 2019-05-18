class MainController < ApplicationController
  before_action :set_setting, only: [:set, :share_set, :brst]
  before_action :valid_setting, only: [:share_set, :brst]

  def set
  end

  def share_set
    @url = "https://www.toriaezu-brasto.tk#{brst_path}?problem=#{@setting.problem}&limit_time=#{@setting.limit_time}"
  end

  def brst
    @answers = []
    @setting.limit_time = @setting.limit_time.to_i * 60 * 1000
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
    def setting_params
      params.permit(:problem, :limit_time).each { |key, value| value.gsub!(/(^[[:space:]]+)|([[:space:]]+$)/, '') }
    end

    def set_setting
      @setting = Setting.new(setting_params)
    end

    def valid_setting
      render :set if @setting.invalid?
    end
end
