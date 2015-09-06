# puppet-http

**DO CONSIDER THIS TWICE BEFORE USING IN PRODUCTION ENVIRONMENT!!!**

Certificates are never nightmares! This gem makes your Puppet agent talks to master via HTTP easily, so you won't get
 any trouble in certificate issuing.

## Installation

```
$ gem install 'puppet-http'
```

## Usage

For the agent side, just using:

```
$ puppet http_agent the-rest-option-as-usual
```

For the master side, it depends on how you boot the master. If you trigger master via commandline, namely using 
WEBrick mode, just type:

```
$ puppet http_master the-rest-option-as-usual
```

If you run your master as a Rack middleware, how lucky you are, the only thing you need to do is to **turn off the SSL 
feature of your front-end web server**.

## TODO

Maybe we need some tests?

## Development && Contributing

Feel free to report bugs and send pull request!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

