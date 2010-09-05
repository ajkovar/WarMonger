require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

describe WarMonger::Builder do

  before :all do
    @source_dir = File.expand_path File.join(File.dirname(__FILE__), '../sandbox/source')
    @dest_dir = File.expand_path File.join(File.dirname(__FILE__) , '../sandbox/dest')
    @builder = WarMonger::Builder.new @source_dir, @dest_dir
    @process_id= Kernel::fork { @builder.watch_for_changes }
    @source_file = File.join(@source_dir, "file1")
    @dest_file = File.join(@dest_dir, "file1")
    sleep(1)
  end
  
  after :all do
    Process.kill("TERM", @process_id)
  end   

  describe "watch_for_changes" do

    before :each do
      File.delete(@dest_file) if File.exist? @dest_file
      File.delete(@source_file) if File.exist? @source_file
    end
    
    describe "creating new files" do
      it "should copy over new files" do
        File.exist?(@dest_file).should == false
        FileUtils.touch @source_file
        sleep(1)
        File.exist?(@dest_file).should == true
      end
    end

    describe "updating files" do
      it "should copy over updated files" do
        FileUtils.touch @dest_file
        mtime = File.mtime(@dest_file)
        sleep(1)
        FileUtils.touch @source_file
        sleep(1)
        mtime.should_not == File.mtime(@dest_file)
      end
    end

    describe "deleteing files" do
      it "should remove deleted files" do
        FileUtils.touch @source_file
        sleep(1)
        File.exist?(@dest_file).should == true
        FileUtils.rm(@source_file)
        sleep(1)
        File.exist?(@dest_file).should == false
      end
    end
    
    
  end
end
