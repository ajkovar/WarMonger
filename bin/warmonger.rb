$LOAD_PATH << File.join( File.dirname(__FILE__), '..', 'lib' )

require 'warmonger'

source_dir=ARGV[0]
target_dir=ARGV[1]
p source_dir
p target_dir
copier = WarMonger::AutoCopier.new source_dir, target_dir
copier.watch_for_changes
