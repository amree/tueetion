namespace :bill do
  desc "Generate all Bills for active students"
  task :create_all => :environment do

    Student.active.each do |student|
      Resque.enqueue(BillCreatorWorker, student.id)
    end
  end
end
