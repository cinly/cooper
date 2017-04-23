class Groups::GrowController < ApplicationController
  def index
      @jobs = case params[:order]
      when 'by_lower_bound'
        Job.published.where(:category => "成长群").order('wage_lower_bound DESC').paginate(:page => params[:page], per_page => 10)
      when 'by_upper_bound'
        Job.published.where(:category => "成长群").order('wage_upper_bound DESC').paginate(:page => params[:page], per_page => 10)
      else
        Job.published.where(:category => "成长群").recent.paginate(:page => params[:page], :per_page => 10)
      end
    end


    private

    def job_params
      params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden, :category, :company, :city)
    end


end
