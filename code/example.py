from pyspark.sql import SparkSession
from pyspark.sql.functions import md5, col, max as to_the_max, to_timestamp

from delta.tables import *
from os import path, environ




spark = SparkSession.builder.appName("etl-demo").getOrCreate()


source_path = "s3a://staging/"
output_path = "s3a://output/"

new_orders = spark.read.option("multiline", "true").json(source_path)


output_df = new_orders.select(
    (md5("kebabType")).alias("kebab_type_id"), col("kebabType").alias("kebab_type_name")
).dropDuplicates()

dim_kebab_type = (
    DeltaTable.createIfNotExists(spark)
    .tableName("dim_kebab_type")
    .addColumn("kebab_type_id", dataType="STRING")
    .addColumn("kebab_type_name", dataType="STRING")
    .location(path.join(output_path, "dim_kebab_type"))
    .execute()
)

dim_kebab_type.alias("dim_kebab_type").merge(
    source=output_df.alias("new_kebabs"),
    condition="dim_kebab_type.kebab_type_id = new_kebabs.kebab_type_id",
).whenNotMatchedInsert(
    values={
        "kebab_type_id": "new_kebabs.kebab_type_id",
        "kebab_type_name": "new_kebabs.kebab_type_name",
    }
).execute()

fact_kebab_sales = (
    DeltaTable.createIfNotExists(spark)
    .tableName("fact_kebab_sales")
    .addColumn("order_timestamp", dataType="TIMESTAMP")
    .addColumn("kebab_type_id", dataType="STRING")
    .location(path.join(output_path, "fact_kebab_sales"))
    .execute()
)

kebab_types = spark.table("dim_kebab_type")

high_watermark = (
    spark.table("fact_kebab_sales").select(to_the_max("order_timestamp")).first()[0]
)


if high_watermark is not None:
    new_orders = new_orders.filter(new_orders["orderTimestamp"] > high_watermark)

new_orders.join(
    kebab_types, new_orders.kebabType == kebab_types.kebab_type_name
).select(
    to_timestamp(col("orderTimestamp")).alias("order_timestamp"), col("kebab_type_id")
).write.format(
    "delta"
).mode(
    "append"
).saveAsTable(
    "fact_kebab_sales"
)
