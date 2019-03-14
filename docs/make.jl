push!(LOAD_PATH,"../src/")
using Documenter
using FriendlyDoLoop

makedocs(
    sitename = "FriendlyDoLoop",
    format = Documenter.HTML(),
    modules = [FriendlyDoLoop]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
