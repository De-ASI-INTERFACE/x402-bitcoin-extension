-- x402-Bitcoin HTLC Payment Verification Formal Model
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09

import Mathlib.Data.Finset.Basic

namespace X402Bitcoin

structure HTLCPayment where
  payment_hash   : Nat
  preimage       : Nat
  amount_msat    : Nat
  cltv_expiry    : Nat
  deriving Repr

structure FacilitatorState where
  settled_hashes : Finset Nat
  block_height   : Nat
  deriving Repr

def preimage_valid (p : HTLCPayment) : Prop :=
  p.preimage * p.preimage = p.payment_hash  -- symbolic; real: SHA256(preimage)=hash

def not_expired (p : HTLCPayment) (s : FacilitatorState) : Prop :=
  s.block_height ≤ p.cltv_expiry

def not_settled (p : HTLCPayment) (s : FacilitatorState) : Prop :=
  p.payment_hash ∉ s.settled_hashes

def verify (p : HTLCPayment) (s : FacilitatorState) : Prop :=
  preimage_valid p ∧ not_expired p s ∧ not_settled p s

theorem settle_prevents_replay (p : HTLCPayment) (s : FacilitatorState)
    (h : verify p s) : p.payment_hash ∉ s.settled_hashes := h.2.2

end X402Bitcoin
