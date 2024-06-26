import os
import sys
import subprocess
from .config import BASE_PATH, C

repo_db_path = os.path.join(BASE_PATH, C.global_settings.repository)
repo_dir = os.path.dirname(repo_db_path)
repo_name = (C.global_settings.repository).split('/')[-1].split('.')[0]

pacman_conf_path = "/etc/pacman.conf"


def refresh_local_repo():
    subprocess.run(
        [
            "pacman",
            "-Sy",
        ]
    )


def add_local_repo():
    if os.path.exists(repo_db_path):
        _pacman_append = f"""
[{repo_name}]
SigLevel = Optional
Server = file://{repo_dir}
"""

        with open(pacman_conf_path, "a") as f:
            f.write(_pacman_append)
            f.close()

        with open(pacman_conf_path, "r") as f:
            print("!!!pacman.conf")
            print(f.read())

        refresh_local_repo()
