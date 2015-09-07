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

If you run your master as a Rack middleware, how lucky you are, the only thing you need to do is to **turn off the SSL 
feature of your front-end web server**.

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

