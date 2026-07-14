# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    description { "Initialize cyberpunk todo item" }
    state { 0 }

    user
  end
end
