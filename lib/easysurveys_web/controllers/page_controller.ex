defmodule EasysurveysWeb.PageController do
  use EasysurveysWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create_form(conn, _params) do
    render(conn, "create_form.html")
  end

  def fill_form(conn, _params) do
    render(conn, "fill_form.html")
  end

  def results(conn, _params) do
    render(conn, "results.html")
  end

  def contact(conn, _params) do
    render(conn, "contact.html")
  end

  def save_form(conn, params) do
    key = params["key"]
    formData = params["formData"]
    resp = Easysurveys.Forms.Operations.save_form(key, formData)
    json(conn, %{response: resp})
  end

  def get_form(conn, params) do
    key = params["key"]
    resp = Easysurveys.Forms.Operations.get_form(key)
    json(conn, %{response: resp})
  end

  def save_results(conn, params) do
    key = params["key"]
    result = params["results"] |> Poison.encode() |> elem(1)
    resp = Easysurveys.Results.Operations.save_results(key, result)
    json(conn, %{response: resp})
  end

  def get_results(conn, params) do
    key = params["key"]
    {new_list, count} = Easysurveys.Results.Operations.get_results(key)
    json(conn, %{list: new_list, count: count})
  end
end
