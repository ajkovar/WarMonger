require File.join( File.dirname(__FILE__), '..', 'spec_helper' )

describe WarMonger::Project do
    
  describe "initialize" do
    describe "default assumptions based on project root" do
      before :each do
        @project_root = project_root = File.join("foo", "bar")
        @project = WarMonger::Project.new do
          root project_root
        end
      end
      
      it "should figure out the webroot" do
        @project.webroot.should == File.join(@project_root, "WebRoot")
      end

      it "should figure out the source directory" do
        @project.src.should == File.join(@project_root, "src")
      end

      it "should figure out the lib dir" do
        @project.lib.should == File.join(@project_root, "WebRoot", "WEB-INF", "lib")
      end
    end

    describe "default assumptions based on project root" do
      before :each do
        @deploy_dir = deploy_dir = File.join("foo", "bar")
        @project = WarMonger::Project.new do
          deploy_to deploy_dir
        end
      end

      it "should figure out compile_target" do
        @project.compile_target.should == File.join(@deploy_dir, "WEB-INF", "classes")
      end
    end
        
  end
end

