open Bs_webapi.Dom

let flip f x y = f y x

let createFolderLi f =
  let li = document |> Document.createElement "li" in
  let txt = document |> Document.createTextNode f.Google_drive.name in
  let input = document |> Document.createElement "input" in
  let () = Element.setAttribute "type" "checkbox" input in
  let () = Element.appendChild input li in
  let () = Element.appendChild txt li in
  li

let createFolderDom f =
  f.Google_drive.files
  |> Array.map createFolderLi

let displayFolderDom f = document
                         |> Document.getElementById("folders")
                         |> (function
                             | None -> ()
                             | Some el -> f |> Array.iter (flip Element.appendChild el))


let main () = Chrome.Identity.getAuthToken (Chrome.Identity.mkAuthOptions ~interactive:Js.true_ ()) (fun token ->
    Google_drive.getDirectories token
    |> Js.Promise.then_ (fun name -> createFolderDom name |> Js.Promise.resolve)
    |> Js.Promise.then_ (fun els -> displayFolderDom els |> Js.Promise.resolve)
    |> Js.Promise.catch (fun error -> Js.log error |> Js.Promise.resolve))

let () = Window.setOnLoad window main
