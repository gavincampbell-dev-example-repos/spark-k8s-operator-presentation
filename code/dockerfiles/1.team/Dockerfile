FROM gcdotd/spark-py:v1.0
USER 0
# root
    
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar /opt/spark/jars
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.901/aws-java-sdk-bundle-1.11.901.jar /opt/spark/jars
ADD https://repo1.maven.org/maven2/io/delta/delta-core_2.12/1.2.0/delta-core_2.12-1.2.0.jar /opt/spark/jars
ADD https://repo1.maven.org/maven2/io/delta/delta-contribs_2.12/1.2.0/delta-contribs_2.12-1.2.0.jar /opt/spark/jars
ADD https://repo1.maven.org/maven2/io/delta/delta-storage/1.2.0/delta-storage-1.2.0.jar /opt/spark/jars
ADD https://repo1.maven.org/maven2/org/codehaus/jackson/jackson-core-asl/1.9.13/jackson-core-asl-1.9.13.jar /opt/spark/jars

RUN chmod 644 /opt/spark/jars/hadoop-aws-3.3.1.jar  \
    && chmod 644 /opt/spark/jars/aws-java-sdk-bundle-1.11.901.jar \
    && chmod 644 /opt/spark/jars/delta-core_2.12-1.2.0.jar \
    && chmod 644 /opt/spark/jars/delta-contribs_2.12-1.2.0.jar  \
    && chmod 644 /opt/spark/jars/delta-storage-1.2.0.jar \
    && chmod 644 /opt/spark/jars/jackson-core-asl-1.9.13.jar 

RUN pip install delta-spark==1.2.0

USER 185
# spark


