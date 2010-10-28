$LOAD_PATH << File.join( File.dirname(__FILE__), 'warmonger' )

require 'filewatcher'
require 'project'
require 'handlers/copyhandler'
require 'handlers/compilehandler'
