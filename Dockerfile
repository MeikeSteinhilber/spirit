FROM rocker/shiny:4.0.4
RUN install2.r rsconnect bslib dplyr readxl pkgload shiny shinyBS sprtt tools tibble writexl
WORKDIR /home/shinyusr
COPY app.R app.R 
COPY deploy.R deploy.R
COPY R /R
CMD Rscript deploy.R