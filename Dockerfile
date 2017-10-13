FROM re6exp/debian-jessie-oracle-jdk-8

COPY snowplow-stream-collector-0.10.0.jar ./
COPY config.hocon ./
CMD java -jar snowplow-stream-collector-0.10.0.jar --config config.hocon
