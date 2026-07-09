-- x402-Bitcoin Payment Verification | Author: Richard Patterson
import X402Bitcoin.Basic

namespace X402Bitcoin.Verification

def settle (p : HTLCPayment) (s : LightningState) (h : verify p s) : LightningState :=
  { s with settled_hashes := s.settled_hashes ∪ {p.payment_hash} }

theorem settled_hash_recorded (p : HTLCPayment) (s : LightningState) (h : verify p s)
    : p.payment_hash ∈ (settle p s h).settled_hashes := by
  simp [settle, Finset.mem_union, Finset.mem_singleton]

end X402Bitcoin.Verification
