#!/usr/bin/env python3

import subprocess
from pathlib import Path
import shutil

DOTFILES_REPO = Path.home() / ".dotfiles"
DOTFILES_TO_SYNC = [
    ".bashrc",
    ".config/hypr",
    ".config/waybar",
    ".config/neofetch"
]

def copy_dotfiles():
    print("[*] Copying dotfiles to repo...")

    for item in DOTFILES_TO_SYNC:
        src = Path.home() / item
        dst = DOTFILES_REPO / item

        if not src.exists():
            print(f"[!] Skipped {item} (not found)")
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

        print(f"[✓] Synced {item}")

def git_commit_and_push():
    print("[*] Committing changes...")

    try:
        subprocess.run(["git", "add", "."], cwd=DOTFILES_REPO, check=True)
        subprocess.run(["git", "commit", "-m", "Update dotfiles"], cwd=DOTFILES_REPO, check=True)
    except subprocess.CalledProcessError:
        print("[!] Nothing to commit or error during commit.")

    print("[*] Pushing to remote...")
    try:
        subprocess.run(["git", "push"], cwd=DOTFILES_REPO, check=True)
        print("[✓] Dotfiles pushed successfully.")
    except subprocess.CalledProcessError:
        print("[!] Failed to push dotfiles.")

def main():
    if not DOTFILES_REPO.exists():
        print(DOTFILES_REPO)
        print("[!] Dotfiles repo not found.")
        return

    copy_dotfiles()
    git_commit_and_push()

if __name__ == "__main__":
    main()
