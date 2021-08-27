FROM rocker/shiny:4.0.4
RUN install2.r rsconnect bslib dplyr readxl pkgload shiny shinyBS tools tibble writexl
RUN R -e "install.packages('sprtt')"
WORKDIR /home/shinyusr
COPY app.R app.R 
COPY DESCRIPTION DESCRIPTION
COPY deploy.R deploy.R
COPY R /R
CMD Rscript deploy.R