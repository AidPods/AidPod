# 🩺 AidPod — A Decentralized Fundraising Platform for Verified Medical Campaigns, changing lives one ADA at a time

AidPod is a decentralized application (dApp) built on the **Cardano blockchain** to raise funds for **hospital-verified medical issues**. It provides a transparent, accountable, and decentralized solution to medical fundraising, where contributors lock their ADA into smart contracts and funds are released **milestone-by-milestone** through a **2-of-3 multisig validation** process involving the platform, recipient, and a trusted third-party (e.g., NGO).

---

## 🚀 Table of Contents

- [📌 Features](#-features)
- [📚 How It Works](#-how-it-works)
- [🏗 Architecture](#-architecture)
- [👥 User Roles](#-user-roles)
- [🔐 Security and Privacy](#-security-and-privacy)
- [⚙️ Tech Stack](#️-tech-stack)
- [🖼 Campaign NFT Badges](#-campaign-nft-badges)
- [💡 Future Improvements](#-future-improvements)
- [🛠 Getting Started (Dev)](#-getting-started-dev)
- [📄 License](#-license)

---

## 📌 Features

- ✅ Verified medical campaigns (hospital documents and urgency score)
- 🔒 ADA donations are locked via Aiken smart contracts
- 🔁 Milestone based fund release with 2-of-3 multisig (platform, recipient, NGO)
- 🏥 Role based access for hospitals, donors, NGOs, and patients
- 📊 Campaign urgency ranked by hospital metadata (e.g., severity, time-sensitivity)
- 🏅 NFT badge for donors per campaign (CIP-68 standard)
- 🔍 Community flagging system and admin intervention for fraud prevention

---

## 📚 How It Works

1. **Patient Campaign Creation**  
   - A patient creates a campaign and uploads medical documentation.
   - A hospital or admin verifies the documents and submits urgency scores.

2. **Donation Phase**  
   - Donors browse campaigns and contribute ADA using a Cardano wallet (Nami, Eternl, Typhon etc).
   - Contributions are locked in a smart contract.

3. **Fund Release**  
   - Funds are released in predefined milestones.
   - Each release requires approval from **2 of 3 parties** (platform, NGO, recipient).

4. **Completion or Refund**  
   - Campaigns are either fully disbursed or donors are refunded if goals aren’t met.

---

## 🏗 Architecture

### 🧠 On-chain (Smart Contracts in Aiken)
- ADA locking per campaign
- Milestone-based unlock logic
- Optional refund mechanism

### 🌐 Off-chain (Backend Logic via Mesh.js)
- Document verification and storage
- Multisig signature coordination
- Campaign status tracking
- Milestone submission/review

### 🖥 Frontend (React/Svelte + Mesh.js)
- Role-based dashboards
- Wallet connect and ADA contribution
- Campaign ranking, NFT badge display

---

## 👥 User Roles

| Role      | Responsibilities                                     |
|-----------|-------------------------------------------------------|
| **Patient**   | Submit documents, create campaigns, request release |
| **Hospital**  | Verify documents, assign urgency scores            |
| **Donor**     | Browse, donate, and receive NFT badges             |
| **NGO**       | Validate milestone releases                        |
| **Admin**     | Manage platform, handle disputes and fraud         |

---

## 🔐 Security and Privacy

- All medical documents are stored securely off-chain (e.g., Supabase/Firebase).
- On-chain stores only the hash of documents to ensure integrity and verification.
- No sensitive data is exposed publicly (GDPR/HIPAA compliant principles).
- Community reporting tools help identify fraud attempts.

---

## ⚙️ Tech Stack

| Layer          | Tech Used                              |
|----------------|----------------------------------------|
| Smart Contract | Aiken                                  |
| Backend        | Node.js, Mesh.js, Supabase             |
| Frontend       | React.js (or Svelte)                   |
| Wallets        | Mesh.js support (Nami, Eternl, Lace)   |
| NFT Standard   | CIP-68 (Reference NFT with metadata)   |
| Storage        | Firebase/Supabase (document hosting)   |

---

## 🖼 Campaign NFT Badges

Each donor receives an NFT badge per campaign, containing:
- Campaign ID
- Timestamp of contribution
- Tier (based on amount donated)
- Campaign image or logo

NFTs follow **CIP-68** standard and are viewable in Cardano wallets.

---

## 💡 Future Improvements
- Telegram & WhatsApp bot integration for campaign alerts
- Multilingual support and mobile app

---

## 🛠 Getting Started (Dev)

### Prerequisites
- Node.js & npm
- Git
- Docker (optional)
- Cardano wallet (Nami or Eternl)


## Note: This file is subject to change.

### Clone and Install

```bash
git clone https://github.com/your-org/AidPod.git
cd AidPod
npm install


