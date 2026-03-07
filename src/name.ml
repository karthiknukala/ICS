(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Hashconsed names. *)

type t = string * int

module StringHash = Hashtbl.Make(
  struct
    type t = string
    let equal = (=)
    let hash = Hashtbl.hash_param 4 4
  end)

let current = ref 0
let table = StringHash.create 117

(* don't reset, since there are some global variables.
let _ = Tools.add_at_reset (fun () -> current := 0)
let _ = Tools.add_at_reset (fun () -> StringHash.clear table)
*)

let of_string str =
  try
    StringHash.find table str
  with
      Not_found ->
	let n = (str, !current) in
	  incr current;
          StringHash.add table str n; n

let eq (s, i) (t, j) =
  assert(if s == t then s = t else not(s = t));
  (s == t)

let to_string (s, _) = s


let pp fmt (s, _) =
  Format.fprintf fmt "%s" s

let compare (s, i) (t, j) =
  assert(if i == j then s = t else not(s = t));
  if i < j then -1
  else if i == j then 0
  else 1


let hash (_, i) = i

module Set = Set.Make(
  struct
    type t = string * int
    let compare = compare
  end)

module Map = Map.Make(
  struct
    type t = string * int
    let compare = compare
  end)

module Hash = Hashtbl.Make(
  struct
    type t = string * int
    let equal = eq
    let hash = hash
  end)
