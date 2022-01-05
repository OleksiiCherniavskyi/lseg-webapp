# LSEG Web Application

This repo includes Apache web server (httpd) that is running in docker and respondes to /me and /health URL paths in such a way:
- the route "/me" that will return the local container IP
- the route "/health" that will return "OK {ENV}" if the app is working and the environment
It was implemented by using apache 2.4 mod_alias as well as including PHP module known as php-fpm

Build section

```docker build . -t lseg-webapp:latest```

To run locally on your laptop apply the following:

```docker run -dit --name apache-lseg -p 1234:80 lseg-webapp:latest```

To verify if all routes are working well just check it in your browser by hitting 2 URLs
- http://127.0.0.1:1234/me
- http://127.0.0.1:1234/health 

Note: as alternative way you can use curl instead

- ```curl -L http://127.0.0.1:1234/me```
- ```curl -L http://127.0.0.1:1234/health```

## Ingress ALB has been implemented in Kubernetes

Here you can find external URLs that will respond to both paths with "Container IP: <container_ip>" and "OK {ENV}" where ENV cis receving kubernetes POD name where the apache web-server receives traffic on backend side correspondingly.
Here are those URLs:

- https://lseg-web-app.ua-devops.com/me/
- https://lseg-web-app.ua-devops.com/health/

In addition there is also internal AWS Network Load Balancer has been deployed as a part of Kubernetes service which consider to handle internal traffic for the security perspective. 

In this task there was also couple of manula work that had to be done by creating additional services which was not in scope of the task itself but were created to simplify such stuff like ALB endpoint name which would be complete unreadable rather than creating an Route53 Alias within the public hostetd zone "ua-devops.com" that has been created. But the main dificulty for me in this task was to manage Jenkins in that part which regards to exactly Jenkinsfile (Groovy) pipeline creation because since I decided to use Kubernetes as a platform where to provision Jenkins cluster it turned out that I was facing with dificulties in as anyone might think such trivial steps like write:

- Checkout GH repo
- Build/Push docker image (here I spent more than 6h to find out that there is no way to use docker cloud provider in Jenkins because all jobs will run inside Kubernetes POD)
- Install/Upgrade Helm Chart

For all of the above I was using "KANIKO Project" which is using some interesting approach for build docker images without dockeritself. So that Jenkins that running on k8s cluster cannot use standard "docker build" or "docker push" commands invoked inside the container and this is why I've spent too much time (almost 1 day)to get it done.

Nevertheless this task is really interesting and challenging! 
Many thanks for LSEG team who let my brain be explode during approx. 24-30 hours that I've spend.

I hope you'll like my code, sorry if there are not too much useful comments as well as maybe documentation is not look too much fine, but in any case my mission here has been accomplished. :)

Many thanks!
