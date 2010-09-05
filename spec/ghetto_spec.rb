# this spec is ghetto, son
require File.join( File.dirname(__FILE__), 'spec_helper' )

source_dir = File.expand_path File.join(File.dirname(__FILE__), 'sandbox/source')
dest_dir = File.expand_path File.join(File.dirname(__FILE__) , 'sandbox/dest')

builder = WarMonger::Builder.new source_dir, dest_dir
process_id= Kernel::fork { builder.watch_for_changes }

touch_command = 'touch ' + source_dir + "/file"

sleep(1)
system(touch_command) 
sleep(1)
system(touch_command) 
sleep(1)
system(touch_command) 
sleep(1)
system(touch_command) 

system("kill #{process_id}")
