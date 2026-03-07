(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Description of the theory of products as a convex Shostak theory. *)
module T = struct
  let th = Th.p
  let map = Product.map
  let solve e = 
    let (a, b, rho) = e in
      try
	let sl = Product.solve (a, b) in
	let inj (a, b) = Fact.Equal.make a b rho in
	  List.map inj sl
      with
	  Exc.Inconsistent -> raise(Jst.Inconsistent(rho))
  let disjunction _ =
    raise Not_found
end

(** Inference system for products as an instance 
  of a Shostak inference system. *)
module Infsys: (Infsys.EQ with type e = Solution.Set.t) =
  Shostak.Make(T)

