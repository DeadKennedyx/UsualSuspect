namespace :usual_suspect do
  desc "Generates migration and model for UsualSuspect events"
  task :setup => :environment do
    require 'rails/generators'
    require 'rails/generators/migration'

    class UsualSuspectSetupGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.next_migration_number(dirname)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def create_migration_file
        migration_template "create_usual_suspect_events.rb.erb", "db/migrate/create_usual_suspect_events.rb"
      end

      def create_model_file
        copy_file "usual_suspect_event.rb.erb", "app/models/usual_suspect_event.rb"
      end
    end

    UsualSuspectSetupGenerator.source_root(File.expand_path("../templates", __FILE__))
    UsualSuspectSetupGenerator.start
  end
end

