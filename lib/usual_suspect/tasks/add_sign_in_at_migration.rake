namespace :usual_suspect do
  desc "Generate a migration for sign_in_at fields"
  task :generate_migration => :environment do
    require 'rails/generators'
    require 'rails/generators/migration'

    class UsualSuspectMigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def create_migration_file
        migration_template "create_sign_in_at_migration.rb.erb", "db/migrate/add_sign_in_at_to_users.rb"
      end

      def self.source_root
        File.expand_path("templates", __dir__)
      end
    end

    UsualSuspectMigrationGenerator.start
  end
end
