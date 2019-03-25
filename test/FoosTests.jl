@time @testset "Foos" begin

  @testset "EnglishFoo" begin

    foo = EnglishFoo()
    
    @test phrase(foo) == "Hi everybody! I am "

  end

  @testset "GermanFoo" begin
  
    foo = GermanFoo()
    
    @test phrase(foo) == "Guten Tag! Ich bin "

  end

end
