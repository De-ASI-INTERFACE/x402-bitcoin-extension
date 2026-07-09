-- ============================================================
-- x402-Bitcoin: Lightning Network HTLC Routing Invariants
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Nat.Basic
import X402Bitcoin.PaymentVerification

namespace X402Bitcoin.Lightning

structure HTLCRoute where
  channel_id     : Nat
  amount_msat    : Nat
  cltv_delta     : Nat
  min_final_cltv : Nat
  deriving Repr

structure GatedHTLC where
  auth  : PaymentAuth
  route : HTLCRoute
  deriving Repr

def route_authorized (g : GatedHTLC) (s : FacilitatorState) : Prop :=
  verify g.auth s

def route_sane (g : GatedHTLC) : Prop :=
  0 < g.route.amount_msat ∧
  g.auth.amount_msat = g.route.amount_msat

def gated_htlc_valid (g : GatedHTLC) (s : FacilitatorState) : Prop :=
  route_authorized g s ∧ route_sane g

theorem gated_htlc_requires_payment
    (g : GatedHTLC) (s : FacilitatorState)
    (h : gated_htlc_valid g s) :
    g.auth.payment_hash ∉ s.settled_hashes :=
  replay_prevented g.auth s h.1

end X402Bitcoin.Lightning
