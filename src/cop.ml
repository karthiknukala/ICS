(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Encoding of the theory of coproducts as a Shostak theory. *)
module T: Shostak.T = struct
  let th = Th.cop
  let map = Coproduct.map
  let solve e =
    let (a, b, rho) = e in
      try
	let sl = Coproduct.solve (a, b) in
	let inj (a, b) = Fact.Equal.make a b rho in
	  List.map inj sl
      with
	  Exc.Inconsistent -> raise(Jst.Inconsistent(rho))
  let disjunction _ = raise Not_found
end


(** Inference system for coproducts as an instance of
  a Shostak inference system. *)
module Infsys: (Infsys.EQ with type e = Solution.Set.t) =
  Shostak.Make(T)

