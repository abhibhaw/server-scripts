#!/bin/sh

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
  echo "Please run as root"
  exit 1
fi

# Variables
USERNAME=$1

# Check if username is provided
if [ -z "$USERNAME" ]; then
  echo "Usage: $0 <username>, no username provided taking default as autopilot"
  USERNAME="autopilot"
fi

SUDOERS_FILE="/etc/sudoers.d/$USERNAME"
SSH_DIR="/home/$USERNAME/.ssh"
AUTHORIZED_KEYS_FILE="$SSH_DIR/authorized_keys"
PRIVATE_KEY_FILE="/root/$USERNAME-private-key"

# Create the user with no password
useradd -m -s /bin/sh "$USERNAME"

# Create the .ssh directory and set the correct permissions
mkdir -p "$SSH_DIR"
chown "$USERNAME:$USERNAME" "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -N "" -f "$SSH_DIR/id_rsa"
chown "$USERNAME:$USERNAME" "$SSH_DIR/id_rsa" "$SSH_DIR/id_rsa.pub"

# Set up the SSH directory and authorized_keys file
cat "$SSH_DIR/id_rsa.pub" > "$AUTHORIZED_KEYS_FILE"
chown -R "$USERNAME:$USERNAME" "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 600 "$AUTHORIZED_KEYS_FILE"

# Add user to the sudo group
usermod -aG sudo "$USERNAME"
# Add user to the sudo group
usermod -aG docker "$USERNAME"

# Create sudoers file for the user
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > "$SUDOERS_FILE"
chmod 440 "$SUDOERS_FILE"
# Disable password authentication for the user
passwd -l "$USERNAME"

# Echo the private key
echo "Private key for user $USERNAME:"
cat "$SSH_DIR/id_rsa" > "$PRIVATE_KEY_FILE"
cat "$PRIVATE_KEY_FILE"

echo "User $USERNAME created and configured successfully."