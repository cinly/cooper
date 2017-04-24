class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :find_job_and_check_permission, only: [:edit, :update, :destroy, ]
  before_action :validate_search_key, only: [:search]

  def index
    @jobs = case params[:order]
            when 'by_upper_bound'
              Job.published.high.paginate(:page => params[:page], :per_page => 10)
            when 'by_lower_bound'
              Job.published.low.paginate(:page => params[:page], :per_page => 10)
            else
              Job.published.recent.paginate(:page => params[:page], :per_page => 10)
            end
  end

  def show
    @job = Job.find(params[:id])
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

  def grow
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "成长").order('wage_lower_bound DESC').paginate(:page => params[:page], per_page => 10)
    when 'by_upper_bound'
      Job.published.where(:category => "成长").order('wage_upper_bound DESC').paginate(:page => params[:page], per_page => 10)
    else
      Job.published.where(:category => "成长").recent.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def study
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "学习").order('wage_lower_bound DESC').paginate(:page => params[:page], per_page => 10)
    when 'by_upper_bound'
      Job.published.where(:category => "学习").order('wage_upper_bound DESC').paginate(:page => params[:page], per_page => 10)
    else
      Job.published.where(:category => "学习").recent.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def cognitive
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.where(:category => "认知").order('wage_lower_bound DESC').paginate(:page => params[:page], per_page => 10)
    when 'by_upper_bound'
      Job.published.where(:category => "认知").order('wage_upper_bound DESC').paginate(:page => params[:page], per_page => 10)
    else
      Job.published.where(:category => "认知").recent.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def search
    if @query_string.present?
      # 显示符合关键字的公开职位 #
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.published.paginate(:page => params[:page], :per_page => 10 )
      # 随机推荐五个职位 #
    end
  end

  protected

  def validate_search_key
    # 去除特殊字符 #
    @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    # 筛选多个栏位 #
    { :title_or_company_or_city_or_category_cont => query_string }
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
