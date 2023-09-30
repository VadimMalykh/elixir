defmodule Pento.Repo.Migrations.UserAddUsername do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :username, :text
    end
  end
end
