require 'rails_helper'

describe Quiz, type: :model do
  it { should have_many(:questions) }
  it { should validate_presence_of(:subject) }
end
