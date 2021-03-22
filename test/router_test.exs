defmodule Resumex.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  describe "GET /resume.html" do
    setup do
      pid = start_supervised!(Resumex.Counter)

      {:ok, pid: pid}
    end

    test "returns resume response", %{pid: pid} do
      conn =
        :get
        |> conn("/resume.html")
        |> Resumex.Router.call([])

      assert :sys.get_state(pid) == 1
      assert conn.status == 200
      assert Plug.Conn.get_resp_header(conn, "content-type") == ["text/html; charset=utf-8"]
      assert conn.resp_body =~ "<!DOCTYPE html>"
      assert conn.resp_body =~ "Teerawat Lamanchart"
      assert conn.resp_body =~ "Elixir/Phoenix"
      assert conn.resp_body =~ "Omise"
    end
  end

  describe "GET /resume" do
    test "returns resume response" do
      conn =
        :get
        |> conn("/resume")
        |> Resumex.Router.call([])

      assert conn.status == 200

      assert assert_json_response(conn, %{
               "about_me" => "I love coding and learning new things",
               "education" => [
                 %{
                   "degree" => "Bachelor's degree",
                   "field_of_study" => "Electrical Engineering",
                   "school" => "King Mongkut's Institute of Technology Ladkrabang",
                   "from" => 2011,
                   "to" => 2014
                 }
               ],
               "experience" => [
                 %{
                   "company" => "Omise",
                   "from" => "Sep 2015",
                   "title" => "Software developer",
                   "to" => "Mar 2021",
                   "company_website" => "https://www.omise.co/"
                 },
                 %{
                   "company" => "Nimbl3",
                   "from" => "Mar 2015",
                   "title" => "Software developer",
                   "to" => "Aug 2015",
                   "company_website" => "https://nimblehq.co/"
                 },
                 %{
                   "company" => "Greenline Synergy",
                   "from" => "Jun 2014",
                   "title" => "Technical Support Analyst",
                   "to" => "Feb 2015",
                   "company_website" => "https://www.glsict.com/"
                 }
               ],
               "first_name" => "Teerawat",
               "languages" => ["Thai", "English"],
               "last_name" => "Lamanchart",
               "skills" => ["Ruby/Ruby on Rails", "Elixir/Phoenix", "PostgreSQL", "Elasticsearch"],
               "address" => "Bangkok, Thailand 10260",
               "email" => "teerawat.lamanchart@gmail.com",
               "github" => "https://github.com/tteerawat",
               "nick_name" => "Ton",
               "profession" => "Software developer"
             })
    end
  end

  describe "GET unsupported path" do
    test "returns 404" do
      conn =
        :get
        |> conn("/")
        |> Resumex.Router.call([])

      assert conn.status == 404

      assert assert_json_response(conn, %{
               "code" => "not_found",
               "message" => "not found",
               "object" => "error"
             })
    end
  end

  defp assert_json_response(conn, expected) do
    assert Plug.Conn.get_resp_header(conn, "content-type") == ["application/json; charset=utf-8"]
    assert Jason.decode!(conn.resp_body) == expected
  end
end
