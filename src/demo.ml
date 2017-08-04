let main () = Chrome.Identity.getAuthToken (Chrome.Identity.mkAuthOptions ~interactive:Js.true_ ()) (fun token ->
    Google_drive.getDirectories token
    |> Js.Promise.then_ (fun name -> Js.log name |> Js.Promise.resolve)
    |> (fun _ -> ()))

   let () = Window.onload Window.window main
