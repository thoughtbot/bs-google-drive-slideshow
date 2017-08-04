open Bs_fetch

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

let gDriveURL = "https://www.googleapis.com/drive/v3/files?pageSize=1000&q="
                ^ Window.encodeURIComponent "mimeType = 'application/vnd.google-apps.folder'"
let authHeaders token = Array.make 1 ("Authorizaton", "Bearer " ^ token) |> HeadersInit.makeWithArray


let getDirectories token = Js.Promise.(
    fetchWithInit gDriveURL (RequestInit.make ~headers:(authHeaders token) ())
    |> then_ Response.json
    |> then_ (fun json -> json |> Decode.gDriveFiles |> resolve))
