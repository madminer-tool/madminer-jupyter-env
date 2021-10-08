# Madminer jupyter env

[![Docker pulls][docker-pulls-badge]][docker-pulls-link]
[![MIT license][mit-license-badge]][mit-license-link]


## About
This repository defines the Docker image that will be used in the [Madminer tutorial][madminer-tutorial].
The tutorial is a good starting point to get familiarized with the [Madminer package][madminer-package].

The provided Docker image contains all the necessary binaries and dependencies to generate events with 
[MadGraph 5][madgraph-website], [Pythia 8][pythia-website] and [Delphes][delphes-website] using Madminer, 
to later on perform Machine Learning analysis.


## Docker
To build a new Docker image for local testing:
```shell script
make build
```

To publish a new Docker image, bump up the `VERSION` number and execute:

```shell script
export DOCKERUSER=<your_dockerhub_username>
export DOCKERPASS=<your_dockerhub_password>
make push
```


[docker-pulls-badge]: https://img.shields.io/docker/pulls/madminertool/madminer-jupyter-env.svg
[docker-pulls-link]: https://hub.docker.com/r/madminertool/madminer-jupyter-env
[mit-license-badge]: https://img.shields.io/badge/License-MIT-blue.svg
[mit-license-link]: https://github.com/madminer-tool/madminer-jupyter-env/blob/master/LICENSE

[delphes-website]: https://cp3.irmp.ucl.ac.be/projects/delphes
[madgraph-website]: https://launchpad.net/mg5amcnlo
[madminer-package]: https://github.com/madminer-tool/madminer
[madminer-tutorial]: https://madminer-tool.github.io/madminer-tutorial
[pythia-website]: https://pythia.org/
