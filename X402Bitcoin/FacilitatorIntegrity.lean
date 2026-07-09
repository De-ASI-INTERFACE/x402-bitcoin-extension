-- ============================================================
-- x402-Bitcoin: Facilitator State Integrity
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Finset.Basic
import X402Bitcoin.PaymentVerification

namespace X402Bitcoin.Facilitator

theorem nonces_monotone
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.settled_hashes ⊆ (settle a s).settled_hashes := by
  simp [settle]; exact Finset.subset_union_left

theorem fresh_not_in_pre_state
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.payment_hash ∉ s.settled_hashes :=
  replay_prevented a s h

structure TimeStep where
  s_before : FacilitatorState
  s_after  : FacilitatorState
  mono     : s_before.block_height ≤ s_after.block_height

theorem expiry_is_monotone
    (a : PaymentAuth) (ts : TimeStep)
    (h_valid : not_expired a ts.s_before) :
    ts.s_before.block_height ≤ a.expiry_cltv := h_valid

end X402Bitcoin.Facilitator
