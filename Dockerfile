# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

RUN install2.r rsconnect bslib dplyr readxl pkgload shiny shinyBS tools tibble writexl devtools shinytest
RUN R -e "devtools::install_github('MeikeSteinhilber/sprtt')"

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev
## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

WORKDIR /home/shinyusr
COPY app.R app.R 
COPY DESCRIPTION DESCRIPTION
COPY deploy.R deploy.R
COPY /R ./R
CMD Rscript deploy.R