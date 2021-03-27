# https://github.com/pmady/Docker/blob/master/python3.7/Dockerfile

# ─── EXAMPLE BUILD COMMAND ──────────────────────────────────────────────────────
# docker build --file pex.Dockerfile --build-arg GITHUB_ACTOR=$GITHUB_ACTOR --build-arg GITHUB_TOKEN=$GITHUB_TOKEN --tag fjolsvin/cli:latest .
# ────────────────────────────────────────────────────────────────────────────────


FROM python:slim-buster AS base
SHELL ["/bin/bash", "-c"]
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN set -ex && \
  apt-get update -qq  > /dev/null 2>&1 && \
  apt-get install -yqq curl make sudo git gcc  > /dev/null 2>&1
ARG USER=github
ENV USER $USER
ARG UID="1000"
ENV UID $UID
RUN set -ex && \
  useradd --user-group --create-home --shell /bin/bash --uid "$UID" "${USER}" > /dev/null 2>&1
RUN set -ex && \
  sed -i \
  -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' \
  -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
  /etc/sudoers
RUN set -ex && \
  usermod -aG root,sudo "${USER}"  > /dev/null 2>&1
USER ${USER}
SHELL ["/bin/bash", "-c"]
ARG GITHUB_ACTOR
ENV GITHUB_ACTOR $GITHUB_ACTOR
ARG GITHUB_TOKEN
ENV GITHUB_TOKEN $GITHUB_TOKEN
ENV HOME="/home/${USER}"
ENV PIP_USER=false
ENV POETRY_HOME="${HOME}/.poetry"
ENV PATH="${PATH}:${HOME}/.local/bin"
ENV PATH="${PATH}:${POETRY_HOME}/bin"
ENV WORKSPACE="/workspace"
RUN set -ex && \
  sudo mkdir -p "${WORKSPACE}" && \
  sudo chown "$(id -u):$(id -g)" "${WORKSPACE}" -R && \
  mkdir -p "${HOME}/.local/bin" && \
  echo 'PATH="${PATH}:${HOME}/.local/bin"' | tee -a ~/.bashrc > /dev/null && \
  mkdir -p "${POETRY_HOME}/bin" && \ 
  echo '[ -r ${POETRY_HOME}/env ] && . ${POETRY_HOME}/env' | tee -a ~/.bashrc > /dev/null && \
  curl -fsSL \
  https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3  > /dev/null 2>&1 && \
  poetry --version
RUN set -ex && \
  sudo python3 -m pip install pex  > /dev/null 2>&1  && \
  pex --version

WORKDIR "${WORKSPACE}"
RUN git clone "https://$GITHUB_ACTOR:$GITHUB_TOKEN@github.com/da-moon/python-cli.git"  > /dev/null 2>&1
WORKDIR "${WORKSPACE}/python-cli"
RUN set -ex && \
  poetry install --no-dev
RUN set -ex && \
  pex \
  --disable-cache \
  --compile \
  --jobs "$(nproc)" \
  --entry-point "project_template.__main__:main" \
  --output-file "dist/pex/cli" \
  . && \
  chmod +x dist/pex/cli && \
  dist/pex/cli version
FROM python:slim-buster
COPY --from=base "/workspace/python-cli/dist/pex/cli" "/entrypoint"
ENTRYPOINT ["python3", "/entrypoint"]
CMD ["--help"]