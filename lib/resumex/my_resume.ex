defmodule Resumex.MyResume do
  @spec info() :: map()
  def info do
    %{
      first_name: "Teerawat",
      last_name: "Lamanchart",
      nick_name: "Ton",
      profession: "Software developer",
      email: "teerawat.lamanchart@gmail.com",
      address: "Bangkok, Thailand 10260",
      about_me: "I love coding and learning new things",
      github: "https://github.com/tteerawat",
      education: education(),
      experience: experience(),
      skills: skills(),
      languages: languages()
    }
  end

  defp education do
    [
      %{
        from: 2011,
        to: 2014,
        school: "King Mongkut's Institute of Technology Ladkrabang",
        degree: "Bachelor's degree",
        field_of_study: "Electrical Engineering"
      }
    ]
  end

  defp experience do
    [
      %{
        title: "Software developer",
        company: "Omise",
        from: "Sep 2015",
        to: "Mar 2020",
        company_website: "https://www.omise.co/"
      },
      %{
        title: "Software developer",
        company: "Nimbl3",
        from: "Mar 2015",
        to: "Aug 2015",
        company_website: "https://nimblehq.co/"
      },
      %{
        title: "Technical Support Analyst",
        company: "Greenline Synergy",
        from: "Jun 2014",
        to: "Feb 2015",
        company_website: "https://www.glsict.com/"
      }
    ]
  end

  defp skills do
    [
      "Ruby/Ruby on Rails",
      "Elixir/Phoenix",
      "PostgreSQL",
      "Elasticsearch"
    ]
  end

  defp languages do
    [
      "Thai",
      "English"
    ]
  end
end
