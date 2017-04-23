class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :find_job_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @jobs = case params[:order]
            when 'by_upper_bound'
              Job.published.high.paginate(:page => params[:page], :per_page => 5)
            when 'by_lower_bound'
              Job.published.low.paginate(:page => params[:page], :per_page => 5)
            else
              Job.published.recent.paginate(:page => params[:page], :per_page => 5)
            end
  end

  def show
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to jobs_path
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, notice: "更新职位成功！"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: "删除职位成功！"
  end


  private


    def find_job_and_check_permission
      @job = Job.find(params[:id])

      if current_user != @job.user
        redirect_to root_path, alert: "你没有权限修改！"
      end
    end

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden, :category, :company, :city)
  end

end
