defmodule Resumex.Router do
  use Plug.Router

  alias Resumex.MyResume

  plug(:match)
  plug(:dispatch)

  @templates_folder "lib/resumex/templates"

  get "/resume.html" do
    htlm_body =
      @templates_folder
      |> Path.join("resume.html.eex")
      |> EEx.eval_file(info: MyResume.info())

    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> send_resp(200, htlm_body)
  end

  get "/resume" do
    send_json_response(conn, 200, MyResume.info())
  end

  match _ do
    send_json_response(conn, 404, %{
      "object" => "error",
      "code" => "not_found",
      "message" => "not found"
    })
  end

  defp send_json_response(conn, status, data) when is_map(data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Jason.encode!(data))
  end
end
