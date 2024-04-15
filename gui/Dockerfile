FROM rocker/shiny-verse:4.3.3

WORKDIR /work
COPY install.R install.R
RUN Rscript install.R

COPY ui.R /srv/shiny-server/
COPY server.R /srv/shiny-server/

EXPOSE 80

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/', host='0.0.0.0', port=80)"]