using FriendlyDoLoop
using Test


@time @testset "cell_point_to_value.jl" begin
include("test_cell_point_to_value.jl") end

@time @testset "cell_point_to_s_value.jl" begin
include("test_cell_point_to_s_value.jl") end

@time @testset "cell_point_to_value.jl" begin
include("test_cell_point_to_value.jl") end

@time @testset "cell_point_to_s_value.jl" begin
include("test_cell_point_to_s_value.jl") end
