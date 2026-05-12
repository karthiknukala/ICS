(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Decision procedures for propositional sets

  @author Harald Ruess
  @author N. Shankar
*)


module Infsys: (Infsys.EQ with type e = Solution.Set.t)
 (** Inference system for the theory {!Th.set} of products 
    as described in module {!Propset}.  This inference
    system is obtained as an instantiation of the generic
    Shostak inference system [Shostak.Infsys] with a
    specification of the {i convex} product theory by
    means of the 
    - product canonizer {!Propset.map}
    - product solver {!Propset.solve}

    In particular, there is no branching for this theory,
    and the inference system is complete as the product
    solver itself is complete. *)
