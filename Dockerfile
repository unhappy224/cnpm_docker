FROM node:6.11.3-slim


# Working enviroment
ENV APPDIR /var/app/cnpmjs.org
ENV CNPMJS_ORG_VERSION 3.0.0-alpha.15

RUN \
  mkdir /var/app && \
  install -o www-data -d /var/app && \
  mkdir /var/www && chown www-data:www-data -R /var/www

USER www-data

RUN \
  wget -P /tmp https://github.com/cnpm/cnpmjs.org/archive/${CNPMJS_ORG_VERSION}.tar.gz && \
  tar xvzf /tmp/${CNPMJS_ORG_VERSION}.tar.gz -C /var/app && \
  mv /var/app/cnpmjs.org-${CNPMJS_ORG_VERSION} ${APPDIR}

WORKDIR ${APPDIR}

RUN npm install --registry=https://registry.npm.taobao.org

EXPOSE 7001 7002

# Entrypoint
CMD ["/usr/local/bin/node", "/var/app/cnpmjs.org/dispatch.js"]