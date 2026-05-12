(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Theory of power products.

  @author Harald Ruess
*)

(** Power products are of th form [x1^n1 * ... * xk^nk], 
  where [xi^ni] represents the variable [xi] raised to the [n], 
  where [n] is any integer, positive or negative, except for [0],
  and [*] is nary multiplication; in addition [xi^1] is reduced
  to [xi], [x1,...,xn] are ordered from left-to-right such that
  [Term.cmp xi xj < 0] (see {!Term.cmp}) for [i < j]. In particular, 
  every [xi] occurs only one in a power product.
*)

module Sig: Acsym.SIG 

                        (** Same as {!Acsym.TERM}. *)
val d_interp : Term.t -> Term.t * Term.t
val is_interp : Term.t -> bool
val iterate : Term.t -> int -> Term.t
val multiplicity: Term.t -> Term.t -> int
val decompose : Term.t -> (Term.t * int) * Term.t option
val fold : (Term.t -> int -> 'a -> 'a) -> Term.t -> 'a -> 'a
val iter : (Term.t -> int -> unit) -> Term.t -> unit
val sigma : Sym.pprod -> Term.t list -> Term.t
val map : (Term.t -> Term.t) -> Term.t -> Term.t
  
val mk_mult : Term.t -> Term.t -> Term.t
  (** Constructing a term for representing [a * b].
    The result is a nonlinear term. *)
  
val mk_multl : Term.t list -> Term.t
  
val mk_expt : Term.t -> int -> Term.t
  
val dom : (Term.t -> Dom.t) ->  Sym.pprod -> Term.t list -> Dom.t
  (** [tau lookup op al] returns a constraint in [Cnstrnt.t] given a [lookup]
    function, which is applied to each noninterpreted term, and by
    propagation using abstract domain operations for the interpreted
    symbols. If [lookup] raises [Not_found] for one uninterpreted 
    subterm (not equal to [op(al)]), the result is [Cnstrnt.real]. *)

val dom_of : Term.t -> Dom.t
  





(*

val is_interp : Term.t -> bool
  (** [is_interp a] holds iff [a] is of the form described above. *)

val is_diophantine : Term.t -> bool
  (** Are all variables interpreted over the integers. *)

val is_nonneg : Term.t -> bool
  (** [is_nonneg a] holds iff [a >= 0] holds. *)


val mk_mult : Term.t -> Term.t -> Term.t
  (** [mk_mult pp qq] multiplies the power products [pp] and [qq] to
    obtain a new power product. *)

val d_mult : Term.t -> Term.t * Term.t

val mk_expt : Term.t -> int -> Term.t

val of_list : (Term.t * int) list -> Term.t

val sigma : Sym.pprod -> Term.t list -> Term.t

val map: (Term.t -> Term.t) -> Term.t -> Term.t

val apply : Term.Equal.t -> Term.t -> Term.t

val decompose : Term.t -> (Term.t * int) * Term.t option

val iter : (Term.t -> int -> unit) -> Term.t -> unit

val fold : (Term.t -> int -> 'a -> 'a) -> Term.t -> 'a -> 'a

val divide : Term.t -> (Term.t * int) -> Term.t

val dom : (Term.t -> Dom.t) ->  Sym.pprod -> Term.t list -> Dom.t
  (** [tau lookup op al] returns a constraint in {!Cnstrnt.t} given a [lookup]
    function, which is applied to each noninterpreted term, and by
    propagation using abstract domain operations for the interpreted
    symbols. If [lookup] raises [Not_found] for one uninterpreted 
    subterm (not equal to [op(al)]), the result is {!Cnstrnt.real}. *)


val dom_of : Term.t -> Dom.t


*)
