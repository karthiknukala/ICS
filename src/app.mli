(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Operations on uninterpreted terms

  @author Harald Ruess

  Currently not used. But here goes the forward chaining rules.
*)

val sigma : Sym.t -> Term.t list -> Term.t

val lazy_sigma : Term.t -> Sym.t -> Term.t list -> Term.t


val is_uninterp : Term.t -> bool
  (** [is_uninterp a] holds iff the function symbol of [a] is
    uninterpreted (see module [Sym]). *)


val d_uninterp : Term.t -> Sym.t * Term.t list
  (** For a term [a] such that [is_uninterp a] holds, [d_uninterp a]
    returns the uninterpreted function symbol and the argument list of [a]. *)

val map : (Term.t -> Term.t) -> Term.t -> Term.t
