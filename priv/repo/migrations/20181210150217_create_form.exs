defmodule Easysurveys.Repo.Migrations.CreateForm do
  use Ecto.Migration

  def change do
    create table(:form) do
      add :key, :string
      add :formdata, :text
    end
  end
end
