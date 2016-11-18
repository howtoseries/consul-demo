# consul-demo

## Purpose

This demo shows how Consul (http://consul.io) works. It simulates an environment consisting of:
* Service Registry Layer - 3 consul servers
* App Layer - 1 springboot rest app (it's just the sample rest app that prints additional string of HOST where it runs)
* Reverse Proxy / Load Balancer Layer - 1 nginx server

This demo uses docker-compose to build the environment only for easiness of distribution. In order to use Consul in a Docker Env in 'the real world' this is not the way to do it. BE WARNED.

## Pre-requisites

* Docker Engine (with access to docker hub - setup your proxy)
* Docker Compose
* Optional: consul executable available in your PATH

## Bootstrap

* git clone
* cd into the root dir of the repo
* docker-compose up
* done!

## The network

All the nodes will be put inside the net 172.18.233.0/24, only three nodes have fixed addresses: consul1 is 172.18.233.20, consul2 22 and consul3 23.

## How the pieces fit together

Now you have the environment up and can see the beauty of Consul.

The consul cluster consists of two kinds of nodes: those in client and those in server modes. So the 3 nodes in the Service Registry Layer are in 'server mode' and all the others are in 'client mode'.

This demo is configured so that the nodes in APP LAYER register itselves as the 'service' APP1 and the REVERSE PROXY LAYER ones register itselves as 'sevice' NGINX.

This demonstrates how services could insert data into de SERVICE REGISTRY LAYER.

At this point, it would by really nice if you start your local consul agent with the script provided in the repo like this:
* ./scripts/enable-consul.sh (CAUTION, this script was made for Ubuntu-based distros)

You can later disable with the 'disable-consul.sh' script.

This script will:
* Configure nat for ports upd/tcp 53 redirecting to 8600 (defaul of Consul's DNS API)
* Start consul agent in client mode using consul1 as start server and 127.0.1.1 as external DNS resolver (told'ya it's Ubuntu-based made ;)
* Suggest you to change your resolv.conf temporarily so you can use Consul as your DNS server

Now you are part of the cluster! Browse to http://localhost:8500/ui ;)

So you know the SERVICE REGISTRY LAYER, but there are more LAYERS, remember?

The LOAD BALANCER LAYER is not only registering itself in Consul, it's reading info from the registry too! The scenario is that NGINX is a reverse proxy for APP1. So there's an application (consul-template) that constantly reads thata from Consul and, if there are any changes, it recreates NGINX's config file and reloads the daemon. NICE!

## How can you play with the demo

Let's get to the interesting part.

REALLY, I'm serious, if you didn't setup Consul as you DNS server do it NOW.

Then:
* curl http://app1.service.consul:8080/greeting; echo
* curl http://nginx.service.consul/greeting; echo

Nice! The response will be the same in both calls, but we'll improve that in a little bit.

Docker-Compose let's us do a simple yet powerful trick: scale the apps it defines. In this scenario the true power of the Servicy Registry kicks in.

So you can for instance:
* docker-compose scale app1=4 (I don't recommend getting this number high 'cause - you know - springboot is JAVA, the resources eater)
* docker-compose scale nginx=3 (5,7,10)

Now redo the previous test:
* curl http://app1.service.consul:8080/greeting; echo
* curl http://nginx.service.consul/greeting; echo

Preferably this way:
* curl http://app1.service.consul:8080/greeting && curl http://nginx.service.consul/greeting

And LOTS of times.

The hostname in the RESPONSE should change each time (or maybe not each time using app1... because of DNS cache).

We could then play with the size of the layers independently (horizontal scaling simulated).

If you are curious you can 'cat' the /etc/nginx/nginx.conf file of the nodes running NGINX, change the size of the APP1 LAYER and 'cat' again ;)


## Configuration files

There are some folders in the repo that configures the containeres:
* consul-app-config/consul (configures the consul agent for the APP1 LAYER)
* consul-nginx-config
** consul-template (configures the consul-template service)
** consul (configures the consul agent for the NGINX LAYER)
* consul-srv-config/consul (configures the consul agent for the SERVICE REGISTRY LAYER)

You are invited to play with it, mess, expand the scenario, ...

## Etc

Hope you enjoy.
