(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Theory of arrays.

  @author Harald Ruess
*)

(** Terms in the theory of arrays are 
  - creation [create(a)] of a constant array
  - selection [a[j]] of element at position [j] in the array [a], and 
  - updating [a[i := x]] array [a] at position [i] with value [x].

  Given an equality relation [=E] and a disequality relation [<>D], the
  {i theory of arrays} is specified by
  - [create(a)[j] = a]
  - [a[i:=x][j] = x] when [i =E j]
  - [a[i:=x][j] = a[j]] when [i <>D j]
  - [a[i:=x][i:=y] = a[i:=y]]
  - [a[j:=y][i:=x] = a[i:=x][j:=y]] if [i <>D j] and {!Term.(<<<)}[i j]. 
*)

val d_interp : Term.t -> Sym.arrays * Term.t list

val d_update : Term.t -> Term.t * Term.t * Term.t

val d_select : Term.t -> Term.t * Term.t

val d_create : Term.t -> Term.t

val d_select_update : Term.t -> Term.t * Term.t * Term.t * Term.t
   (** [d_select a] returns [(b, i, x, j)] if [a] is of the form [a[i:=x][j]]. *)

type equalRel = Term.t -> Term.t -> Three.t

val is_interp : Term.t -> bool


(** {6 Constructors} *)
  
val mk_create : Term.t -> Term.t
  
val mk_select : equalRel -> Term.t -> Term.t -> Term.t
  (** [mk_select a j] constructs a canonical term equivalent
    to [App(select, [a; j])]. *)
  
val mk_update : equalRel -> Term.t -> Term.t -> Term.t -> Term.t
  (** [mk_update a x i] constructs a canonical term equivalent
    to [App(update, [a;x;i])]. *)
  
  
(** {6 Canonizer} *)

val sigma : equalRel -> Sym.arrays -> Term.t list -> Term.t

  
(** {6 Iterators} *)
  
val map: equalRel -> (Term.t -> Term.t) -> Term.t -> Term.t
  (** Applying a term transformer at all uninterpreted positions
    - [map f (mk_select a j)] equals [mk_select (map f a) (map f j)]
    - [map f (mk_update a i x)] equals [mk_select (map f a) (map f i) (map f x)]
    - Otherwise, [map f x] equals [f x] *)


(** {6 Flat terms} *)

module Flat : sig

  val is : Term.t -> bool

  val mk_create : Term.t -> Term.t

  val mk_update : Term.t -> Term.t -> Term.t -> Term.t

  val mk_select : Term.t -> Term.t -> Term.t

  val apply : Term.Equal.t -> Term.t -> Term.t

end
