let main () = Chrome.Identity.getAuthToken (Chrome.Identity.mkAuthOptions ~interactive:Js.true_ ()) (fun token ->
    Google_drive.getDirectories token
    |> Js.Promise.then_ (fun name -> Js.log name |> Js.Promise.resolve)
    |> Js.Promise.catch (fun error -> Js.log error |> Js.Promise.resolve))

let () = Window.onload Window.window main
