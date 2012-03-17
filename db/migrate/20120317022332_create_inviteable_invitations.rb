class CreateInviteableInvitations < ActiveRecord::Migration
  def change
    create_table :inviteable_invitations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :recipient_email
      t.string :token
      t.string :status
      t.timestamps
    end
  end
end
