FROM node:6.5

ENV GHOST_VERSION 1.1.0
ENV GHOST_SOURCE /usr/src/ghost
ENV GHOST_CONTENT /usr/src/ghost/content

WORKDIR $GHOST_SOURCE

RUN buildDeps=' \
		gcc \
		make \
		python \
		unzip \
	' \
	&& set -x \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& wget -O aong-blog.zip https://github.com/yxwzaxns/aong-blog/archive/aong-blog.zip \
	&& unzip aong-blog.zip \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
	&& rm aong-blog.zip \
	&& npm cache clean \
	&& rm -rf /tmp/npm*

VOLUME $GHOST_CONTENT

RUN npm install -g knex-migrator
RUN npm install --production

COPY docker-entrypoint.sh /entrypoint.sh
COPY hosts /hosts

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 2368
CMD ["NODE_ENV=production", "node", "start"]
