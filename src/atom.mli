(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Atomic predicates.

  @author Harald Ruess
*)

(** An {i atomic predicate} is either
  - one of the constants [True] or [False],
  - an equality [a = b],
  - a disequality [a <> b], or 
  - an arithmetic inequality [a > 0] or [a >= 0]. *)
type atom =
  | TT
  | Equal of Term.t * Term.t
  | Diseq of Term.t * Term.t
  | Nonneg of Term.t
  | Pos of Term.t
  | FF

type t
  (** For each atom, a {i unique index} is maintained. That is, 
    - {!Atom.equal}[a b] holds iff [i = j] 
    with [i], [j] the indices associated with [a], [b], respectively. *)
type atom_t = t

val atom_of : t -> atom
  (** Retrieve the atom from an atom-index pair. *)

val index_of : t -> int
  (** Retrieve the unique index from an atom-index pair. *)

val of_atom : atom -> t
  (** Construct an atom-index pair with unique index from an atom. *)

val of_index : int -> t
  (** [of_index n] returns an atom-index pair of index [n] if such and
    atom-index pair has been created since the last {!Tools.do_at_reset}. 
    Otherwise, the result is undefined. *)

val mk_true : t
  (** Atom-index pair for representing the [true] atom. *)

val mk_false : t
  (** Atom-index pair for representing the [false] atom. *)

val mk_equal : Term.t * Term.t -> t
  (** The atom-index pair [mk_equal (a, b)] represents the equality [a = b]. *)

val mk_diseq : Term.t * Term.t -> t
  (** The atom-index pair [mk_diseq (a, b)] represents the disequality [a <> b]. *)

val mk_nonneg : Term.t -> t
  (** The atom-index pair [mk_nonneg a] represents the nonnegativity 
    constraint [a >= 0]. *)

val mk_pos : Term.t -> t
  (** The atom-index pair [mk_nonneg a] represents the positivity
    constraint [a > 0]. *)

val map : (Term.t -> Term.t) -> t -> t
  (** [map f atm] yields an atom where every term [a] in [atm] 
    is replaced by [f a]. *)

val is_true : t -> bool
  (** [is_true atm] holds iff [atm] represents the [true] atom. *)

val is_false : t -> bool
  (** [is_false atm] holds iff [atm] represents the [false] atom. *)

val equal : t -> t -> bool
  (** Equality on atoms. *)

val is_negatable : t -> bool
  (** [is_negatable atm] is always true. Not deleted,
    because it is called by SAT solver *)

val negate : (Term.t -> Term.t) -> t -> t
  (** [negate f atm] ... *)
  
val vars_of : t -> Term.Var.Set.t
  (** [vars_of atm] collects all variables in [atm]. *)

val is_connected : t -> t -> bool
  (** [is_connected atm1 atm2] holds iff [vars_of atm1] and
    [vars_of atm2] not disjoint. *)

val pp : t Pretty.printer
  (** Pretty-printing an atom. *)

val to_string : t -> string
  (** Pretty-printing an atom to a string. *)

module Set : sig
  type t
  type elt = atom_t
  val empty : t
  val is_empty : t -> bool
  val mem : elt -> t -> bool
  val add : elt -> t -> t
  val singleton : elt -> t
  val remove : elt -> t -> t
  val union : t -> t -> t
  val subset : t -> t -> bool
  val inter : t -> t -> t
  val diff : t -> t -> t
  val equal : t -> t -> bool
  val compare : t -> t -> int
  val elements : t -> elt list
  val choose : t -> elt
  val cardinal : t -> int
  val iter : (elt -> unit) -> t -> unit
  val fold : (elt -> 'a -> 'a) -> t -> 'a -> 'a
  val for_all : (elt -> bool) -> t -> bool
  val exists : (elt -> bool) -> t -> bool
  val filter : (elt -> bool) -> t -> t
  val partition : (elt -> bool) -> t -> t * t
  val max_elt : t -> elt
  val min_elt : t -> elt
end
  (** Sets of atoms. *)

module Map : sig
  type key = atom_t
  type 'a t
  val empty : 'a t
  val add : key -> 'a -> 'a t -> 'a t
  val find : key -> 'a t -> 'a
  val remove : key -> 'a t -> 'a t
  val mem : key -> 'a t -> bool
  val iter : (key -> 'a -> unit) -> 'a t -> unit
  val map : ('a -> 'b) -> 'a t -> 'b t
  val mapi : (key -> 'a -> 'b) -> 'a t -> 'b t
  val fold : (key -> 'a -> 'b -> 'b) -> 'a t -> 'b -> 'b
end
  (** Maplets with atoms as keys. *)
