# docker-registry
Auto generate certs, making deploy a private docker registry easily.


# How
1. deploy docker registry with `sh run_docker_registry.sh`
2. put daemon.json in `/etc/docker/daemon.json` on all node server
3. all node server add hosts with `echo "docker_registry_server_ip docker-registry.io" >> /etc/hosts`

*note: maybe set tls & tlsverify => false in `daemon.json` can solve a lots problem.
