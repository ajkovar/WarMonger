
module WarMonger
  class CompileHandler

    def initialize source_directory, target_directory
      @source_directory, @target_directory = File.expand_path(source_directory), File.expand_path(target_directory)
      # append trailing "/" if not present
      last_char_of = lambda { |str| str[str.length-1].chr }
      @source_directory+="/" if last_char_of.call(@source_directory)!="/"
      @target_directory+="/" if last_char_of.call(@target_directory)!="/"
      @classpaths = []
    end

    def handle_remove source_path
      get_target_paths(source_path).each do |path|
        FileUtils.rm path
      end
    end

    def handle_new source_path
      compile source_path
    end

    def handle_update source_path
      compile source_path
    end

    def compile source_path
      command = "javac -d #{@target_directory} "
      if @classpaths.length>0
        command+="-cp #{@classpaths.join(':')} "
      end
      command+=source_path
      puts command
      system command
    end
    
    def add_classpath path
      @classpaths.push(path)
    end

    # finds all paths in the target directory in the same relative
    # location matching FileName* (to select the class and any
    # anonymous inner class files generated
    # TODO figure out how to remove package private class files in the
    # same .java file
    def get_target_paths source_path
      relative_path = source_path[@source_directory.length, source_path.length-1]
      relative_path = relative_path.chomp(File.extname(relative_path)) + "*"
      Dir[@target_directory + relative_path]
    end

  end
end
