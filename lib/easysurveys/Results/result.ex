defmodule Easysurveys.Results.Result do
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "result" do
      field :key, :string
      field :result, :string
    end
  
    def changeset(result, attrs) do
      result
      |> cast(attrs, [
        :key,
        :result
        ])
    end
  end