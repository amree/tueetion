namespace :bill do
  desc "Generate all Bills for active students"
  task :generate_all => :environment do

    Student.active.each do |student|
      Resque.enqueue(BillWorker, student.id)
    end
  end
end
