module WarMonger
  class Project

    attr_accessor :webroot, :src, :lib, :compile_target
    
    def initialize(&block)
      instance_eval(&block) if block_given?
      unless root.nil?
        @webroot ||=  File.join(@root, "WebRoot")
        @src ||= File.join(@root, "src")
        @lib ||= File.join(@root, "WebRoot", "WEB-INF", "lib")
      end
      @compile_target ||= File.join(@deploy_dir, "WEB-INF", "classes") unless @deploy_dir.nil?
    end
    
    def root *params
      return @root if params[0].nil?
      @root = params[0]
    end
    
    def deploy_to *params
      return @deploy_dir if params[0].nil?
      @deploy_dir = params[0]
    end
    
  end
end
# config = ARGV[0] || "config.ru"
# if !File.exist? config
#   abort "configuration #{config} not found"
# end

# if config =~ /\.ru$/
#   cfgfile = File.read(config)
#   if cfgfile[/^#\\(.*)/]
#     opts.parse! $1.split(/\s+/)
#   end
#   inner_app = eval "Rack::Builder.new {( " + cfgfile + "\n )}.to_app",
#                    nil, config
# else
#   require config
#   inner_app = Object.const_get(File.basename(config, '.rb').capitalize)
# end

# WarMonger::Project.new do
#   project_root = "/home/alex/workspace/Floydware"
#   deploy_dir = "/home/alex/JBoss/jboss-4.2.3.GA/server/default/deploy/floydware.war"
# end

# webapp_source_dir="/home/alex/workspace/Floydware/WebRoot"
# webapp_target_dir="/home/alex/JBoss/jboss-4.2.3.GA/server/default/deploy/floydware.war"

# java_source_dir = "/home/alex/workspace/Floydware/src"
# java_target_dir = "/home/alex/JBoss/jboss-4.2.3.GA/server/default/deploy/floydware.war/WEB-INF/classes"

# # watch the web app directory for changes, deploy them as they happen
# webapp_watcher = WarMonger::FileWatcher.new webapp_source_dir
# webapp_watcher.add_change_handler(:handler => WarMonger::CopyHandler.new(webapp_source_dir, webapp_target_dir))
# webapp_watcher_pid = Kernel::fork { webapp_watcher.watch }

# # watch the java source directory for changes
# compile_watcher = WarMonger::FileWatcher.new java_source_dir

# # just copy of files that aren't .java files
# compile_watcher.add_change_handler(:path_exclude_matcher => /.*.java$/, :handler => WarMonger::CopyHandler.new(java_source_dir, java_target_dir))

# # if it is a .java file, compile it to the target directory
# compile_handler = WarMonger::CompileHandler.new(java_source_dir, java_target_dir)
# classpath = File.join(webapp_source_dir, "lib", "*.jar")
# compile_handler.add_classpath classpath
# compile_watcher.add_change_handler(:path_matcher => /.*.java$/, :handler => compile_handler)

# compile_watcher_pid = Kernel::fork { compile_watcher.watch }

# cleanup = lambda { puts "\nbye bye";Process.kill("TERM", compile_watcher_pid); Process.kill("TERM", webapp_watcher_pid);exit}
# trap("KILL") {cleanup.call}
# trap("INT") {cleanup.call}

# while(true) do
#   sleep(1)
# end
