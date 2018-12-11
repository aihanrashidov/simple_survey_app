defmodule Easysurveys.Repo.Migrations.CreateResult do
  use Ecto.Migration

  def change do
    create table(:result) do
      add :key, :string
      add :result, :text
    end
  end
end
