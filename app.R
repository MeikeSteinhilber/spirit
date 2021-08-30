# This file is necessary for the publication on shinyapps.io
# However, it is ignored for building the package
options(shiny.autoload.r=FALSE)
pkgload::load_all(".")
spirit::myApp()
