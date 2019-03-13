
include("precision.jl")
include("helpers.jl")

"""
Abstract type representing a collection of values of a function
basis evaluated on a set of local points in each of the cells of the mesh.
"""

abstract type CellPointBasisToValue{N} end

@mustimplement ncells(::CellPointBasisToValue)::Int

@mustimplement npoints(::CellPointBasisToValue,cell::Int)::Int

@mustimplement Base.getindex(::CellPointBasisToValue,cell::Int)::Array

@mustimplement ischached(::CellPointBasisToValue,cell::Int)::Int

function rank(::CellPointBasisToValue{N}) where N
  N-2
end

#Dummy type for the moment

struct Polynomial end

function (f::Polynomial)(points,values)
  values[:] = 0.0
end

struct CellPointBasisToValueFromRefBasisAndPoints <: CellPointBasisToValue{N}
  cell_to_points::CellPointBasisToValue{2}
  cell_to_ref::Array{Int,1}
  ref_to_basis::Array{Polynomial,1}
  values::Array{Fp,N}
  last_ref::Int
end

function _iscached( cell, cell_to_ref, last_ref)
  last_ref == cell_to_ref[cell]
end

function _getindex(cell_to_points, cell_to_ref, ref_to_basis, values)
  work = ! _iscached( cell, cell_to_ref, last_ref)
  work = work || ! ischached(cell_to_points,cell)
  if work
    ref = cell_to_ref[cell]
    basis = ref_to_basis[ref]
    points = cell_to_points[cell]
    basis(points,values)
  end
  values
end

ncells(self::CellPointBasisToValueFromRefBasisAndPoints) = size(self.cell_to_ref,1)

function npoints(self::CellPointBasisToValueFromRefBasisAndPoints,cell::Int)
  ref = self.cell_to_ref[cell]
  size(self.ref_to_value[ref],1)
end 


function Base.getindex(self::CellPointBasisToValueFromRefBasisAndPoints,cell::Int)
end

