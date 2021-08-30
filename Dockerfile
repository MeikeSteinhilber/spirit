FROM rocker/shiny:4.0.4
RUN install2.r rsconnect bslib dplyr readxl pkgload shiny shinyBS tools tibble writexl devtools
RUN R -e "devtools::install_github('MeikeSteinhilber/sprtt')"
WORKDIR /home/shinyusr
COPY app.R app.R 
COPY DESCRIPTION DESCRIPTION
COPY deploy.R deploy.R
COPY R /R
CMD Rscript deploy.R