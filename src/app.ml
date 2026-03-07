(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Operations on uninterpreted terms. *)

open Term

let sigma f l =
  Term.App.mk_app f l

let lazy_sigma a f l =
  assert(not(is_var a) && Sym.eq (Term.App.sym_of a) f);
  let m = Term.App.args_of a in
  if try List.for_all2 eq l m with Invalid_argument _ -> false then
    a
  else 
    sigma f l
	  
let is_uninterp = function
  | App(sym, _, _) -> Sym.theory_of sym = Th.u
  | _ -> false
 
let d_uninterp a =
  assert(is_uninterp a);
  let f,l = Term.App.destruct a in
    (f, l)

let map ctxt a =
  match a with
    | Var _ -> ctxt(a)
    | App(f, l, _) ->  
	let l' = Term.mapl ctxt l in
	  if l == l' then a else 
	    Term.App.mk_app f l'

