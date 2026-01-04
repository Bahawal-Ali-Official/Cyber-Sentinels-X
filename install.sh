#!/bin/bash

# 1. System Updates & Dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install python3 python3-pip python3-venv git wget curl unzip nikto golang-go -y

# 2. Python Libraries (Using a Virtual Environment)
echo "[+] Creating Python Virtual Environment..."
python3 -m venv venv
source venv/bin/activate

echo "[+] Installing Python requirements..."
pip install --upgrade pip
pip install -r python_requirements.txt

# Install Playwright and its system dependencies
pip install playwright
playwright install --with-deps

# 3. Go Tools Setup
echo "[+] Configuring Go Path..."
if ! grep -q "GOPATH" ~/.bashrc; then
    echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
fi
export PATH=$PATH:$(go env GOPATH)/bin

# 4. Install Recon Tools
echo "[+] Installing Go Tools..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest

# 5. Install Findomain
echo "[+] Installing Findomain..."
wget -O findomain-linux.zip https://github.com/Findomain/Findomain/releases/download/9.0.4/findomain-linux.zip
unzip -o findomain-linux.zip
chmod +x findomain
sudo mv findomain /usr/local/bin/
rm findomain-linux.zip

# 6. Install Bettercap
sudo apt install bettercap -y

echo "------------------------------------------------"
echo "Setup Complete! Restart your terminal."
echo "To use your Python tools, always run: source venv/bin/activate"
echo "------------------------------------------------"
source venv/bin/activate
