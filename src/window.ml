type window
external window : window = "window" [@@bs.val]
external onload : window -> (unit -> unit) -> unit = "onload" [@@bs.set]
external encodeURIComponent : string -> string = "encodeURIComponent" [@@bs.val]
