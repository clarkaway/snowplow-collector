FROM snowplow-docker-registry.bintray.io/snowplow/base:0.1.0
LABEL maintainer="Snowplow Analytics Ltd. <support@snowplowanalytics.com>"

# The version of the collector to download.
ENV COLLECTOR_VERSION="0.12.0"

# The name of the archive to download.
ENV ARCHIVE="snowplow_scala_stream_collector_${COLLECTOR_VERSION}.zip"

# Install the Scala Stream Collector.
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -q http://dl.bintray.com/snowplow/snowplow-generic/${ARCHIVE} && \
    unzip -d ${SNOWPLOW_BIN_PATH} ${ARCHIVE} && \
    cd /tmp && \
    rm -rf /tmp/build

# Port used by the collector. (Customized by Cru)
EXPOSE 5000

# Defines an entrypoint script delegating the lauching of the collector to the snowplow user.
# The script uses dumb-init as the top-level process.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Customizations by Cru
COPY config.hocon ${SNOWPLOW_CONFIG_PATH}
ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "" ]
