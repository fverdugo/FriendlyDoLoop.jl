
# Place to put miscellaneous helpers
# Once a subset of functionality has sense by its own,
# move it no another place

macro mustimplement(sig)
fname = sig.args[1]
arg1 = sig.args[2]
if isa(arg1,Expr)
    arg1 = arg1.args[1]
end
:($(esc(sig)) = error(typeof($(esc(arg1))),
                      " must implement ", $(Expr(:quote,fname))))
end

