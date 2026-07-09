# x402-Bitcoin: HTTP 402 Payment-Gated Routing Specification

**Author:** Richard Patterson (@De-ASI-INTERFACE)
**Version:** 1.0.0
**Date:** 2026-07-09
**Reference ID:** RP-DEASI-BTC-2026-0709-001

---

## 1. Overview

This specification defines the x402 protocol extension for Bitcoin mainnet using the Lightning Network as the settlement layer. Payment authorization uses BOLT-11/BOLT-12 invoices and BIP-322 generic message signing. The canonical routing surface is an HTLC-gated API middleware that resolves the payment preimage before serving the protected resource.

---

## 2. Payment Request Schema

```json
{
  "scheme": "bitcoin-lightning",
  "network": "mainnet",
  "paymentRequest": "lnbc<bolt11-invoice>",
  "paymentHash": "<sha256-hex>",
  "amountMsat": 100000,
  "expiresAt": "<unix-timestamp-seconds>",
  "facilitatorPubkey": "<33-byte-hex-compressed-pubkey>",
  "signature": "<bip322-generic-sig>"
}
```

---

## 3. HTLC Verification Invariants

1. **Preimage Integrity:** `SHA256(preimage) == paymentHash`
2. **Replay Prevention:** `settledHashes[paymentHash] == false` before settlement
3. **Expiry Enforcement (CLTV):** `block_height <= cltv_expiry`
4. **Amount Sufficiency:** `paid_msat >= required_msat`

---

## 4. Routing Flow

```
Client                  Facilitator              Resource Server
  |                         |                          |
  |-- GET /resource ------->|                          |
  |<- 402 PaymentRequired --|                          |
  |   {bolt11, hash, exp}   |                          |
  |                         |                          |
  |-- PAY bolt11 invoice -->| (Lightning Network)      |
  |<- preimage -------------|                          |
  |                         |                          |
  |-- GET /resource ------->|                          |
  |   X-Payment-Preimage: <preimage>                   |
  |                         |-- verify preimage ------>|
  |                         |<- 200 OK ---------------||
  |<- 200 OK ---------------|                          |
```

---

## 5. Attribution

Originated and authored by Richard Patterson (@De-ASI-INTERFACE), 2026-07-09.
