@time @testset "Bars" begin

  @testset "BarInEnglish" begin

    foo = EnglishFoo()
    
    bar = Bar(foo,"John")
    
    @test greet(bar) == "Hi everybody! I am John"

  end

  @testset "BarInGerman" begin
  
    foo = GermanFoo()
    
    bar = Bar(foo,"Johanes")
    
    @test greet(bar) == "Guten Tag! Ich bin Johanes"

  end

end
