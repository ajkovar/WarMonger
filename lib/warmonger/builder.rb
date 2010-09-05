require "rubygems"
require "fssm"

module WarMonger
  class Builder
    attr_accessor :source_directory, :target_directory
    
    def initialize source_directory, target_directory
      @source_directory, @target_directory = File.expand_path(source_directory), File.expand_path(target_directory)
      # append trailing "/" if not present
      @source_directory+="/" if last_char_of(@source_directory)!="/"
      @target_directory+="/" if last_char_of(@target_directory)!="/"
    end

    def watch_for_changes
      puts "starting directory watching.."
      builder = self

      # normalize some api strangeness
      get_file_name = lambda { |base, relative| (base + relative).chomp("/") }

      FSSM.monitor(@source_directory) do
        update do |base, relative|
          puts "update"
          updated_file = get_file_name.call base, relative
          builder.copy_file updated_file
        end
        delete do |base, relative|
          puts "delete"
          updated_file = get_file_name.call base, relative
          builder.remove_file updated_file
        end
        create do |base, relative|
          puts "create"
          updated_file = get_file_name.call base, relative
          builder.copy_file updated_file
        end
      end
      puts "\nDone watching directory."
    end

    def get_target_path source_path
      relative_path = source_path[@source_directory.length, source_path.length-1]
      @target_directory + relative_path
    end

    def remove_file source_path
      target_path = get_target_path source_path
      FileUtils.rm target_path
    end

    def copy_file source_path
      target_path = get_target_path source_path
      FileUtils.cp source_path, target_path
    end

    private

    def last_char_of str
      str[str.length-1].chr
    end

  end
end
