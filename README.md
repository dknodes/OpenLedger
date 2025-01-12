# OpenLedger

# Registration and X-Server Installation

To complete the registration on [OpenLedger Testnet](https://testnet.openledger.xyz/?referral_code=at4wlvxip4), you need to install an X-server on your local machine.

### Step 1: Installing the X-Server

**For Windows:**
- Use the **MobaXterm** program to work with the X-server.

**For macOS:**
- Install **XQuartz** using **Homebrew**:

  `brew install --cask xquartz`

- After installation, launch XQuartz:

  `open -a XQuartz`

**For Linux:**
- The X-server is usually pre-installed in the system.

### Step 2: Connecting to the Server via SSH

Open your terminal and use the following command to connect to the server with X11 forwarding enabled:

`ssh -X root@ip`

### Step 3: Renting Servers at AEZA

To rent servers, go to the AEZA platform. You will need a server with the following specifications:

- **RAM**: 4GB
- **Storage**: 60GB
- **Processor**: 2 Cores
- **System**: Ubuntu 24.04

Once you select a server, follow the instructions on the platform to complete the rental.

> [AEZA](https://aeza.net/?ref=583653) for renting servers and getting bonuses.


### Step 4: Execute the command

```bash
sudo bash -c 'git clone https://github.com/dknodes/OpenLedger.git && cd OpenLedger && chmod ugo+x OpenLedger.sh && ./OpenLedger.sh'
```

## Stay Updated:

For the latest updates and installation instructions, follow us on:
- [Telegram](https://t.me/dknodes)
- [Twitter](https://twitter.com/dknodes)
