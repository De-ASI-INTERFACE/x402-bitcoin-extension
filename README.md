# x402-Bitcoin Extension

**HTTP 402 Payment-Gated Routing on Bitcoin**

**Author:** Richard Patterson (@De-ASI-INTERFACE)
**Version:** 1.0.0
**Date:** 2026-07-09
**License:** MIT

---

## Overview

The x402-Bitcoin Extension adapts the [x402 HTTP 402 payment standard](https://x402.org) to Bitcoin mainnet via the Lightning Network (BOLT-11/BOLT-12) and BIP-322 generic message signing. It defines a structured payment request schema (`scheme: bitcoin-lightning`), a Facilitator HTLC verification model with payment preimage integrity, replay prevention via payment hash uniqueness, and expiry enforcement via CLTV — all machine-checked via Lean 4 formal proofs.

This extension was originated and authored by Richard Patterson (RP-DEASI-BTC-2026-0709-001).

---

## Repository Structure

```
docs/
  x402-bitcoin-specification.md
  prior-art-and-attribution.md
  x402-bitcoin-council-charter.md
  reference-implementations.md
  formal-models/
    PaymentVerification.lean
scripts/
  tag-release.sh
.github/workflows/
  lean-build.yml
CITATION.cff
lakefile.lean
lean-toolchain
LICENSE
RELEASE_NOTES.md
```

---

## Citation

```bibtex
@software{patterson2026x402bitcoin,
  author  = {Patterson, Richard},
  title   = {{x402-Bitcoin: HTTP 402 Payment-Gated Routing on Bitcoin}},
  version = {1.0.0},
  date    = {2026-07-09},
  url     = {https://github.com/De-ASI-INTERFACE/x402-bitcoin-extension},
  license = {MIT}
}
```
