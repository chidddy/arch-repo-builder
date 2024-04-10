FROM archlinux:multilib-devel

RUN gpg --recv-keys --keyserver hkps://keys.openpgp.org 3B94A80E50A477C7 && \
    pacman-key --init && pacman -Syu --noconfirm git python python-yaml ccache

WORKDIR /app
ENV PYTHONPATH "${PYTHONPATH}:/app/"
ENV PYTHONUNBUFFERED=1

COPY src /app/src
COPY main.py /app/
COPY makepkg* /app/

ENTRYPOINT [ "python", "/app/main.py" ]
