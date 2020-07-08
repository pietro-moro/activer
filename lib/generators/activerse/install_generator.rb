require 'rails/generators/base'

module Activerse
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates an activerse initializer in your application configs directory"

      def copy_templates
        template "activerse.rb", "config/initializers/activerse.rb"
        template "structure.yml", "config/activerse_structure.yml"
      end

      def update_git
        return unless Dir.exists? ".git"
        if File.exists? "config/credentials.enc.yml"
          git rm: "--cached config/credentials.enc.yml"
        end

        append_to_file ".gitignore", <<-GIT
        # Ignore credentials file (Activerse)
        config/master.key
        config/credentials.enc.yml
        GIT
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
