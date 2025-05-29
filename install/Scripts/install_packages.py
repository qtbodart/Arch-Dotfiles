import subprocess
from pathlib import Path

PKG_PATH = Path.home() / ".dotfiles/install/pkglist.txt"
AUR_PATH = Path.home() / ".dotfiles/install/aurlist.txt"

def install_package(name, installer="pacman"):
    """Installs the package `name` using `installer`, if not already installed."""
    try:
        subprocess.run(["pacman", "-Q", name], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print(f"[✓] {name} is already installed.")
    except subprocess.CalledProcessError:
        print(f"[*] Installing {name}...")
        try:
            subprocess.run(["sudo", installer, "-S", "--noconfirm", name], check=True)
        except subprocess.CalledProcessError:
            print(f"[!] Failed to install {name}.")

def install_from_list_file(filename, installer="pacman"):
    """Installs all packages listed in the file `filename` using the given installer."""
    if not filename.exists():
        print(f"[!] File not found: {filename}")
        return
    
    with filename.open() as f:
        packages = [line.strip() for line in f if line.strip() and not line.startswith("#")]

    for package in packages:
        install_package(package, installer)

if __name__ == '__main__':
    print("[*] Updating system package list...")
    try:
        subprocess.run(["sudo", "pacman", "-Syu", "--noconfirm"], check=True)
    except subprocess.CalledProcessError:
        print("[!] System update failed. Please check your network or mirrorlist.")
        exit()

    print("\n[*] Installing official packages...")
    install_from_list_file(PKG_PATH)

    print("\n[*] Installing AUR packages...")
    install_from_list_file(AUR_PATH, "paru")

    print("\n[✓] Package installation complete.")
