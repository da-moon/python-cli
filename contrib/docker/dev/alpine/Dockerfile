# this image is used with vscode remote-developer extension pack to setup a development
# ────────────────────────────────────────────────────────────────────────────────
FROM fjolsvin/vscode-python:latest
# ────────────────────────────────────────────────────────────────────────────────
RUN set -ex && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk upgrade --no-cache -U -a
USER operator
#
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────── I ──────────
#   :::::: E N S U R I N G   C O M P I L E D   T O O L   A V A I L A B I L I T Y : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#
RUN sudo usermod --shell /bin/bash "operator"
ENV WORKDIR="/workspace"
ENV POETRY_VIRTUALENVS_IN_PROJECT="true"
#
# ────────────────────────────────────────────────────────────────────────────────────── I ──────────
#   :::::: I N S T A L L I N G   P I P   P A C K A G E S : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────────────────────────────────────────
#

RUN python3 -m pip install pex dephell[full] && \
  dephell --version && \
  pex --version
# * numpy <-> fsutils
# * py3-dateutil <-> python-dateutil
RUN sudo apk add --no-cache py3-setuptools py3-numpy py3-numpy-dev py3-virtualenv py3-dateutil

#
# ────────────────────────────────────────────────────────────── I ──────────
#   :::::: P Y I N S T A L L E R : :  :   :    :     :        :          :
# ────────────────────────────────────────────────────────────────────────
#
USER root
RUN apk -U --no-cache add \
  make gcc musl-dev libffi-dev openssl-dev zlib-dev cmocka-dev \
  git
RUN sudo python3 -m pip install pycrypto
# ─── BUILD PYTHON-INSTALLER WITH BOOTLOADER FOR MUSL ────────────────────────────
USER operator
RUN git clone \
  --depth 1 \
  --single-branch \
  --branch \
  master https://github.com/pyinstaller/pyinstaller.git /tmp/pyinstaller 

WORKDIR /tmp/pyinstaller/bootloader
RUN export CFLAGS="-Wno-stringop-overflow -Wno-stringop-truncation"; \
  chmod +x ./waf ; \
  ./waf configure all
RUN sudo python3 -m pip install ..
RUN rm -rf /tmp/pyinstaller
# ────────────────────────────────────────────────────────────────────────────────
RUN set -ex && \ 
  cargo install -j`nproc` pyoxidizer
ENV PIP_USER=false
ENV SHELL="/usr/bin/nu"
ENV PATH="$PATH:${WORKDIR}/dist/pex"
ENV PATH="$PATH:${WORKDIR}/contrib/scripts/utils"
RUN sudo apk -U --no-cache add tree
RUN nu -c 'config set path $nu.path' && \
  nu -c 'config set env  $nu.env'
RUN sudo usermod --shell "${SHELL}" "operator"
WORKDIR "${WORKDIR}"
