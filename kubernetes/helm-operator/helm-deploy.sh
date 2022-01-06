#!/bin/bash

if [ -d /root/.aws ]
then
    echo "directory already exist"
else
    mkdir /root/.aws
fi

echo "[$AWS_DEFAULT_PROFILE]" > /root/.aws/credentials;
echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /root/.aws/credentials;
echo "aws-secret-access-key = $AWS_SECRET_ACCESS_KEY" >> /root/.aws/credentials;
echo "[profile $AWS_DEFAULT_PROFILE]" > /root/.aws/config;
echo "region = us-west-2" >> /root/.aws/config; echo "output = json" >> /root/.aws/config;
aws eks --region us-west-2 update-kubeconfig --name lseg-eks-T9gWKSdV;
sed -i "s/jenkins_build_number/$BUILD_NUMBER/g" charts/lwa/values.yaml
export KUBECONFIG=/root/.kube/config;

helm lint charts/lwa
helm show charts/lwa

if [[ $BUILD_NUMBER -gt 1 ]]
then
    helm upgrade lseg-web-app charts/lwa -n web-apps
else
    helm install lseg-web-app charts/lwa -n web-apps
fi

sleep 30

kubectl get all,ingress,configmap -o wide
