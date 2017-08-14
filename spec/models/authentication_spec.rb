require 'rails_helper'

describe Authentication, :type => :model do
  let(:user) {FactoryGirl.build(:dealer)}
  let(:authentication) {FactoryGirl.build(:authentication)}

  # skip "add some examples to (or delete) #{__FILE__}"
  # todo: check loading of oath_data and default_scope

  it { should belong_to(:user) }

  it 'belongs to User' do
     expect(authentication.valid?).to be_truthy
  end

  it 'requires provider' do
    authentication.provider = nil
    expect(authentication).not_to be_valid
  end

  it 'requires provider Id' do
    authentication.proid = nil
    expect(authentication).not_to be_valid
  end

  it 'requires user Id' do
    authentication.user_id = nil
    expect(authentication).not_to be_valid
  end


end
