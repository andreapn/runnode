# FORTA SCAN NODE Setup
echo "Install Docker for Ubuntu..."

# Remove old docker version
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# Setup docker repo
sudo apt-get update 
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Check docker version
docker -v

# Add network address docker
sudo bash -c 'cat <<EOF > /etc/docker/daemon.json
{
   "default-address-pools": [
        {
            "base":"172.17.0.0/12",
            "size":16
        },
        {
            "base":"192.168.0.0/16",
            "size":20
        },
        {
            "base":"10.99.0.0/16",
            "size":24
        }
    ]
}
EOF'
sudo systemctl restart docker

# Install Forta CLI
sudo curl https://dist.forta.network/pgp.public -o /usr/share/keyrings/forta-keyring.asc -s
echo 'deb [signed-by=/usr/share/keyrings/forta-keyring.asc] https://dist.forta.network/repositories/apt stable main' | sudo tee -a /etc/apt/sources.list.d/forta.list
sudo apt-get update
sudo apt-get install -y forta

# Initialize Forta, replace MyFortaPassPhrase by your pass
forta init --passphrase MyFortaPassPhrase

# Setup Optimism Chain, if wanna scan another Chain, use config at this page: https://docs.forta.network/en/latest/scanner-quickstart/
user=`whoami`
cat <<EOF > /home/${user}/.forta/config.yml
chainId: 10
scan:
  jsonRpc:
    url: https://mainnet.optimism.io
trace:
  enabled: false
EOF

# Config systemd
sudo mkdir /etc/systemd/system/forta.service.d/
sudo bash -c 'cat <<EOF > /etc/systemd/system/forta.service.d/env.conf
[Service]
Environment="FORTA_DIR=/home/userabc/.forta"
Environment="FORTA_PASSPHRASE=MyFortaPassPhrase"
EOF'
