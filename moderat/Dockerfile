FROM node:boron

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
RUN apt-get -y update && apt-get -y install apt-transport-https libtinfo-dev
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN  apt-get -y update &&\
     apt-get -y upgrade &&\
     apt-get -y install yarn

RUN npm install -g elm@0.18.0 elm-test@0.18.0
RUN node --version && elm-make -h
