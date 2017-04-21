class WelcomeController < ApplicationController
  def index
  end

  def grow
      @jobs = case params[:order]
      when 'by_lower_bound'
        Job.published.where(:category => "成长群").order('wage_lower_bound DESC').paginate(:page => params[:page], per_page => 10)
      when 'by_upper_bound'
        Job.published.where(:category => "成长群").order('wage_upper_bound DESC').paginate(:page => params[:page], per_page => 10)
      else
        Job.published.where(:category => "成长群").recent.paginate(:page => params[:page], :per_page => 10)
      end
    end

    def study
      @jobs = case params[:order]
      when 'by_lower_bound'
        Job.published.where(:category => "学习群").order('wage_lower_bound DESC').paginate(:page => params[:page], per_page => 10)
      when 'by_upper_bound'
        Job.published.where(:category => "学习群").order('wage_upper_bound DESC').paginate(:page => params[:page], per_page => 10)
      else
        Job.published.where(:category => "学习群").recent.paginate(:page => params[:page], :per_page => 10)
      end
    end

    def cognitive
      @jobs = case params[:order]
      when 'by_lower_bound'
        Job.published.where(:category => "认知群").order('wage_lower_bound DESC').paginate(:page => params[:page], per_page => 10)
      when 'by_upper_bound'
        Job.published.where(:category => "认知群").order('wage_upper_bound DESC').paginate(:page => params[:page], per_page => 10)
      else
        Job.published.where(:category => "认知群").recent.paginate(:page => params[:page], :per_page => 10)
      end
    end


end
