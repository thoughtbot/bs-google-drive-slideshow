open Bs_fetch

let main () = Chrome.Identity.getAuthToken (Chrome.Identity.mkAuthOptions ~interactive:Js.true_ ()) (fun token ->
    Js.log token)

(* Move to GoogleDrive module *)

let folderQueryParam = Window.encodeURIComponent "mimeType = 'application/vnd.google-apps.folder'"
let gDriveURL = "https://www.googleapis.com/drive/v3/files?pageSize=1000&q=" ^ folderQueryParam
let authHeaders token = Array.make 1 ("Authorizaton", "Bearer " ^ token)

type gDriveFile = {
  mimeType: string;
  id: string;
  name: string;
}

type gDriveFiles = {
  files: gDriveFile array
}

module Decode = struct
  let gDriveFile json =
    Json.Decode.{
      mimeType = json |> field "mimeType" string;
      id = json |> field "id" string;
      name = json |> field "name" string;
    }

  let gDriveFiles json =
    Json.Decode.{
      files = json |> field "files" (array gDriveFile);
    }
end

let getDirectories token = Js.Promise.(
    fetchWithInit
      gDriveURL
      (RequestInit.make ~headers:(HeadersInit.makeWithArray (authHeaders token)) ())
    |> then_ Response.json
    |> then_ (fun json -> json |> Decode.gDriveFiles |> resolve)
  )

let () = Window.onload Window.window main
