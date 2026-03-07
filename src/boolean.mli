(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Propositional logic

  @author Harald Ruess
*)

(** Propositional is just defined in terms of bitwise operations
  on bitvectors of width [1].  This module provides the
  corresponding definitions. 
*)

 
val mk_true : unit -> Term.t
val mk_false : unit -> Term.t

val is_true : Term.t -> bool
val is_false : Term.t -> bool
