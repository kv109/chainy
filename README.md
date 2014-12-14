Chainy
======

__Chainy__ makes method chaining easier.

### Usage

Use `.chain_attr_accessor` to tell __Chainy__ which methods should be chainable:

```ruby
class YourClass
  chain_attr_accessor :strategy, :timeout
end
```

`.chain_attr_accessor` creates getter, setter, but also chain setter:

```ruby
instance = YourClass.new

# getter:
instance.strategy               # => nil

# setter: 
instance.strategy = :password   # => :password

# chain setters
instance.with_strategy(:mock).with_timeout(30)
instance.strategy               # => :mock
instance.timeout                # => 30
```

### Options

#### 1. hash: true

If `hash` option is set to `true`, __Chainy__ sets default getter value to empty `Hash` and chain setter adds new values to this `Hash`:

```ruby
class YourClass
  chain_attr_accessor :options, hash: true
end

instance.options  #=> {}
instance.with_options(option1: value1).with_options(option2: value2).with_options(option3: value3)
instance.options  #=> {option1: value1, option2: value2, option3: value3}
```

Also, method for removing options is created:

```ruby
instance.without_options(:option1, :option2)
instance.options  #=> {option3: value3}
```


#### 2. prefix: 'your_prefix'

Default prefix for chain setters is `with_`, but you can overwrite it with `prefix` option:

```ruby
class YourClass
  chain_attr_accessor :strategy, :timeout, prefix: 'add'
end
```

You can also change default prefix:

```ruby
Chainy.configure do |config|
  config.prefix = 'add'
end
```

### Installation

Install gem

`gem install chainy`

and use it

```ruby
require 'chainy'

class YourClass
  chain_attr_accessor :strategy, :timeout, prefix: 'add'
end

instance = YourClass.new
instance.add_strategy(:mock).add_timeout(30)
```

or simply add it to your `Gemfile`: 

`gem 'chainy'`
