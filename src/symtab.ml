(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Datatype for symbol table. *)

type entry = 
  | Def of args * defn
  | Arity of int
  | Type of Var.Cnstrnt.t
  | State of Context.t

and defn = 
  | Term of  Term.t
  | Prop of Prop.t

and args = Name.t list

and t = entry Name.Map.t

let lookup = Name.Map.find
	      
let empty_name () = Name.of_string "empty"
		      (* needs to be recreated after resets. *)

let empty () = 
  Name.Map.add
    (empty_name())
    (State (Context.empty))
    Name.Map.empty

let add n e s =
  if Name.Map.mem n s then
    let msg = "Name " ^ Pretty.to_string Name.pp n ^ " already in table" in 
    raise (Invalid_argument msg)
  else 
    Name.Map.add n e s

let remove n s = 
  if Name.eq n (empty_name()) then s else Name.Map.remove n s

let filter p s = 
  Name.Map.fold 
    (fun n e acc -> 
       if p n e then Name.Map.add n e acc else acc)
    s
    Name.Map.empty

let state = filter (fun _ e -> match e with State _ -> true | _ -> false)
let def   = filter (fun _ e -> match e with Def _ -> true | _ -> false)
let arity = filter (fun _ e -> match e with Arity  _ -> true | _ -> false)
let typ   = filter (fun _ e -> match e with Type  _ -> true | _ -> false)

let rec pp fmt s =
  let ml = Name.Map.fold (fun n e acc -> (n, e) :: acc) s [] in
    Pretty.map Name.pp pp_entry fmt ml 

and pp_entry fmt e =
  let pr a = 
    if !pretty then () else Format.fprintf fmt a
  in
    match e with
      | Def(args, Term(a)) -> 
	  pr "@[def("; Term.pp fmt a; pr ")@]"
      | Def(args, Prop(a)) -> 
	  pr "@[def("; Prop.pp fmt a; pr ")@]"
      | Arity(a) -> 
	  pr "@[sig("; Format.fprintf fmt "%d" a; pr ")@]"
      | Type(c) ->
	  pr "@[type("; Var.Cnstrnt.pp fmt c; pr ")@]"
      | State(s) -> 
	  pr "@[state(";
	  Pretty.list Atom.pp fmt (Context.ctxt_of s);
	  pr ")@]"

and pretty = ref true
