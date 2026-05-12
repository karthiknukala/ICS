(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Global variables and useful functions. *)


(** {6 Global variables} *)

let linenumber = ref 0
   (** Current line number in input. *)

let profiling = ref false
   (** Flag for enabling/disabling profiling of functions
     profiled with {!Tools.profile}. *)


(** {6 Functions to run at exit} *)

let at_exit_functions = ref []

let add_at_exit f = 
  at_exit_functions := f :: !at_exit_functions

let do_at_exit () = 
  List.iter (fun f -> f()) (List.rev !at_exit_functions)


(** {6 Functions to run at reset} *)

let at_reset_functions = ref []

let add_at_reset f = 
  at_reset_functions := f :: !at_reset_functions

let do_at_reset () =
  List.iter (fun f -> f()) (List.rev !at_reset_functions)


(** {6 Timing functions} *)

open Unix

let utime f x =                                                   
  let u = (Unix.times()).tms_utime in                                  
  let y = f x in
  let ut = (Unix.times()).tms_utime -. u in
  (y,ut)

let timers = ref [0.]

let profile str f a =
  if !profiling then 
    let timer = ref 0. in
    let calls = ref 0 in
      add_at_exit
	(fun () -> Format.printf "%s: utime = %f  calls = %d\n@ " str !timer !calls);
      (fun x ->
	 let start = (Unix.times()).tms_utime in
	 let y = f x in
	 let finish = (Unix.times()).tms_utime in
	   timer := !timer +. (finish -. start);
	   calls := !calls + 1;
	   y) a
  else 
    f a


(** {6 Accumulate side effects} *)

let acc1 acc f a =
  let (b, side_effect) = f a in
    acc := side_effect :: !acc; b

let acc2 acc f a1 a2 =
  let (b, side_effect) = f a1 a2 in
    acc := side_effect :: !acc; b

let accb acc p a =
  match p a with 
    | None -> false
    | Some(side_effect) -> acc := side_effect :: !acc; true
