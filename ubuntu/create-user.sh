#!/bin/sh

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
  echo "Please run as root"
  exit 1
fi

# Variables
USERNAME=$1
SUDOERS_FILE="/etc/sudoers.d/$USERNAME"
SSH_DIR="/home/$USERNAME/.ssh"
AUTHORIZED_KEYS_FILE="$SSH_DIR/authorized_keys"
PRIVATE_KEY_FILE="/root/$USERNAME-private-key"

# Check if username is provided
if [ -z "$USERNAME" ]; then
  echo "Usage: $0 <username>, no username provided taking default as autopilot"
  USERNAME="autopilot"
fi

# Create the user with no password
useradd -m -s /bin/sh "$USERNAME"

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -N "" -f "$SSH_DIR/id_rsa"

# Set up the SSH directory and authorized_keys file
mkdir -p "$SSH_DIR"
cat "$SSH_DIR/id_rsa.pub" > "$AUTHORIZED_KEYS_FILE"
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

# Echo the private key
echo "Private key for user $USERNAME:"
cat "$SSH_DIR/id_rsa" > "$PRIVATE_KEY_FILE"
cat "$PRIVATE_KEY_FILE"

echo "User $USERNAME has been created with SSH key access and granted sudo privileges without a password prompt."
