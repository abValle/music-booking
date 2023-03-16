class Push < ApplicationRecord
  belongs_to :user
  belongs_to :proposal

  # after_create_commit -> { broadcast_prepend_to :current_user }
end

# , partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
