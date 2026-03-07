(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Theory of propositional sets

  @author Harald Ruess
*)

(** Set connective, including recognizers and destructors.
  [ite(x,p,n)] can be thought of being defined as
  [union (inter x p) (inter (compl x) n)], where [union],[inter],
  and [compl] are just set union, set intersection, and set complement,
  respectively. [diff s1 s2] is the set difference, and [sym_diff]
  is the symmetric set difference operator. There is one 
  disequality [empty <> full].
*)

val d_interp : Term.t -> Sym.propset * Term.t list

val is_empty : Term.t -> bool
val is_full : Term.t -> bool

val is_diseq : Term.t -> Term.t -> bool
val is_const : Term.t -> bool
   
val mk_empty : unit -> Term.t
val mk_full : unit -> Term.t    
val mk_ite : Term.t -> Term.t -> Term.t -> Term.t

val mk_inter : Term.t -> Term.t -> Term.t
val mk_union : Term.t -> Term.t -> Term.t
val mk_compl : Term.t -> Term.t


val sigma : Sym.propset -> Term.t list -> Term.t
  (** Canonizer. *)

val map: (Term.t -> Term.t) -> Term.t -> Term.t
  (** [map f a] applies [f] to all top-level uninterpreted
    subterms of [a], and rebuilds the interpreted parts in order.
    It can be thought of as replacing every toplevel uninterpreted
    [a] with ['f(a)'] if [Not_found] is not raised by applying [a],
    and with [a] otherwise, followed by a sigmatization
    of all interpreted parts using [mk_sigma]. *)


val solve : Term.Equal.t -> Term.Equal.t list
  (** Solver *)
