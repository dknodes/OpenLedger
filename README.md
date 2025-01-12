# OpenLedger
OpenLedger Node 


# Registration and X-Server Installation

To complete the registration on [OpenLedger Testnet](https://testnet.openledger.xyz/?referral_code=at4wlvxip4), you need to install an X-server on your local machine.

### Step 1: Installing the X-Server

**For Windows:**
- Use **MobaXterm** for the X-server.

**For macOS:**
- Install **XQuartz** via **Homebrew**:
  ```bash
  brew install --cask xquartz
```
After installation, run XQuartz:

```
open -a XQuartz
```

**For Linux:**
	The X-server is usually pre-installed in the system.


```bash
sudo bash -c 'git clone https://github.com/dknodes/OpenLedger.git && cd OpenLedger && chmod ugo+x OpenLedger.sh && ./OpenLedger.sh'
```
