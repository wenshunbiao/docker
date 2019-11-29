MASTER_HOST=192.168.1.221
ETCD_ENDPOINTS=http://192.168.1.221:2379,192.168.1.222:2379,192.168.1.223:2379
POD_NETWORK=10.2.0.0/16
SERVICE_IP_RANGE=10.3.0.0/24
K8S_SERVICE_IP=10.3.0.1
DNS_SERVICE_IP=10.3.0.10

########################################
FLANNELD_IFACE=${ADVERTISE_IP}
FLANNELD_ETCD_ENDPOINTS=${ETCD_ENDPOINTS}

Example: 192.168.1.221
FLANNELD_IFACE=192.168.1.221
FLANNELD_ETCD_ENDPOINTS=http://192.168.1.221:2379

ETCD_SERVER
http://192.168.1.221:2379


nohup ./hyperkube proxy \
--hostname-override=192.168.56.221 \
--master=http://192.168.56.221:8080 \
--logtostderr=true \
> proxy.out &




kubectl proxy --address='192.168.56.221' --accept-hosts='^*$'

kubectl patch node kubernetes-minion1 -p '{＂spec＂:{＂unschedulable＂:true}}'


/kubectl get po --all-namespaces
/kubectl describe po kubernetes-dashboard --namespace=kube-system
/kubectl logs kubernetes-dashboard-1832229289-tghwg --namespace=kube-system

/kubectl delete deploy kubernetes-dashboard --namespace=kube-system
/kubectl delete services kubernetes-dashboard --namespace=kube-system
/kubectl create -f 1.yaml

cat << EOF > 1.yaml
kind: Deployment
apiVersion: extensions/v1beta1
metadata:
  labels:
    app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kube-system
spec:
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: kubernetes-dashboard
  template:
    metadata:
      labels:
        app: kubernetes-dashboard
      # Comment the following annotation if Dashboard must not be deployed on master
      annotations:
        scheduler.alpha.kubernetes.io/tolerations: |
          [
            {
              "key": "dedicated",
              "operator": "Equal",
              "value": "master",
              "effect": "NoSchedule"
            }
          ]
    spec:
      containers:
      - name: kubernetes-dashboard
        image: ivories/kubernetes-dashboard:1.0
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 9090
          protocol: TCP
        args:
          - --apiserver-host=http://192.168.1.112:8080
        livenessProbe:
          httpGet:
            path: /
            port: 9090
          initialDelaySeconds: 30
          timeoutSeconds: 30
---
kind: Service
apiVersion: v1
metadata:
  labels:
    app: kubernetes-dashboard
  name: kubernetes-dashboard
  namespace: kube-system
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 9090
  selector:
    app: kubernetes-dashboard
EOF




