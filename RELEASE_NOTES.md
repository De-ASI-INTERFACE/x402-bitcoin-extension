# Release Notes — v1.0.0

**Title:** x402-Bitcoin: HTTP 402 Payment-Gated Routing on Bitcoin
**Version:** 1.0.0 | **Date:** 2026-07-09 | **Author:** Richard Patterson (@De-ASI-INTERFACE)

---

## Summary

First stable, versioned release. Canonical, machine-verifiable specification for x402 HTTP 402 payment-gated routing on Bitcoin via Lightning Network BOLT-11 invoices and on-chain PSBT fallback.

## Contents

| File | Description |
|---|---|
| `docs/x402-bitcoin-specification.md` | Full technical specification |
| `docs/prior-art-and-attribution.md` | Prior art and implementation history |
| `docs/x402-bitcoin-council-charter.md` | Stewardship council charter |
| `docs/reference-implementations.md` | Canonical implementation links |
| `docs/formal-models/BitcoinPaymentVerifier.lean` | Lean 4 HTLC preimage soundness theorem |
| `CITATION.cff` | Academic citation metadata |
| `lakefile.lean` + `lean-toolchain` | Lean 4 v4.14.0 + Mathlib4 |
| `.github/workflows/lean-build.yml` | CI automated theorem verification |

## Attribution
All artifacts originated and authored by Richard Patterson (@De-ASI-INTERFACE).
