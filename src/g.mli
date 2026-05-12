(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Global input facts.

  @author Harald Ruess

  Global facts are used as inputs for inference systems.
  See also module {!Infsys}.
*)

type t
  (** Set of {i input facts} of type {!Fact.t}. These are atoms 
    together with a justification. *)

val empty : t 
  (** Empty set of inputs. *)

val is_empty : t -> bool
  (** [is_empty g] holds iff [g] does not contain any inputs. *)

val copy : t -> t

val eq : t -> t -> bool
  (** Identity test for input facts. *)

val pp: t Pretty.printer
  (** Pretty-printing input facts. *)

val replace : Fact.Equal.t -> t -> unit
  (** [replace e g] with [e] of the form [x = a] replaces 
    occurrences of [a] in [g] with [x]. *)

val get : t -> Fact.t
  (** [get g] chooses a fact [fct] in [g] and returns this fact [fct]
    together with [g] where [fct] is removed.  If [g] is empty, then
    [get g] raises [Not_found]. *)

val put : Fact.t -> t -> unit
  (** [put fct g] adds fact [fct] to [g]. *)


val get_clause : t -> Clause.t
  (** [get_clause g] removes a clause [cl] in [g] or raise [Not_found]. *) 

val put_clause : Clause.t -> t -> unit
  (** [put_clause g] adds a clause [cl] to [g]. *)

