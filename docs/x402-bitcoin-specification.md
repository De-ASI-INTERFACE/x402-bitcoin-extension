# x402-Bitcoin Specification

**Author:** Richard Patterson (@De-ASI-INTERFACE) | **Version:** 1.0.0 | **Date:** 2026-07-09

---

## 1. Overview

The x402-Bitcoin Extension binds HTTP 402 Payment Required to Bitcoin's Lightning Network payment channel layer. The primary settlement path uses BOLT-11 invoices: the server generates a BOLT-11 invoice embedding a payment hash, the client pays via Lightning, and the server verifies settlement by observing preimage revelation. An on-chain fallback uses BIP-174 PSBT with an OP_RETURN output committing to the resource hash.

## 2. Primary Flow (Lightning)

```
1. Client → Server:  GET /resource
2. Server → Client:  402 + X-Payment-Requirements: {bolt11_invoice, amount_msat, payment_hash, expiry}
3. Client:           Pay invoice via Lightning node (lnd/cln/eclair)
4. Server:           Detect preimage revelation via Lightning subscription
5. Server → Client:  200 + resource (upon preimage confirmation)
```

## 3. Fallback Flow (On-Chain PSBT)

```
1. Server → Client:  402 + X-Payment-Requirements: {psbt_template, amount_sats, recipient_addr, resource_hash}
2. Client:           Sign PSBT (BIP-174), add OP_RETURN output: OP_RETURN <resource_hash>
3. Client:           Broadcast transaction
4. Client → Server:  GET /resource + X-Payment-Proof: {txid, vout_index, block_height}
5. Server:           Verify OP_RETURN payload, confirm 6 blocks, serve resource
```

## 4. BOLT-11 Invoice Parameters

```
payment_hash:   SHA-256 preimage hash (32 bytes)
amount_msat:    Payment amount in millisatoshis
description:    x402:<resource_hash_hex>
expiry:         300 seconds (configurable)
cltv_expiry:    40 blocks
```

## 5. Security Properties

- **HTLC atomicity:** Payment either settles with preimage revelation or refunds after CLTV expiry
- **Replay prevention:** payment_hash is single-use; server tracks revealed preimages
- **On-chain finality:** 6 confirmations (~60 min) required for PSBT fallback
- **Schnorr privacy:** BIP-340 Schnorr for on-chain inputs enables key aggregation (MuSig2)
- **Formal proof:** Lean 4 theorem `bitcoin_htlc_preimage_soundness` (formal-models/)
