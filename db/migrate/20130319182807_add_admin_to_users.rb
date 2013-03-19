class AddAdminToUsers < ActiveRecord::Migration
  # NOTE: I seriously considered Ryan Bates' railscast on polymorphic associations for stateful users.
  # http://railscasts.com/episodes/394-sti-and-polymorphic-associations
  # Ultimately decided that it was more robust of a solution than I needed for the task at hand.

  def change
    add_column :users, :admin, :boolean, default: false
  end
end
