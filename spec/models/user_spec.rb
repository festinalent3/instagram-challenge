require 'spec_helper'

describe User, type: :model do
  subject(:user) { User.create email: 'test@test.com', password: '123Test' }

  it { should have_many :posts }
  it { should have_many :comments }

  it { is_expected.to have_many :commented_posts }

end
