
module WarMonger
  class CopyHandler

    def initialize source_directory, target_directory
      @source_directory, @target_directory = File.expand_path(source_directory), File.expand_path(target_directory)
      # append trailing "/" if not present
      last_char_of = lambda { |str| str[str.length-1].chr }
      @source_directory+="/" if last_char_of.call(@source_directory)!="/"
      @target_directory+="/" if last_char_of.call(@target_directory)!="/"
      @matches = 
    end

    def handle_remove source_path
      target_path = get_target_path source_path
      FileUtils.rm target_path
    end

    def handle_new source_path
      target_path = get_target_path source_path
      FileUtils.cp source_path, target_path
    end

    def handle_update source_path
      target_path = get_target_path source_path
      FileUtils.cp source_path, target_path
    end

    def get_target_path source_path
      relative_path = source_path[@source_directory.length, source_path.length-1]
      @target_directory + relative_path
    end

  end
end
