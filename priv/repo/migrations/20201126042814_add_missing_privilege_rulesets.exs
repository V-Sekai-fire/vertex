defmodule Uro.Repo.Migrations.AddMissingPrivilegeRulesets do
  use Ecto.Migration

  def up do
    Enum.each Uro.Accounts.list_users_admin, fn user ->
      user
      |> Uro.Repo.preload(user_privilege_ruleset: [:user_privilege_ruleset])
      Uro.Accounts.create_user_privilege_ruleset_for_user(user, %{is_admin: user.is_admin})
    end
  end

  def down do
    Uro.Repo.delete_all(Uro.Accounts.UserPrivilegeRuleset)
  end
end
