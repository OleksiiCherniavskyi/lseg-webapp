#!/bin/bash

if [ -d /root/.aws ]
then
    echo "directory already exist"
else
    mkdir /root/.aws
fi

echo "[$AWS_DEFAULT_PROFILE]" > /root/.aws/credentials
echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /root/.aws/credentials
echo "aws-secret-access-key = $AWS_SECRET_ACCESS_KEY" >> /root/.aws/credentials
echo "[profile $AWS_DEFAULT_PROFILE]" > /root/.aws/config
echo "region = $REGION" >> /root/.aws/config; echo "output = json" >> /root/.aws/config
aws eks --region $REGION update-kubeconfig --name $KUBE_CLUSTER_NAME 
sed -i "s/jenkins_build_number/$BUILD_NUMBER/g" charts/$CHART_NAME/values.yaml
export KUBECONFIG=/root/.kube/config

kubectl config set-context --current --namespace=$NAMESPACE
helm lint charts/$CHART_NAME
helm show all charts/$CHART_NAME

if [[ $BUILD_NUMBER -gt 1 ]]
then
    helm upgrade $JOB_NAME charts/$CHART_NAME

    if [[ $? -eq 1 ]]; 
    then
        echo "Trying to install rather than to upgrade..."
        helm install $JOB_NAME charts/$CHART_NAME
        
        if [[ $? -eq 1 ]];
        then
            echo "Something went wrong..."
            exit 1
        fi
    fi
else
    helm install $JOB_NAME charts/$CHART_NAME

    if [[ $? -eq 1 ]]; 
    then
        echo "Something went wrong..."
        exit 1
    fi
fi

sleep 30

kubectl get all,ingress,configmap -o wide
