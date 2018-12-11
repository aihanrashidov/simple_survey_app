defmodule Easysurveys.Forms.Operations do

    def save_form(key, formData) do
        form = %Easysurveys.Forms.Form{key: key, formdata: formData}
        Easysurveys.Repo.insert(form) |> elem(0) |> db_response
    end

    def get_form(key) do
      form = Easysurveys.Repo.get_by!(Easysurveys.Forms.Form, key: key)
      form.formdata
    end

    defp db_response(query_resp) do
        case query_resp do
          1 ->
            "Ok."
          :ok ->
            "Ok."
          error ->
            "Error #{inspect(error)}."
        end
      end
end