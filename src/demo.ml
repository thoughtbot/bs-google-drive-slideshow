open Bs_webapi.Dom

let createFolderDom f = f.Google_drive.files
                        |> Array.map (fun folder ->
                            document
                            |> Document.createElement "div")

let main () = Chrome.Identity.getAuthToken (Chrome.Identity.mkAuthOptions ~interactive:Js.true_ ()) (fun token ->
    Google_drive.getDirectories token
    |> Js.Promise.then_ (fun name -> createFolderDom name |> Js.Promise.resolve)
    |> Js.Promise.then_ (fun _ -> () |> Js.Promise.resolve)
    |> Js.Promise.catch (fun error -> Js.log error |> Js.Promise.resolve))

let () = Window.setOnLoad window main
