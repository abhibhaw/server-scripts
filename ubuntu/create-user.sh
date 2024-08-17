#!/bin/sh

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
  echo "Please run as root"
  exit 1
fi

# Variables
USERNAME=$1
SSH_PUBLIC_KEY=$2
SUDOERS_FILE="/etc/sudoers.d/$USERNAME"
SSH_DIR="/home/$USERNAME/.ssh"
AUTHORIZED_KEYS_FILE="$SSH_DIR/authorized_keys"

# Check if username and SSH public key are provided
if [ -z "$USERNAME" ] || [ -z "$SSH_PUBLIC_KEY" ]; then
  echo "Usage: $0 <username> <ssh_public_key>"
  exit 1
fi

# Create the user with no password
useradd -m -s /bin/sh "$USERNAME"

# Set up the SSH directory and authorized_keys file
mkdir -p "$SSH_DIR"
echo "$SSH_PUBLIC_KEY" > "$AUTHORIZED_KEYS_FILE"
chown -R "$USERNAME:$USERNAME" "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 600 "$AUTHORIZED_KEYS_FILE"

# Add user to the sudo group
usermod -aG sudo "$USERNAME"

# Create a sudoers file for the user to allow passwordless sudo
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > "$SUDOERS_FILE"

# Set the correct permissions for the sudoers file
chmod 440 "$SUDOERS_FILE"

# Disable password authentication for the user
passwd -l "$USERNAME"

echo "User $USERNAME has been created with SSH key access and granted sudo privileges without a password prompt."
