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

  describe "Scope filter and search" do
    let(:user) { create(:user) }
    let(:active_task) { create(:task, user: user, description: "Learning Ruby") }
    let(:completed_task) { create(:task, user: user, description: "Play chess with friends", state: :completed) }

    it "should works with filter_by_state" do
      expect(Task.filter_by_state("active")).to include(active_task)
      expect(Task.filter_by_state("active")).not_to include(completed_task)
      expect(Task.filter_by_state("completed")).to include(completed_task)
      expect(Task.filter_by_state("all")).to include(active_task, completed_task)
    end

    it "should works with search_by_keyword" do
      expect(Task.search_by_keyword("Ruby")).to include(active_task)
      expect(Task.search_by_keyword("chess")).to include(completed_task)
    end
  end
end
