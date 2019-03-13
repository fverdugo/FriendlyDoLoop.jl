using FriendlyDoLoop
using Test


abstract type Foo end

struct FooA <: Foo
  x::Array{Int,1}
end

Base.getindex(self::FooA,i::Int) = self.x

struct Bar
  foo::Foo
end

Base.getindex(self::Bar,i::Int) = self.foo[i]

function run(bar,j)
  k = j
  begin
    for i = 1:10000
       m = bar[i]
       @simd for s in size(m,1)
         k[s] += m[s]
       end
    end
  end
end

let

  k = fill(1,(2,))

  foo = FooA(k)
  bar = Bar(foo)

  @time run(bar,k)
  @time run(bar,k)

end

@time @testset "cell_point_to_value.jl" begin
include("test_cell_point_to_value.jl") end

