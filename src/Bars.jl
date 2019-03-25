#module Bars

export Bar, greet

struct Bar
  foo::Foo
  name
end

greet(bar::Bar) = phrase(bar.foo) * bar.name

#end # module
