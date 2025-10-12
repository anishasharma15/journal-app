class AddUserRefToResources < ActiveRecord::Migration[8.0]
  def change
    # Step 1: Add the column, but allow nulls initially
    add_reference :resources, :user, foreign_key: true, null: true

    # Step 2 (Optional but needed to fix existing data):
    # If you have an existing User, replace 1 with a valid user ID.
    # This sets the user_id for ALL pre-existing resources.
    # If you don't do this, Step 3 will fail.
    # User.first.id is a good choice if you know you have at least one user.
    if Resource.any?
      user_to_assign = User.first
      if user_to_assign
        Resource.where(user_id: nil).update_all(user_id: user_to_assign.id)
      else
        # If there are resources but no users, you must create a user or handle this logic differently.
        # For now, let's assume User.first is safe.
        puts "WARNING: No Users found to assign existing Resources. Migration may fail if NOT NULL constraint is enforced."
      end
    end

    # Step 3: Enforce the NOT NULL constraint (This is what you originally wanted)
    change_column_null :resources, :user_id, false
  end
end
