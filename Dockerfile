FROM archlinux:multilib-devel

RUN pacman-key --init && \
    pacman -Syu --noconfirm && \
    systemctl restart gpg-agent.socket && \
    pacman -Syu --noconfirm git python python-yaml ccache

WORKDIR /app
ENV PYTHONPATH "${PYTHONPATH}:/app/"
ENV PYTHONUNBUFFERED=1

COPY src /app/src
COPY main.py /app/
COPY makepkg* /app/

ENTRYPOINT [ "python", "/app/main.py" ]
