defmodule Easysurveys.Forms.Form do
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "form" do
      field :key, :string
      field :formdata, :string
    end
  
    def changeset(form, attrs) do
      form
      |> cast(attrs, [
        :key,
        :formdata
        ])
    end
  end