# puppet-http

**DO CONSIDER TWICE BEFORE USING IN PRODUCTION ENVIRONMENT!!!**

Certificates are never nightmares! This gem allows your Puppet agent talk to master via HTTP easily, thus you won't
get any trouble in certificate issuing.

## Installation

```
$ gem install 'puppet-http'
```

## Usage

As to agent side, just using:

```
$ puppet http_agent the-rest-option-as-usual
```

The usage of master side depends on how you boot the master. If you trigger master via commandline, namely, using
WEBrick mode, just type:

```
$ puppet http_master the-rest-option-as-usual
```

If you run your master as a Rack middleware, the steps are as follows:

  1. turn off your frond-end web server SSL features!
  2. edit your `config.ru` file, add a line `require 'puppet/http'` at the very beginning, and also change
  `$0 = "master"` into `$0 = "http_master"`.
  
Here's a modified `config.ru` example:

```ruby
# a config.ru, for use with every rack-compatible webserver.
# SSL needs to be handled outside this, though.

# if puppet is not in your RUBYLIB:
# $LOAD_PATH.unshift('/opt/puppet/lib')

require 'puppet/http'  # <-- add this line

$0 = "http_master"     # <-- change this line

# if you want debugging:
# ARGV << "--debug"

ARGV << "--rack"

# Rack applications typically don't start as root.  Set --confdir and --vardir
# to prevent reading configuration from ~puppet/.puppet/puppet.conf and writing
# to ~puppet/.puppet
ARGV << "--confdir" << "/etc/puppet"
ARGV << "--vardir"  << "/var/lib/puppet"

# NOTE: it's unfortunate that we have to use the "CommandLine" class
#  here to launch the app, but it contains some initialization logic
#  (such as triggering the parsing of the config file) that is very
#  important.  We should do something less nasty here when we've
#  gotten our API and settings initialization logic cleaned up.
#
# Also note that the "$0 = master" line up near the top here is
#  the magic that allows the CommandLine class to know that it's
#  supposed to be running master.
#
# --cprice 2012-05-22

require 'puppet/util/command_line'
# we're usually running inside a Rack::Builder.new {} block,
# therefore we need to call run *here*.
run Puppet::Util::CommandLine.new.execute
```

## TODO

Maybe we need some tests?

## Mechanism 

Somehow, Puppet will search certain places to find out a what so called `ApplicationSubcommand`. If there's a file 
whose name is `my_app.rb` under the relative path `lib\puppet\application\` to following paths:

  1. all the gems' directory
  2. Puppet modules' directory
  3. `libdirs`
  4. the `$LOAD_PATH` of Ruby interpreter

In addition, the file `my_app.rb` is supposed to:
 
  1. be a subclass(directly or indirectly) of `Puppet::Application`
  2. define under the namespace `Puppet::Application`
  3. have a CamlCase class name

For example, the class definition of `my_app.rb` should be:

```ruby
class Puppet::Application::MyApp < Puppet::Application

# Your code goes here
```

Thus, when you boot puppet using `puppet my_app`, the file will be loaded and executed. We use this way to load 
customize script and perform some dirty monkey patchings to disable the Puppet SSL feature.

## Development && Contributing

Feel free to report bugs and send pull request!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

