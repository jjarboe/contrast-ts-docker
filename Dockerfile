FROM ubuntu:18.04

ENV IMAGE Contrast-3.6.0.326-NO-CACHE.sh
ENV LIC_FILE contrast-03-31-2020.lic

RUN apt update && apt install -y libaio1 libaio-dev libnuma1 libnuma-dev sudo
COPY /${IMAGE} /install-input /${LIC_FILE} /tmp/
COPY /start-container.sh /
RUN /bin/sh /tmp/${IMAGE} -c -q < /tmp/install-input
RUN rm -f /tmp/${IMAGE} /tmp/install-input /tmp/${LIC_FILE}

CMD /start-container.sh
