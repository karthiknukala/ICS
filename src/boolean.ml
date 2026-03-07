(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Boolean constants. *)

(** {6 Constants} *)

let mk_true () = Bitvector.mk_one 1
let mk_false () = Bitvector.mk_zero 1
  (* These constants needs to be rebuild after
     resetting symbol tables. *)


(** {6 Recognizers} *)

let is_true a = (Term.eq a (mk_true()))
let is_false a = (Term.eq a (mk_false()))

