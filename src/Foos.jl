@reexport module Foos

export Foo, phrase, EnglishFoo, GermanFoo

abstract type Foo end

phrase(::Foo) = error("abstract method")

struct EnglishFoo <: Foo end

phrase(::EnglishFoo) = "Hi everybody! I am "

struct GermanFoo <: Foo end

phrase(::GermanFoo) = "Guten Tag! Ich bin "

end # module
