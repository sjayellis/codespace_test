FROM ubuntu:focal

ENV LANG="C.UTF-8"

COPY requirements.txt /tmp/requirements.txt

# Install basic build tools
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python-pip-whl \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Verify expected build and debug tools are present
RUN apt-get update \
    && apt-get -y install python3-dev \
    # Clean up
    && apt-get autoremove -y && apt-get clean -y

RUN python3 -m pip install -r /tmp/requirements.txt && yes | pip uninstall sympy

ENV SHELL=/bin/bash \
    DOCKER_BUILDKIT=1

ENTRYPOINT [ "/usr/local/share/docker-init.sh", "/usr/local/share/ssh-init.sh"]
CMD [ "sleep", "infinity" ]
