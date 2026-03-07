(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Inference system for bitvector theory {!Th.bv}.

  @author Harald Ruess
*)


module Infsys: (Infsys.EQ with type e = Solution.Set.t)
  (** Inference system for the bitvector theory {!Th.bv}
    as defined in module {!Bitvector}.  This inference system
    is a variation of the inference system {!Shostak.Make} 
    for Shostak theories. *)
    
    

