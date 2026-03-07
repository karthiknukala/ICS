(*
 * Legacy proprietary license boilerplate removed for the open-source release.
 *)

(** Theory identifiers. *)

type t =
  | Shostak of shostak
  | Can of can
  | Uninterpreted

and shostak =  LA | P | BV | COP | SET | APP

and can = NL | ARR


(** {6 Names} *)

let la = Shostak(LA)
let p = Shostak(P)
let bv = Shostak(BV)
let cop = Shostak(COP)
let set = Shostak(SET)
let app = Shostak(APP)

let nl = Can(NL)
let arr = Can(ARR)

let u = Uninterpreted

let is_shostak = function
  | Shostak _ -> true
  | _ -> false

let is_can = function
  | Can _ -> true
  | _ -> false

let is_uninterpreted = function
  | Uninterpreted -> true
  | _ -> false

let rec to_string th =
  match th with
    | Shostak(i) -> shostak_to_string i
    | Can(i) -> can_to_string i
    | Uninterpreted -> "u"

and shostak_to_string i =
  match i with
    | LA -> "la"
    | P -> "p"
    | BV -> "bv"
    | COP -> "cop"
    | SET -> "pset"
    | APP -> "cl"

and can_to_string i =
  match i with
    | NL -> "nl"
    | ARR -> "arr"


let of_string = function
  | "u" -> u
  | "la" -> la
  | "p" -> p
  | "bv" -> bv
  | "cop" -> cop
  | "nl" -> nl
  | "cl" -> app
  | "arr" -> arr
  | "pset" -> set
  | str -> raise (Invalid_argument (str ^ ": no such theory"))


let fold f e =
  f u (f la (f p (f bv (f cop (f nl (f app (f arr (f set e))))))))

let iter f =
  f u; f la; f p; f bv; f cop; f nl; f app; f arr; f set

let for_all f =
  f u && f la && f p && f bv && f cop && f nl && f app && f arr && f set

let exists f =
  f u || f la || f p || f bv || f cop || f nl || f app || f arr || f set

let for_all_but i p =
  let p' j = if i <> j then p j else true in
    for_all p'

let exists_but i p =
  let p' j = if i <> j then p j else true in
    exists p'


let inj =
  let la = Some(la)
  and p = Some(p)
  and bv = Some(bv)
  and cop = Some(cop)
  and nl = Some(nl)
  and app = Some(app)
  and arr = Some(arr)
  and u = Some(u)
  and set = Some(set) in
    function
      | Shostak(i) -> (match i with APP -> app | LA -> la | P -> p | BV -> bv | COP -> cop | SET -> set)
      | Can(i) -> (match i with ARR -> arr | NL -> nl)
      | Uninterpreted -> u

let is_none = function
  | None -> true
  | Some _ -> false
    
let out = function
  | Some(i) -> i
  | None -> raise Not_found

let pp fmt = function
  | None -> Format.fprintf fmt "v"
  | Some(i) -> Format.fprintf fmt "%s" (to_string i)

let rec mem i = function
  | [] -> false
  | j :: jl -> i = j || mem i jl
  
type th = t (* nickname *)

module Set = Set.Make(
  struct
    type t = th
    let compare = Stdlib.compare
  end)
