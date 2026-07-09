import Lake
open Lake DSL

package «x402-bitcoin» where
  name := "x402-bitcoin"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"

lean_lib «X402Bitcoin» where
  roots := #[`X402Bitcoin]
