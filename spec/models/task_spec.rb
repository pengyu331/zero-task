# frozen_string_literal: true

require "rails_helper"

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(140) }

  it { should have_db_column(:description).of_type(:string) }
  it { should have_db_column(:state).of_type(:integer) }
  it { should have_db_index([:user_id, :state]) }
  it { should have_db_index(:user_id) }
  it { should belong_to(:user).class_name("User") }
end
