---
title: Dependencies
menu: true
weight: 2
---

Please make sure that you have the following dependencies installed:

- [Docker](https://docker.com)

## Manage Docker As A Non-root User

The Docker daemon binds to a Unix socket instead of a TCP port.
By default that Unix socket is owned by the user root and other users can only access it using sudo.

The Docker daemon always runs as the root user.

If you do not want to preface the docker command with sudo, create a Unix group called docker and add users to it.
When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.

