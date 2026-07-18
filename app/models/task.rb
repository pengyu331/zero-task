# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  enum :state, {active: 0, completed: 1}

  validates :description, presence: true, length: {maximum: 140}

  scope :recent, -> { order(created_at: :desc) }
  scope :search_by_keyword, ->(keyword) {
    where("description LIKE ?", "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
  scope :filter_by_state, ->(state_param) {
    where(state: state_param) if state_param.present? && state_param != 'all'
  }
end
