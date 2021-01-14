require 'rails_helper'

RSpec.describe Post, type: :model do
    describe 'Relationships' do
      it {should belong_to :user}
    end

    describe 'Validations' do
      it { should validate_presence_of :title }
      it { should validate_presence_of :body }
      it { should validate_presence_of :keyword }
    end
end
