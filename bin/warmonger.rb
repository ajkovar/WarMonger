$LOAD_PATH << File.join( File.dirname(__FILE__), '..', 'lib' )

require 'warmonger'

source_dir=ARGV[0]
target_dir=ARGV[1]
p source_dir
p target_dir
watcher = WarMonger::FileWatcher.new source_dir
watcher.add_change_handler(:handler => WarMonger::CopyHandler.new(source_dir, target_dir))
watcher.watch
puts "hello"

# process_id= Kernel::fork { @watcher.watch }
# Process.kill("TERM", process_id)
