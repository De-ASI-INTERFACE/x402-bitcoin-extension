-- x402-Bitcoin Basic | Author: Richard Patterson (@De-ASI-INTERFACE)
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace X402Bitcoin

structure HTLCPayment where
  payment_hash : Nat  -- SHA-256 hash of preimage
  amount_msat  : Nat  -- millisatoshis
  expiry_cltv  : Nat  -- CLTV block expiry
  deriving Repr, DecidableEq

structure LightningState where
  settled_hashes : Finset Nat
  block_height   : Nat
  deriving Repr

def verify (p : HTLCPayment) (s : LightningState) : Prop :=
  p.payment_hash ∉ s.settled_hashes ∧ s.block_height ≤ p.expiry_cltv

theorem bitcoin_htlc_unique (p : HTLCPayment) (s : LightningState) (h : verify p s)
    : p.payment_hash ∉ s.settled_hashes := h.1

theorem bitcoin_not_expired (p : HTLCPayment) (s : LightningState) (h : verify p s)
    : s.block_height ≤ p.expiry_cltv := h.2

end X402Bitcoin
