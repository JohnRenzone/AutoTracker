require 'rails_helper'

RSpec.describe Dealership, type: :model do
  it { should have_many(:users) }

  context 'validations' do
    it "should not be valid" do
      FactoryGirl.build(:dealership, title: nil).should_not be_valid
    end

    it "should be valid" do
      FactoryGirl.build(:dealership, title: 'XXXXXX').should be_valid
    end
  end
end
