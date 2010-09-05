
require "rubygems"
require "fssm"

sourceDir = File.join(File.dirname(__FILE__), 'spec/sandbox/source')
destDir = File.join(File.dirname(__FILE__) , 'spec/sandbox/dest')

puts "starting directory watching.."

FSSM.monitor(sourceDir) do
  update {|base, relative| p base + " updated"}
  delete {|base, relative| p base + " deleted"}
  create {|base, relative| p base + " created"}
end

puts "\nDone watching directory."
