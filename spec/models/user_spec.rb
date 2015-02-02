require 'rails_helper'

RSpec.describe User, :type => :model do

  before(:all) do
    @valid_user = User.new(
      name: 'Francesca Flowers',
      email: 'fran@flowers.com',
      password: 'abc-123',
      password_confirmation: 'abc-123')
    @valid_user.county = County.first
    @valid_user.save
  end

  it 'is valid with a name, valid email, county, a valid password & matching password_confirmation' do
    expect(@valid_user).to be_valid
  end

  it 'has is_admin set to false by default' do
    expect(@valid_user.is_admin).to eq (false)
  end

  it 'is invalid with a duplicate email' do
    new_user = User.new(
      name: 'Any Name',
      email: 'fran@flowers.com',  #duplicate email
      password: 'xyz-789',
      password_confirmation: 'xyz-789')
    expect(new_user).to be_invalid
  end

  it 'is invalid without a matching password_confirmation' do
    user = User.new(
      name: 'Francesca Flowers',
      email: 'fran@flowers.com',
      password: 'abc-123',
      password_confirmation: 'xyz-789')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it 'is invalid with a password of less than 4 characters' do
    user = User.new(password: 'abc', password_confirmation: 'abc')
    user.valid?
    expect(user.errors[:password]).to include('is too short (minimum is 4 characters)')
  end

  it 'is invalid without a name' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a county' do
    user = User.new(county: nil)
    user.valid?
    expect(user.errors[:county]).to include("can't be blank")
  end

  it 'is invalid without a valid email format' do
    user = User.new(
      name: 'Francesca Flowers',
      email: 'fran@flowers.com',
      password: 'abc-123',
      password_confirmation: 'abc-123')
    emails = ['abc', 'abc123@abc.a']
    emails.each do |e|
      user.email = e
      expect(user).to be_invalid
    end
  end

  it 'is invalid without a county'

end