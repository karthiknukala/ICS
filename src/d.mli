(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Disequality context.

  @author Harald Ruess
*)
  

type t
  (** Elements of type {!D.t} represent sets of 
    variable disequalities. *)

val pp : t Pretty.printer
  (** Pretty-printing. *)

val eq : t -> t -> bool
  (** [eq s t] holds iff [s] and [t] are 'physically' equal.
    If [eq s t] equals [false], then it is not necessarily
    true that [s] and [t] are not logically equivalent. *)

module Set : (Set.S with type elt = Term.t * Jst.t)
  (** Set of disequal terms together with justifications. *)

val diseqs : t -> Term.t -> Set.t
 (** [diseqs s x] returns set of  disequalites of the form [x <> y] 
   such that [x <> y] is represented in [s]. *)

val is_diseq: t -> Term.t -> Term.t -> Jst.t option
  (** Check if two terms are known to be disequal. *)

val empty : t
  (** The empty disequality context. *)

val is_empty : t -> bool
  (** Check if the argument disequality context is empty. *)
 
val merge : Fact.Equal.t -> t -> t * Fact.Diseq.Set.t
  (** [merge e s] propagates an equality [e] of the form [x = y]
    into the disequality context by computing a new disequality
    context which is equal to [s] except that every [x] has been
    replaced by [y]. Raises {!Exc.Inconsistent} if [x <> y] is
    valid in [s]. The second argument returns the newly generated
    disequalities. *)

val add : Fact.Diseq.t -> t -> t * Fact.Diseq.Set.t
  (** [add d s] adds a disequality [d] of the form
    [x <> y] to the disequality context [s]. As a side
    effect, both [x] and [y] are added to the set [D.changed].
    The second argument returns newly generated disequalities (at most one). *)

val diff : t -> t -> t
  (** [diff d1 d2] contains all disequalities in [d1] not in [d2]. *)
