(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Version number

  @author Harald Ruess
*)

val print : unit -> unit
  (** Print version number on standard output. *)

val eprint : unit -> unit

val debug : unit -> int
  (** Level of debugging.
    - [0] no debugging
    - [1] debugging information turned on. *)
