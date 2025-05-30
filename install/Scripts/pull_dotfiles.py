#!/usr/bin/env python3

import subprocess
from pathlib import Path
import shutil

# Repo containing your dotfiles
DOTFILES_REPO = Path.home() / ".dotfiles"

# Which files to apply to $HOME (same as in sync script)
DOTFILES_TO_APPLY = [
    ".bashrc",
    ".config/hypr",
    ".config/waybar",
    ".config/neofetch"
]

def pull_repo():
    print("[*] Pulling latest dotfiles from remote...")
    try:
        subprocess.run(["git", "pull"], cwd=DOTFILES_REPO, check=True)
        print("[✓] Pulled successfully.")
    except subprocess.CalledProcessError:
        print("[!] Failed to pull from remote.")

def apply_dotfiles():
    print("[*] Applying dotfiles to home directory...")

    for item in DOTFILES_TO_APPLY:
        src = DOTFILES_REPO / item
        dst = Path.home() / item

        if not src.exists():
            print(f"[!] Skipped {item} (not found in repo)")
            continue

        if dst.exists():
            if dst.is_dir():
                shutil.rmtree(dst)
            else:
                dst.unlink()

        if src.is_dir():
            shutil.copytree(src, dst)
        else:
            shutil.copy2(src, dst)

        print(f"[✓] Applied {item}")

def main():
    if not DOTFILES_REPO.exists():
        print("[!] Dotfiles repo not found.")
        return

    pull_repo()
    apply_dotfiles()

if __name__ == "__main__":
    main()
