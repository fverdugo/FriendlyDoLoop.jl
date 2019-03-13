
include("precision.jl")
include("helpers.jl")

##

abstract type CellPointToValue end

@mustimplement ncells(::CellPointToValue)::Int

@mustimplement npoints(::CellPointToValue,cell::Int)::Int

@mustimplement getvalues(::CellPointToValue,cell::Int,::Array)::Array

export CellPointToValue, ncells, npoints, getvalues

##

const Scal = 1
const Vect = 2
const Tens = 3

export Scal, Vect, Tens

##

struct CellPointToValueFromRefValues{N} <: CellPointToValue
  ref_to_value::Array{Array{Fp,N},1}
  cell_to_ref::Array{Int,1}
end

ncells(self::CellPointToValueFromRefValues) = size(self.cell_to_ref,1)

function npoints(self::CellPointToValueFromRefValues,cell::Int)
  ref = self.cell_to_ref[cell]
  return size(self.ref_to_value[ref],1)
end 

function getvalues(self::CellPointToValueFromRefValues,cell::Int,::Array)
    ref = self.cell_to_ref[cell]
    return self.ref_to_value[ref]
end


