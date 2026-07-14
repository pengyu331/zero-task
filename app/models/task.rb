# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  enum :state, {active: 0, completed: 1}

  validates :description, presence: true, length: {maximum: 140}
end
