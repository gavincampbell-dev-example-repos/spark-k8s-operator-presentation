spark-submit \
--master k8s://https://162.55.43.10:6443 \
--deploy-mode cluster \
--name example-py \
--conf spark.kubernetes.container.image=docker.io/gcdotd/team_image:v1.0  \
--conf spark.kubernetes.namespace=spark-ns \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark-svc-ac \
--conf spark.hadoop.fs.s3a.endpoint=http://162.55.43.10:9000 \
--conf spark.hadoop.fs.s3a.access.key=$MINIO_USER \
--conf spark.hadoop.fs.s3a.secret.key=$MINIO_PASSWORD \
--conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem  \
--conf spark.hadoop.fs.s3a.path.style.access=true \
--conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog \
--conf spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension \
s3a://code/example.py
