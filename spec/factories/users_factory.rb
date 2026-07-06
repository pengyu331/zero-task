# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "messi@github.com" }
    password { "password" }
  end
end
