class Reaction < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  enum reaction: %i[like smile thumbs_up]
end
