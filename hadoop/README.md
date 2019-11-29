# Distributed Highly Available Hadoop Cluster Docker Image Based on Alpine

[![DockerStars](https://img.shields.io/docker/stars/athlinks/hadoop.svg)](https://registry.hub.docker.com/u/athlinks/hadoop/)
[![DockerPulls](https://img.shields.io/docker/pulls/athlinks/hadoop.svg)](https://registry.hub.docker.com/u/athlinks/hadoop/)

## Standalone Mode

### Run
[![asciicast](https://asciinema.org/a/cbtwm3fv85ujsb4bjetix2x8a.png)](https://asciinema.org/a/cbtwm3fv85ujsb4bjetix2x8a)
```
docker run -d \
--name=hadoop-standalone \
-p 8088:8088 \
-p 50070:50070 \
-p 14000:14000 \
athlinks/hadoop:2.7 && \
docker logs -f hadoop-standalone
```

You can view the services here:</p>
HDFS: http://127.0.0.1:50070</p>
YARN: http://127.0.0.1:8088</p>
HTTPFS: http://127.0.0.1:14000

### Execute Test Job
```
docker exec -it hadoop-standalone bash -c "bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar teragen 1000 teragen_out_dir"
```

## Clustered Mode

### Run
Start the cluster for the first time:
[![asciicast](https://asciinema.org/a/49052.png)](https://asciinema.org/a/49052)
```
git clone https://github.com/athlinks/docker-hadoop.git
cd docker-hadoop/hadoop-2.7
./initialize.sh
```

### Execute Test Job
```
docker exec -it hadoop27_client_1 bash -c "bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.2.jar teragen 1000 teragen_out_dir"
```

If you have previously started and stopped the cluster, you can just run "docker-compose up -d" to restart it as the zookeeper format has already been done.
