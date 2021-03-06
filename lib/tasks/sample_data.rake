require 'faker'

namespace :db do
  desc "Fill database with sample data"

  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    
    # Make an admin user
    admin = User.create!(:name                  => "Admin McAdminerson",
                         :email                 => 'admin@railstutorial.org',
                         :password              => 'sekrit',
                         :password_confirmation => 'sekrit',
                         )
    admin.toggle!(:admin)

    # Make a normal user
    User.create!(:name                  => "Example User",
                 :email                 => 'example@railstutorial.org',
                 :password              => 'foobar',
                 :password_confirmation => 'foobar',
                )

    # Make 99 more normal users
    99.times do |n|
      name     = Faker::Name.name
      email    = "example-#{n+1}@railstutorial.org"
      password = "password"

      User.create!(:name                  => name,
                   :email                 => email,
                   :password              => password,
                   :password_confirmation => password,
                  )
    end
                
  end
end
