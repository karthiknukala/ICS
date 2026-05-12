(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

type t = disjunction * Jst.t

and disjunction = Atom.Set.t

let unsat rho = (Atom.Set.empty, rho)

let is_unsat (ds, _) = Atom.Set.is_empty ds

let of_list (dl, rho) =
  let rec loop acc = function
    | [] -> acc
    | d :: dl ->
	if Atom.is_false d then Atom.Set.empty
	else if Atom.is_true d then acc
	else loop (Atom.Set.add d acc) dl
  in
    (loop Atom.Set.empty dl, rho)
       
let to_list (ds, _) = Atom.Set.elements ds

let pp fmt ds =
  Pretty.infixl Atom.pp " OR " fmt (to_list ds)
  
let singleton (atm, rho) =
  (Atom.Set.singleton atm, rho)

let d_singleton (ds, rho) =
  if Atom.Set.cardinal ds = 1 then
    (Atom.Set.choose ds, rho)
  else 
    raise Not_found

let eq (ds1, _) (ds2, _) = ds1 == ds2
