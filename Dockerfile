FROM archlinux:latest

# RUN pacman-key --init && \
#     pacman -Syu --noconfirm && \
#     systemctl restart gpg-agent.socket && \
#     pacman -Syu --noconfirm git python python-yaml ccache

RUN pacman -Syu --noconfirm --needed base base-devel git asp && \
    useradd -d /home/makepkg makepkg && \
    mkdir -p /home/makepkg/{.config/pacman,.gnupg,out} && \
    echo 'MAKEFLAGS="-j$(nproc)"' >> /home/makepkg/.config/pacman/makepkg.conf && \
    echo 'keyserver-options auto-key-retrieve' > /home/makepkg/.gnupg/gpg.conf && \
    chown -R makepkg:users /home/makepkg && \
    pacman -Syu --noconfirm --needed git python python-yaml ccache

WORKDIR /app
ENV PYTHONPATH "${PYTHONPATH}:/app/"
ENV PYTHONUNBUFFERED=1

COPY src /app/src
COPY main.py /app/
COPY makepkg* /app/
COPY sudoers /etc/sudoers

ENTRYPOINT [ "python", "/app/main.py" ]
