(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Classification of function symbols
  
  @author Harald Ruess
*)

(** Function symbols are classified according to which {i theory} 
  they belong to.  We distinguish between three classes of
  {i equality theories}.
  - {i Uninterpreted} theory
  - {i Canonizable} theories have a unique normal forms.
  - {i Shostak} theories are {i canonizable} and {i solvable},
  that is, besides having unique normal forms, equalities can
  always be solved for variables. 

  Currently, ICS support the Shostak theories
  - [A] of linear arithmetic,
  - [P] of products,
  - [BV] of bitvectors,
  - [COP] of coproducts (direct sums),

  and the canonizable theories
  - [NL] of nonlinear arithmetic,
  - [APP] of strongly normalizable lambda terms, and
  - [ARR] of functional arrays

  The corresponding function symbols of these theories are 
  defined in module {!Sym.t}. 
*)

type t =
  | Shostak of shostak
  | Can of can
  | Uninterpreted

and shostak = LA | P | BV | COP | SET | APP

and can = NL | ARR


(** Theory identifiers. *)
val la : t 
val p : t
val bv : t
val cop : t
val nl : t
val app : t
val arr : t
val u : t
val set : t

val to_string : t -> string
  (** [to_string i] returns a name for theory [i]. *)

val of_string : string -> t
  (** [of_string n] returns theory identifier [i]
    if [to_string i] equals to [n]; otherwise the 
    result is undefined. *)

val fold : (t -> 'a -> 'a) -> 'a -> 'a
  (** [fold f e] applies [f i] to each theory [i] 
    and accumulates the result, starting with [e],
    in an unspecified order. *)
  
val iter : (t -> unit) -> unit
  (** [fold f] applies [f i] for each theory [i] 
    in some unspecified order. *)
  
val for_all : (t -> bool) -> bool
  (** [for_all p] holds if predicate [p i] holds 
    for all theories [i]. *)

val exists : (t -> bool) -> bool
  (** [exists p] holds if predicate [p i] 
    holds for some [i]. *)

val for_all_but : t -> (t -> bool) -> bool
 (** [for_all_but j p] holds if predicate 
   [p i] holds for all [i <> j]. *)

val exists_but : t -> (t -> bool) -> bool
  (** [exists_but j p] holds if predicate 
    [p i] holds for some [i <> j]. *)

val is_shostak : t -> bool 
  (** [is_shostak i] holds if [i] is a Shostak theory. *)

val is_can : t -> bool
  (** [is_can i] holds if [i] is a canonizable theory. *)
 
val is_uninterpreted : t -> bool 
  (** [is_uninterpreted i] holds iff [i] is the uninterpreted
    theory {!Th.u}. *)

val inj : t -> t option
  (** [inj i] hashconses injection of theories [i] into [Some(i)].
    The [None] is usually used for predicates on variables.
    See, for example, module {!Combine}. *)

val is_none : t option -> bool

val out : t option -> t
  (** Returns [i] if argument is of the form [Some(i)], and raises
    [Not_found] otherwise. *)

val pp : t option Pretty.printer
  (** Pretty-printing theories. *)

val mem : t -> t list -> bool
  (** [mem i jl] tests if [i] is in [jl]. *)

module Set: (Set.S with type elt = t)
