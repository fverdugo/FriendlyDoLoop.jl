
"""
Abstract type representing a collection of values defined
on a set of local points in each of the cells of the mesh.
if `cell_point_to_value` is an instance of this type
`value = cell_point_to_value[cell][point]`
will be the value associated with the cell id `cell`,
and local point id `point`
"""
abstract type CellPointToSValue{T} end

@mustimplement ncells(::CellPointToSValue)::Int

@mustimplement npoints(::CellPointToSValue,cell::Int)::Int

function Base.getindex(::CellPointToSValue{T},cell::Int)::Array{T,1} where T
  error("must be implemented")
end

@mustimplement ischached(::CellPointToSValue,cell::Int)::Int

export CellPointToSValue, ncells, npoints, getvalues, ischached, rank

"""
Concrete implementation of `CellPointToSValue` based on
reference values
"""

mutable struct CellPointToSValueFromRefValues{T} <: CellPointToSValue{T}
  ref_to_value::Array{Array{T,1},1}
  cell_to_ref::Array{Int,1}
  last_ref::Int
end

function CellPointToSValueFromRefValues{T}(ref_to_value,cell_to_ref) where T
  CellPointToSValueFromRefValues{T}(ref_to_value,cell_to_ref,-1)
end

ncells(self::CellPointToSValueFromRefValues) = size(self.cell_to_ref,1)

function npoints(self::CellPointToSValueFromRefValues,cell::Int)
  ref = self.cell_to_ref[cell]
  size(self.ref_to_value[ref],1)
end 

function Base.getindex(self::CellPointToSValueFromRefValues,cell::Int)
    ref = self.cell_to_ref[cell]
    self.last_ref = ref
    self.ref_to_value[ref]
end

function ischached(self::CellPointToSValueFromRefValues,cell::Int)
  self.cell_to_ref[cell] == self.last_ref
end

