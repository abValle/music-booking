class RemoveReviewCompanyFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :review_company, :text
  end
end
