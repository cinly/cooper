module JobsHelper

  def render_job_status(job)
    if job.is_hidden
      content_tag(:span, "", :class => "fa fa-lock")
    else
      content_tag(:span, "", :class => "fa fa-globe")
    end
  end

  def render_job_category(job)
    if job.category == '成长'
      "fa fa-laptop"
    elsif job.category == '学习'
      "fa fa-tasks"
    elsif job.category == '认知'
      "fa fa-photo"
    elsif job.category == '运营'
      "fa fa-line-chart"
    elsif job.category == '市场'
      "fa fa-pie-chart"
    elsif job.category == '销售'
      "fa fa-cny"
    elsif job.category == '职能'
      "fa fa-paste"
    else
      "fa fa-address-book-o"
    end
  end

  # 薪水区间 #
  def render_job_wage(job)
    "#{job.wage_lower_bound}  ~ #{job.wage_upper_bound} "
  end

  # 判断是否投递过简历icon #
  def render_job_resumes(job)
    if job.resumes.count > 0
      "fa fa-envelope-open-o"
    else
      "fa fa-envelope-o"
    end
  end

end
