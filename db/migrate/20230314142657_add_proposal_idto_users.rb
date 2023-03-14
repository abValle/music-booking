class AddProposalIdtoUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :proposal, foreign_key: true
  end
end
