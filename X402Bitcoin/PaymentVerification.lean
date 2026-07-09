-- ============================================================
-- x402-Bitcoin: Payment Verification Formal Proofs
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: Bitcoin / Lightning Network HTLC / BIP-68
-- ============================================================
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic
import Mathlib.Logic.Basic

namespace X402Bitcoin

structure PaymentAuth where
  payment_hash : Nat    -- SHA-256 of preimage
  amount_msat  : Nat    -- millisatoshis
  expiry_cltv  : Nat    -- CLTV block expiry
  preimage     : Nat    -- revealed on settlement
  deriving Repr, DecidableEq

structure FacilitatorState where
  settled_hashes : Finset Nat
  block_height   : Nat
  deriving Repr

def not_expired (a : PaymentAuth) (s : FacilitatorState) : Prop :=
  s.block_height ≤ a.expiry_cltv

def nonce_fresh (a : PaymentAuth) (s : FacilitatorState) : Prop :=
  a.payment_hash ∉ s.settled_hashes

def amount_positive (a : PaymentAuth) : Prop :=
  0 < a.amount_msat

def verify (a : PaymentAuth) (s : FacilitatorState) : Prop :=
  not_expired a s ∧ nonce_fresh a s ∧ amount_positive a

theorem replay_prevented
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.payment_hash ∉ s.settled_hashes := h.2.1

theorem within_expiry
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.block_height ≤ a.expiry_cltv := h.1

theorem positive_amount
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    0 < a.amount_msat := h.2.2

def settle (a : PaymentAuth) (s : FacilitatorState) : FacilitatorState :=
  { s with settled_hashes := s.settled_hashes ∪ {a.payment_hash} }

theorem settled_nonce_used
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.payment_hash ∈ (settle a s).settled_hashes := by
  simp [settle, Finset.mem_union, Finset.mem_singleton]

theorem post_settlement_replay_blocked
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.payment_hash ∈ (settle a s).settled_hashes ∧
    ¬a.payment_hash ∉ (settle a s).settled_hashes := by
  constructor
  · exact settled_nonce_used a s h
  · simp [settle, Finset.mem_union, Finset.mem_singleton]

end X402Bitcoin
