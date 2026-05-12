(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Shostak inference system for the theory of products

  @author Harald Ruess
  @author N. Shankar
*)


module Infsys: (Infsys.EQ with type e = Solution.Set.t) 
  (** Inference system for the theory {!Th.p} of products 
    as described in module {!Product}.  This inference
    system is obtained as an instantiation of the generic
    Shostak inference system [Shostak.Infsys] with a
    specification of the {i convex} product theory by
    means of the 
    - product canonizer {!Product.map}
    - product solver {!Product.solve}

    In particular, there is no branching for this theory,
    and the inference system is complete as the product
    solver itself is complete. *)
