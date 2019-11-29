docker run -d --name=influxdb -p 8083:8083 -p 8086:8086 --net=host -v /data:/data ivories/heapster-influxdb:1.0
docker run -d --name=grafana -p 3000:3000 --net=host -e INFLUXDB_SERVICE_URL=http://192.168.1.112:8086 -e GF_AUTH_BASIC_ENABLED="false" -e GF_AUTH_ANONYMOUS_ENABLED="true" -e GF_AUTH_ANONYMOUS_ORG_ROLE="Admin" -e GF_SERVER_ROOT_URL=/ -v /var ivories/heapster-grafana:1.0
docker run -d --name=heapster -p 8082:8082 --net=host ivories/heapster:1.0 --source=kubernetes:http://192.168.1.112:8080?inClusterConfig=false&useServiceAccount=false --sink=influxdb:http://192.168.1.112:8086


/kubectl delete deploy heapster-grafana --namespace=kube-system
/kubectl delete services heapster-grafana --namespace=kube-system

/kubectl delete deploy heapster --namespace=kube-system
/kubectl delete services heapster --namespace=kube-system

/kubectl delete deploy heapster-influxdb --namespace=kube-system
/kubectl delete services heapster-influxdb --namespace=kube-system

/kubectl log --namespace=kube-system heapster-influxdb-4275004221-485rg
/kubectl log --namespace=kube-system heapster-3659190082-ncsbf

/kubectl describe po --namespace=kube-system heapster-3659190082-ncsbf

/kubectl get po --all-namespaces 

/kubectl create -f 3.yaml

cat > 3.yaml << EOF
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: heapster-grafana
  namespace: kube-system
spec:
  replicas: 1
  template:
    metadata:
      labels:
        task: monitoring
        k8s-app: grafana
    spec:
      containers:
      - name: grafana
        image: ivories/heapster-grafana:1.0
        imagePullPolicy: IfNotPresent
        ports:
          - containerPort: 3000
            protocol: TCP
        volumeMounts:
        - mountPath: /var
          name: grafana-storage
        env:
        - name: INFLUXDB_HOST
          value: heapster-influxdb
        - name: GRAFANA_PORT
          value: "3000"
          # The following env variables are required to make Grafana accessible via
          # the kubernetes api-server proxy. On production clusters, we recommend
          # removing these env variables, setup auth for grafana, and expose the grafana
          # service using a LoadBalancer or a public IP.
        - name: GF_AUTH_BASIC_ENABLED
          value: "false"
        - name: GF_AUTH_ANONYMOUS_ENABLED
          value: "true"
        - name: GF_AUTH_ANONYMOUS_ORG_ROLE
          value: Admin
        - name: GF_SERVER_ROOT_URL
          # If you're only using the API Server proxy, set this value instead:
          # value: /api/v1/proxy/namespaces/kube-system/services/heapster-grafana/
          value: /
      volumes:
      - name: grafana-storage
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    # For use as a Cluster add-on (https://github.com/kubernetes/kubernetes/tree/master/cluster/addons)
    # If you are NOT using this as an addon, you should comment out this line.
    kubernetes.io/cluster-service: 'true'
    kubernetes.io/name: heapster-grafana
  name: heapster-grafana
  namespace: kube-system
spec:
  # In a production setup, we recommend accessing Grafana through an external Loadbalancer
  # or through a public IP.
  # type: LoadBalancer
  # You could also use NodePort to expose the service at a randomly-generated port
  # type: NodePort
  ports:
  - port: 80
    targetPort: 3000
  selector:
    k8s-app: grafana
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: heapster
  namespace: kube-system
spec:
  replicas: 1
  template:
    metadata:
      labels:
        task: monitoring
        k8s-app: heapster
    spec:
      containers:
      - name: heapster
        image: ivories/heapster:1.0
        imagePullPolicy: IfNotPresent
        command:
        - /heapster
        - --source=kubernetes:http://192.168.1.112:8080?inClusterConfig=false&useServiceAccount=false
        - --sink=influxdb:http://192.168.1.112:8086
---
apiVersion: v1
kind: Service
metadata:
  labels:
    task: monitoring
    # For use as a Cluster add-on (https://github.com/kubernetes/kubernetes/tree/master/cluster/addons)
    # If you are NOT using this as an addon, you should comment out this line.
    kubernetes.io/cluster-service: 'true'
    kubernetes.io/name: Heapster
  name: heapster
  namespace: kube-system
spec:
  ports:
  - port: 80
    targetPort: 8082
  selector:
    k8s-app: heapster
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: heapster-influxdb
  namespace: kube-system
spec:
  replicas: 1
  template:
    metadata:
      labels:
        task: monitoring
        k8s-app: influxdb
    spec:
      containers:
      - name: influxdb
        image: ivories/heapster-influxdb:1.0
        imagePullPolicy: IfNotPresent
        volumeMounts:
        - mountPath: /data
          name: influxdb-storage
      volumes:
      - name: influxdb-storage
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    task: monitoring
    # For use as a Cluster add-on (https://github.com/kubernetes/kubernetes/tree/master/cluster/addons)
    # If you are NOT using this as an addon, you should comment out this line.
    kubernetes.io/cluster-service: 'true'
    kubernetes.io/name: heapster-influxdb
  name: heapster-influxdb
  namespace: kube-system
spec:
  ports:
  - port: 8086
    targetPort: 8086
  selector:
    k8s-app: influxdb
EOF
