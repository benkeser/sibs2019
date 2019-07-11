# Start by pulling ubuntu image
FROM rocker/rstudio:latest

# update libraries
RUN apt-get -y update

# non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get install -y wget

# # install R from command line
# RUN apt-get install -y --fix-missing r-base
# RUN apt-get install -y gdebi
# # RUN cd ~/Downloads
# RUN wget https://www.rstudio.org/download/latest/stable/server/debian9_64/rstudio-server-latest-amd64.deb
# RUN gdebi rstudio-server-latest-amd64.deb
# RUN rm rstudio-server-latest-amd64.deb
# RUN mkdir -p /etc/R

# make directories
# lib contains R source files
# dat contains data 
RUN mkdir /home/data /home/lib /home/secret

# install R libraries needed for analysis
COPY R/r_package_installs.R /home/lib/r_package_installs.R
RUN chmod +x /home/lib/r_package_installs.R && /home/lib/r_package_installs.R
RUN rm /home/lib/r_package_installs.R

# copy other code and data
COPY R/learning_code.R /home/lib/learning_code.R
COPY R/secret_code.R /home/secret/secret_code.R
COPY data/drugs_data.RData /home/data/drugs_data.RData
COPY data/test_data.RData /home/data/test_data.RData
COPY data/train_data.RData /home/data/train_data.RData
COPY data/new_drugs_data.RData /home/data/new_drugs_data.RData
COPY data/new_drugs_data_outcomes.RData /home/secret/new_drugs_data_outcomes.RData

# copy R scripts to do data pull and make executable
COPY R/analysis_code.R /home/lib/analysis_code.R