# x402-Bitcoin Extension

**HTTP 402 Payment-Gated Routing on Bitcoin (Lightning Network)**
**Author:** Richard Patterson (@De-ASI-INTERFACE)
**Version:** 1.0.0 | **Date:** 2026-07-09 | **License:** MIT

---

## Overview

Canonical specification for HTTP 402 Payment-Gated Routing on Bitcoin, anchored to the Lightning Network for instant, low-fee micropayment settlement. Originated and authored by Richard Patterson.

The x402-Bitcoin Extension maps the HTTP 402 payment flow onto Bitcoin's HTLC-based Lightning payment channels. Payment proofs are BOLT-11 invoices; settlement is confirmed via preimage revelation on the Lightning gossip layer. For on-chain fallback, PSBT (BIP-174) signed transactions with OP_RETURN resource commitment provide the verifiable proof surface.

## Architecture

- **Primary Settlement:** Lightning Network BOLT-11 invoices (sub-second finality)
- **Fallback Settlement:** Bitcoin on-chain PSBT with OP_RETURN resource hash
- **Signature Scheme:** Schnorr (BIP-340) for on-chain; ECDSA secp256k1 for Lightning node identity
- **Finality Model:** Lightning: instant (preimage); On-chain: 6 confirmations (~60 min)
- **Verifier Surface:** BOLT-11 invoice preimage verification + optional PSBT decoder
- **Formal Verification:** Lean 4 HTLC preimage soundness theorem

## Citation
```bibtex
@software{patterson2026x402bitcoin,
  author={Patterson, Richard}, title={{x402-Bitcoin: HTTP 402 Payment-Gated Routing on Bitcoin}},
  version={1.0.0}, date={2026-07-09},
  url={https://github.com/De-ASI-INTERFACE/x402-bitcoin-extension}, license={MIT}}
```
