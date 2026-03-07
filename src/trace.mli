(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Rudimentary tracing capability. 

  @author Harald Ruess
*)

(** All trace messages are directed to {!Format.err_formatter}. The amount of 
  tracing output is determined by the the set of active {b trace levels}. 
*)

type level = string

val registered : (level * string) list ref

val reset : unit -> unit
  (** Reset the set of trace levels to the empty set, that is,
    all tracing is disabled. *)

val add : level -> unit
  (** [add l] activates the trace level [l]. *)

val is_active : level -> bool
  (** Test if certain trace level is active. *)

val remove : level -> unit
  (** [remove l] deactivates the trace level [l]. *)


val get : unit -> level list
  (** [get ()] returns the set of currently active trace levels
    as a list. *)

val indent : int ref

val call : level -> string -> 'a -> 'a Pretty.printer -> unit
  (** [call l name arg pp] outputs a function call trace message
    if [l] is currently active by first outputting [name] followed
    by printing [arg] using the [pp] printer. *)

val exit : level -> string -> 'a -> 'a Pretty.printer -> unit
 (** [exit l name arg pp] outputs a function exit trace message
    if [l] is currently active by first outputting [name] followed
    by printing [arg] using the [pp] printer. *)

val fail : level -> string -> exn -> unit
  (** [fail l exc] outputs a failure warining if [l] is curently
    active, and raises exception [exc]. *)

val msg : level -> string -> 'a -> 'a Pretty.printer -> unit
  (** [msg l name arg pp] outputs a trace message
    if [l] is currently active by first outputting [name] followed
    by printing [arg] using the [pp] printer. *)

val func : level -> string -> 
             'a Pretty.printer -> 'b Pretty.printer -> 
                ('a -> 'b) -> 'a -> 'b
  (** [func l name pp qq f] provides a trace wrapper for function
    [f] for calling [call] before applying [f] and [exit] after
    applying [f]. In addition, messages are output if [f] raises
    an exception.  Except for the outputting of trace messages on
    [stderr], the functional behavior of [f] is unchanged. *)

val func2 : level -> string -> 'a Pretty.printer -> 'b Pretty.printer -> 'c Pretty.printer 
                -> ('a -> 'b -> 'c) -> 'a -> 'b -> 'c

val proc : level -> string -> 'a Pretty.printer
             -> ('a -> unit) -> 'a -> unit
  (** [proc l name pp f] is just [func l name pp Pretty.unit f]. *)
