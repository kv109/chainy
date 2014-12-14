Chainy
======

__Chainy__ allows you to easily create chain methods, like: 
```ruby
object.add_item(:item).remove_item(:item_to_remove)
```

Use `.chain_attr_accessor` to add methods you want to be chain methods:

```ruby
class YourClass
  chain_attr_accessor :strategy, :timeout
end
```

It creates getter, setter, but also chain setter:

```ruby
instance = YourClass.new

instance.with_strategy(:mock).with_timeout(30)  #=> chain setters
instance.strategy               # getter
instance.strategy = :password   # setter
```

Default prefix for chain setters is `with_`, but you can overwrite it:

```ruby
class YourClass
  chain_attr_accessor :strategy, :timeout, prefix: 'add'
end
```

or just change the default:

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
