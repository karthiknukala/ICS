(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Datatype of clauses

  @author Harald Ruess

*)


type t = disjunction * Jst.t

and disjunction

val unsat : Jst.t -> t

val is_unsat : t -> bool

val of_list : Atom.t list * Jst.t -> t

val singleton : Fact.t -> t

val pp : t Pretty.printer

val eq : t -> t -> bool

val d_singleton: t -> Fact.t
