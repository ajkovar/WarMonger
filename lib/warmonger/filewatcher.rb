require "rubygems"
require "fssm"

module WarMonger
  class FileWatcher
    
    def initialize directory
      @directory = directory
      @handlers = []
    end

    def add_change_handler handler
      @handlers.push handler
    end

    def watch
      puts "starting directory watching.."
      builder = self

      # normalize some api strangeness
      get_file_name = lambda { |base, relative| (base + relative).chomp("/") }

      FSSM.monitor(@directory) do
        update do |base, relative|
          puts "update"
          updated_file = get_file_name.call base, relative
          builder.handle_update updated_file
        end
        delete do |base, relative|
          puts "delete"
          updated_file = get_file_name.call base, relative
          builder.handle_remove updated_file
        end
        create do |base, relative|
          puts "create"
          updated_file = get_file_name.call base, relative
          builder.handle_new updated_file
        end
      end
      puts "\nDone watching directory."
    end

    def handle_remove source_path
      get_handlers_for(source_path) { |h| h.handle_remove source_path; }
    end

    def handle_update source_path
      get_handlers_for(source_path) { |h| h.handle_update(source_path)}
    end

    def handle_new source_path
      get_handlers_for(source_path) { |h| h.handle_new source_path}
    end

    private
    
    def get_handlers_for source_path
      @handlers.each do |h|
        if h[:path_matcher]
          if h[:path_matcher].match(source_path)
            yield h[:handler]
          end
        else
          yield h[:handler]
        end
      end
    end
    
  end
end
