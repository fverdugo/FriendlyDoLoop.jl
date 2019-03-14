
"""
Abstract type representing a collection of values defined
on a set of local points in each of the cells of the mesh.
"""

abstract type CellPointToValue{N} end

@mustimplement ncells(::CellPointToValue)::Int

@mustimplement npoints(::CellPointToValue,cell::Int)::Int

@mustimplement Base.getindex(::CellPointToValue,cell::Int)::Array

@mustimplement ischached(::CellPointToValue,cell::Int)::Int

function rank(::CellPointToValue{N}) where N
  N-1
end

export CellPointToValue, ncells, npoints, getvalues, ischached, rank

"""
Concrete implementation of `CellPointToValue` based on
reference values
"""

mutable struct CellPointToValueFromRefValues{N} <: CellPointToValue{N}
  ref_to_value::Array{Array{Fp,N},1}
  cell_to_ref::Array{Int,1}
  last_ref::Int
end

function CellPointToValueFromRefValues{N}(ref_to_value,cell_to_ref) where N
  CellPointToValueFromRefValues{N}(ref_to_value,cell_to_ref,-1)
end

ncells(self::CellPointToValueFromRefValues) = size(self.cell_to_ref,1)

function npoints(self::CellPointToValueFromRefValues,cell::Int)
  ref = self.cell_to_ref[cell]
  size(self.ref_to_value[ref],1)
end 

function Base.getindex(self::CellPointToValueFromRefValues,cell::Int)
    ref = self.cell_to_ref[cell]
    self.last_ref = ref
    self.ref_to_value[ref]
end

function ischached(self::CellPointToValueFromRefValues,cell::Int)
  self.cell_to_ref[cell] == self.last_ref
end

const Scal = 1
const Vect = 2
const Tens = 3

export Scal, Vect, Tens

