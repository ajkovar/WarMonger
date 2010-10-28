
module WarMonger
  class CopyHandler

    def initialize source_directory, target_directory
      @source_directory, @target_directory = File.expand_path(source_directory), File.expand_path(target_directory)
      # append trailing "/" if not present
      last_char_of = lambda { |str| str[str.length-1].chr }
      @source_directory+="/" if last_char_of.call(@source_directory)!="/"
      @target_directory+="/" if last_char_of.call(@target_directory)!="/"
    end

    def handle_remove source_path
      target_path = get_target_path source_path
      FileUtils.rm target_path
    end

    def handle_new source_path
      target_path = get_target_path source_path
      sleep 0.2
      system("cp #{source_path} #{target_path}")
      # FileUtils.cp source_path, target_path
    end

    def handle_update source_path
      target_path = get_target_path source_path
      # puts "-----------------------------------------"
      # puts(source_path + " COPIED TO " + target_path)
      # puts source_path
      # puts target_path
      # puts "-----------------------------------------"
      # FileUtils.cp source_path, target_path
      sleep 0.2
      system("cp #{source_path} #{target_path}")
    end

    def get_target_path source_path
      relative_path = source_path[@source_directory.length, source_path.length-1]
      @target_directory + relative_path
    end

    # private

    # def clean_path path
    #   last_char_of = lambda { |str| str[str.length-1].chr }
    #   if last_char_of.call(@source_directory)!="/"
    #     return path+"/" 
    #   elsif
    #     return path
    #   end
    # end
    
  end
end
