(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Three-valued datatype. 

  @author Harald Ruess
*)

(** There is an implicit partial ordering  with [Yes < X] and [No < X]. *)
type t = 
  | Yes
  | No
  | X

val is_sub : t -> t -> bool
  (** [is_sub u v] holds if either [u = v] or [u < v]. *)

val inter : t -> t -> t option
  (** [inter u v] evaluates to [Some(w)] if both [is_sub w u] 
    and [is_sub w v]; otherwise [None] is returned. *)

val union : t -> t -> t
  (** [union u v] evaluates to [w] if both [is_sub u w] 
    and [is_sub v w] holds. *)

val is_disjoint : t -> t -> bool
  (** [is_disjoint u v] holds iff the [inter u v] is [None]. *)

val pp : Format.formatter -> t -> unit
  (** Pretty-printing *)
