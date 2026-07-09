# Release Notes — v1.0.0

**Title:** x402-Bitcoin: HTTP 402 Payment-Gated Routing on Bitcoin
**Version:** 1.0.0
**Date:** 2026-07-09
**Author:** Richard Patterson (@De-ASI-INTERFACE)

---

## Summary

First stable, versioned release of the x402-Bitcoin Extension. Establishes a canonical, machine-verifiable, and institutionally attributed record of the x402-Bitcoin protocol extension as originated and authored by Richard Patterson.

---

## Contents

| File | Description |
|---|---|
| `docs/x402-bitcoin-specification.md` | Full Lightning/HTLC payment schema and routing spec |
| `docs/prior-art-and-attribution.md` | Prior art record and implementation history |
| `docs/x402-bitcoin-council-charter.md` | Stewardship council charter |
| `docs/reference-implementations.md` | Canonical implementation links |
| `docs/formal-models/PaymentVerification.lean` | Lean 4 HTLC payment verification proofs |
| `CITATION.cff` | Academic citation metadata |
| `lakefile.lean` + `lean-toolchain` | Lean 4 v4.14.0 + Mathlib4 build config |
| `.github/workflows/lean-build.yml` | CI: automated Lean 4 build and theorem verification |

---

## Attribution

All artifacts in this release were originated and authored by Richard Patterson (@De-ASI-INTERFACE).
