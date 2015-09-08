# Here's the situation: Puppet will search all the gems directory to find a validate
# *ApplicationSubcommand*. But some how, rack use Bundler to load the gem. In this
# situation, the Puppet autoloader won't search bundler directory to get the file we
# want. So we have to inject our gem directory to $LOAD_PATH so that enables
# *http_master*. Maybe we have a better way to do that, right?  -- DeathKing 2015-09-08

if defined? ::Bundler
  $LOAD_PATH.unshift(File.expand_path(__FILE__) + "../")
end