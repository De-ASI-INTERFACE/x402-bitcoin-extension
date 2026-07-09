-- ============================================================
-- x402-Bitcoin: Basic Re-export Shim
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: Bitcoin / Lightning Network HTLC / BIP-68
--
-- Re-exports X402Bitcoin.PaymentVerification as the single
-- authoritative source of all shared types and definitions.
-- Chain-prefixed theorem aliases are provided for ergonomic use.
--
-- Note: Bitcoin/Lightning uses payment_hash (SHA-256 of preimage)
-- as the replay nonce, settled_hashes : Finset Nat for the set
-- of consumed HTLCs, expiry_cltv for CLTV block expiry, and
-- amount_msat (millisatoshis) as the amount field.
-- ============================================================
import X402Bitcoin.PaymentVerification

namespace X402Bitcoin

/-- Alias: HTLC hash uniqueness under the Bitcoin chain prefix.
    result type: a.payment_hash ∉ s.settled_hashes. -/
theorem bitcoin_replay_prevented
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.payment_hash ∉ s.settled_hashes :=
  replay_prevented a s h

/-- Alias: CLTV block expiry enforcement under the Bitcoin chain prefix.
    Delegates to within_expiry: s.block_height ≤ a.expiry_cltv. -/
theorem bitcoin_not_expired
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.block_height ≤ a.expiry_cltv :=
  within_expiry a s h

/-- Alias: positive millisatoshi amount under the Bitcoin chain prefix.
    Delegates to positive_amount: 0 < a.amount_msat. -/
theorem bitcoin_positive_amount
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    0 < a.amount_msat :=
  positive_amount a s h

end X402Bitcoin
