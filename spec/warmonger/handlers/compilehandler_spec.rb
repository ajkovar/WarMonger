# spec needs refactoring.. copyhandler and watcher are now seperate
# classes
require File.join( File.dirname(__FILE__), '..', '..', 'spec_helper' )

describe WarMonger::CompileHandler do

  before :all do
    @source_dir = File.expand_path File.join(File.dirname(__FILE__), '..', '..', 'sandbox', 'source')
    @dest_dir = File.expand_path File.join(File.dirname(__FILE__), '..', '..', 'sandbox', 'dest')
    @source_file = File.join(@source_dir, "foo", "bar", "SomeClass.java")
    @dest_file = File.join(@dest_dir, "foo", "bar", "SomeClass.class")
  end

  before :each do
    File.delete(@dest_file) if File.exist? @dest_file
    FileUtils.touch(@source_file) if not File.exist? @source_file
    @compile_handler = WarMonger::CompileHandler.new(@source_dir, @dest_dir)
  end
  
  describe "handle_new" do
    it "should compile new files to target directory" do
      File.exist?(@dest_file).should == false
      @compile_handler.handle_new @source_file
      File.exist?(@dest_file).should == true
    end
  end

  describe "handle_update" do
    it "should recompile updated files" do
      FileUtils.touch @dest_file
      mtime = File.mtime(@dest_file)
      sleep(1)
      @compile_handler.handle_update @source_file
      mtime.should_not == File.mtime(@dest_file)
    end
  end

  describe "handle_remove" do
    it "should remove compiled versions of deleted files" do
      FileUtils.touch @dest_file
      File.exist?(@dest_file).should == true
      @compile_handler.handle_remove @source_file
      File.exist?(@dest_file).should == false
    end
  end
    
  describe "classpaths" do
    it "should allow you to specify a classpath to compile against" do
      source_file = File.join(@source_dir, "foo", "bar", "SomeClassWithADependancy.java")
      dest_file = File.join(@dest_dir, "foo", "bar", "SomeClassWithADependancy.class")
      classpath = File.join(@source_dir, "lib", "*.jar")
      File.delete(dest_file) if File.exist? dest_file

      # should fail to compile if classpath hasn't been added yet
      @compile_handler.compile source_file
      File.exist?(dest_file).should == false

      # add classpath and try again and it should work
      @compile_handler.add_classpath classpath
      @compile_handler.compile source_file
      File.exist?(dest_file).should == true
      
    end
  end
  
end
