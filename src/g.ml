(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

type t = {
  mutable facts : Fact.t list;
  mutable clauses : Clause.t list
}

let empty = { facts = []; clauses = [] }

let is_empty g =
  match g.facts, g.clauses with
    | [], [] -> true
    | _ -> false

let eq g1 g2 = 
  g1.facts == g2.facts &&
  g1.clauses == g2.clauses

let pp fmt g =
  Pretty.set Fact.pp fmt g.facts;
  if not(g.clauses = []) then
    begin
      Format.fprintf fmt "\nDisjunctions: \n";
      Pretty.infixl Clause.pp "\n AND " fmt g.clauses
    end 

let get g =
  match g.facts with
    | [] -> raise Not_found
    | fct :: fcts' ->
	g.facts <- fcts'; fct
      
let mem fct g =
  let eq_fct fct' = Fact.eq fct fct' in
    List.exists eq_fct g.facts

let put fct g = 
  if not(mem fct g) then
    g.facts <- fct :: g.facts

let get_clause g =
  match g.clauses with
    | [] -> raise Not_found 
    | cl :: cls ->
	g.clauses <- cls; cl

let put_clause cl g =
  try
    let fct = Clause.d_singleton cl in
      put fct g
  with
      Not_found -> 
	g.clauses <- cl :: g.clauses


let replace e g =        (* don't replace in clauses. *)
  let fcts' =  
    List.map (Fact.replace e) g.facts
  in
    g.facts <- fcts'

let copy g = { facts = g.facts; clauses = g.clauses }
