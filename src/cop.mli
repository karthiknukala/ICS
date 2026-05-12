(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Inference system for coproducts

  @author Harald Ruess
 *)


module Infsys: (Infsys.EQ with type e = Solution.Set.t) 
  (** Inference system for the theory {!Th.cop} of coproducts
    as defined in module {!Coproduct}.

    This inference system maintains a set of directed 
    equalities [x = a] with [x] a variable, [a] a {!Th.cop}-pure term, 
    and none of the right-hand side variables occurs in any of the left-hand sides. 

    This inference system is obtained as an instantiation of the generic
    Shostak inference system [Shostak.Infsys] with a specification of the 
    coproduct theory by means of the 
    - coproduct canonizer {!Coproduct.map}
    - coproduct solver {!Coproduct.solve} *)
  
