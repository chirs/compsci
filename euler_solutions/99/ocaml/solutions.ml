(* open Utils;; *)

(* PROBLEM 1 *)
let rec last = function
    | [] -> None
    | x::[] -> Some x
    | x::xs -> last xs
;;



print_string "HELLO"