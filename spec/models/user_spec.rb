require 'rails_helper'

RSpec.describe User do
  describe 'Relationships' do
    it {should have_many :images}
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end
end
