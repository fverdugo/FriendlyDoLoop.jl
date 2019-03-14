
using FriendlyDoLoop: CellPointToSValueFromRefValues

function run_test_SV(cell_to_values,cell_to_ref,ref_to_value)

  @time begin
    passed = true
    for cell in 1:ncells(cell_to_values)

      ic = ischached(cell_to_values,cell)
  
      vals1 = cell_to_values[cell]
      vals2 = ref_to_value[cell_to_ref[cell]]

      passed = passed && (vals1 == vals2)

      for point in 1:npoints(cell_to_values,cell)

        passed = passed && (vals1[point] == vals2[point])

      end
    end
  end
  @test passed

end

v1 = rand(4)
v2 = rand(3)
v3 = rand(5)

ref_to_value = [ v1, v2, v3  ]

cell_to_ref = rand(1:3,10000)

cell_to_values = CellPointToSValueFromRefValues{Float64}(
  ref_to_value,cell_to_ref)

@test isa(cell_to_values,CellPointToSValue)

run_test_SV(cell_to_values,cell_to_ref,ref_to_value)


using StaticArrays

val = SVector{3,Float64}(1.0,3.0,1.1)

v1 = [i*val for i in 1:4 ]
v2 = [i*val for i in 1:3 ]
v3 = [i*val for i in 1:5 ]

ref_to_value = [ v1, v2, v3  ]

cell_to_ref = rand(1:3,10000)

cell_to_values = CellPointToSValueFromRefValues{SVector{3,Float64}}(
  ref_to_value,cell_to_ref)

@test isa(cell_to_values,CellPointToSValue)

run_test_SV(cell_to_values,cell_to_ref,ref_to_value)

