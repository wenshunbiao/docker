# Dockerizing thunder xware


## 使用

### 拉取镜像

```
docker pull ivories/thunder:1.0
```

### 创建一个下载目录. 用于挂载卷

```
mkdir data
```

### 运行

```
docker run -d --name=thunder -v $(pwd)/data:/app/TDDOWNLOAD ivories/thunder:1.0
```


### 查看日志(激活码)/到迅雷增加设备

```
docker logs thunder
```

```
// output:
starting xunlei service...
Connecting to 127.0.0.1:9000 (127.0.0.1:9000)
Connecting to 127.0.0.1:9000 (127.0.0.1:9000)
Connecting to 127.0.0.1:9000 (127.0.0.1:9000)
.........................
getting xunlei service info...
THE ACTIVE CODE IS: xxx
go to http://yuancheng.xunlei.com, bind your device with the active code.
finished.
```

