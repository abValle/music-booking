class RemoveChatroomfromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :chatroom_id
  end
end
