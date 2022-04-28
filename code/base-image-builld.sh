# dependencies: docker, jdk11

git clone https://github.com/apache/spark
git checkout tags/v3.2.1 -b build

./build/mvn -DskipTests -Dhadoop.version=3.3.1 -Pscala-2.12 -Pkubernetes clean package 



./dev/make-distribution.sh --name demo -Dhadoop.version=3.3.1 -Pscala-2.12 -Pkubernetes 
cd dist


./bin/docker-image-tool.sh -r gcdotd -t v1.0 -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build
./bin/docker-image-tool.sh -r gcdotd -t v1.0  push