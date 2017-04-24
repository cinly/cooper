# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "這個種子檔會自動建立一個admin帳號, 並且創建 5 個 public jobs, 以及10個hidden jobs"

create_account = User.create([email: '123@cc.com', password: '123456', password_confirmation: '123456', is_admin: 'true'])
puts "Admin account created."

create_jobs =
  Job.create!([title: "魔改大赛", description: "无工作经验，小宇宙爆发您就来",category:"成长", wage_upper_bound: rand(50..99)*100, wage_lower_bound: rand(10..49)*100,company: "全栈营", city:"北京", is_hidden: "false"])


create_jobs =
  Job.create!([title: "天天英语", description: "无工作经验，小宇宙爆发您就来",category:"学习", wage_upper_bound: rand(50..99)*100, wage_lower_bound: rand(10..49)*100,company: "新生大学", city:"上海", is_hidden: "false"])


create_jobs =
  Job.create!([title: "极速读书", description: "无工作经验，小宇宙爆发您就来",category:"认知", wage_upper_bound: rand(50..99)*100, wage_lower_bound: rand(10..49)*100,company: "Xdite老师", city:"北京", is_hidden: "false"])


create_jobs =
  Job.create!([title: "口语练习", description: "无工作经验，小宇宙爆发您就来",category:"学习", wage_upper_bound: rand(50..99)*100, wage_lower_bound: rand(10..49)*100,company: "新生大学", city:"上海", is_hidden: "false"])


create_jobs =
  Job.create!([title: "数字力", description: "无工作经验，小宇宙爆发您就来",category:"认知", wage_upper_bound: rand(50..99)*100, wage_lower_bound: rand(10..49)*100,company: "MJ老师", city:"北京", is_hidden: "false"])


create_jobs =
  Job.create!([title: "驴行天下", description: "无工作经验，小宇宙爆发您就来",category:"成长", wage_upper_bound: rand(50..99)*100, wage_lower_bound: rand(10..49)*100,company: "驴友帮", city:"深圳", is_hidden: "false"])

puts "5 Public jobs created."

create_jobs = for i in 1..10 do
  Job.create!([title: "Job no.#{i+10}", description: "這是用種子建立的第 #{i+10} 個Hidden工作", wage_upper_bound: rand(50..99)*100, wage_lower_bound: rand(10..49)*100,is_hidden: "true"])
end
puts "10 Hidden jobs created."
