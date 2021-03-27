FROM fjolsvin/gitpod-python:latest
RUN set -ex && \ 
  cargo install -j`nproc` pyoxidizer
RUN set -ex && \ 
  cargo install -j`nproc` tokei
RUN set -ex && \ 
  cargo install -j`nproc` just
RUN set -ex && \ 
  sudo install-packages \
  pkg-config libssl-dev libxcb-composite0-dev libx11-dev
RUN set -ex && \ 
  cargo install -j`nproc` nu  --features=extra
RUN set -ex && \ 
  find ~/.cargo/bin -type f -name 'nu*' | xargs -I {} sudo mv {} /usr/local/bin/ && \
  nu --version
RUN set -ex && \ 
  curl -fsSl https://raw.githubusercontent.com/da-moon/provisioner-scripts/master/bash/installer/rust-core-utils | bash
ENV WORKDIR="/workspace/signum"
ENV POETRY_VIRTUALENVS_IN_PROJECT="true"
RUN sudo python3 -m pip install pex dephell[full] && \
  dephell --version && \
  pex --version
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
RUN set -ex && \ 
  curl -fsSL https://starship.rs/install.sh | sudo bash -s -- --force && \
  echo 'eval "$(starship init bash)"' | tee -a ~/.bashrc && \
  echo 'eval "$(starship init bash)"' | sudo tee -a /root/.bashrc
RUN set -ex && \ 
  curl -fsSl https://raw.githubusercontent.com/da-moon/provisioner-scripts/master/bash/installer/node | bash
ENV SHELL="/usr/local/bin/nu"
ENV PATH="$PATH:${WORKDIR}/dist/pex"
ENV PATH="$PATH:${WORKDIR}/contrib/scripts/utils"
RUN set -ex && \ 
  nu -c 'config set path $nu.path' && \
  nu -c 'config set env  $nu.env'
ENV PIP_USER=false
WORKDIR "${WORKDIR}"
RUN set -ex && \ 
  sudo apt-get autoremove -y && \
  sudo apt-get clean -y && \
  sudo rm -rf "/tmp/*"
