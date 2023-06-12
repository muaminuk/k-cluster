#!/bin/bash

# uninstall OpenEBS Helm chart if openebs was installed using helm chart
# helm delete openebs -n openebs



gsutil cp gs://config-management-release/released/latest/config-management-operator.yaml config-management-operator.yaml

kubectl apply -f config-management-operator.yaml


ssh-keygen -t rsa -b 4096  -C "<repo-user-name>" -f "<path-to-key-file>"




# Kubernetes Secret that will contain your private key The Secret must be created in the config-management-system namespace and named as git-creds.

kubectl create ns config-management-system 
kubectl create secret generic git-creds --namespace=config-management-system --from-file=ssh=<path-to-private-key>



# config-management.yaml

apiVersion: configmanagement.gke.io/v1
kind: ConfigManagement
metadata:
  name: config-management
spec:
  cluster: anthos-cluster
  sourceFormat: unstructured
  git:
    syncRepo: <repo-url>
    secretType: ssh


kubectl apply -f config-management.yaml

# nomos status

# #  Setting up Policy Controller

# apiVersion: configmanagement.gke.io/v1
# kind: ConfigManagement
# metadata:
#   name: config-management
# spec:
# cluster: anthos-cluster
# sourceFormat: unstructured 
#   policyController:
#     enabled: true
#   git:
#     syncRepo: <repo-url>
#     secretType: ssh










# cleanup PVC (sparse files)
rm -rf /var/openebs/

# deleting namespace
kubectl delete ns openebs --wait=false

# cleanup namespace finalizers

# be sure that everything else was deleted before

#kubectl get namespace openebs -o json | jq -j '.spec.finalizers=null' > tmp.json
#kubectl replace --raw "/api/v1/namespaces/openebs/finalize" -f ./tmp.json