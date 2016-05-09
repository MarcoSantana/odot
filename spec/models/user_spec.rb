require 'spec_helper'

RSpec.describe "Users", type: :request do
  let(:valid_attributes) {
    {
      name:                   "Marco",
      last_name:              "Santana",
      email:                  "marco.santana@gmail.com",
      password:               "treehouse1234",
      password_confirmation:  "treehouse1234"
    }
   }
  let(:user) { create(:user) }
  context "validations" do


    context "relationships" do
      # TODO: Fix the error that impedes this test to pass
      # it { should have_many(:todo_lists)}

    end

    before do
      User.create(valid_attributes)
    end
    it 'requires an email' do
      expect(user).to validate_presence_of(:email)
    end

    it 'requires unique email' do
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires unique email (case insensitive)' do
      user.email = "MARCO.SANTANA@GMAIL.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires to email look like an email' do
      user.email = "marco"
      expect(user).not_to be_valid
    end

    describe "#downcase_email" do
      it 'makes the email attribute lowercase' do
        user = User.new(valid_attributes.merge(email:"MARCO.SANTANA@GMAIL.COM"))
        expect { user.downcase_email }.to change { user.email }.from("MARCO.SANTANA@GMAIL.COM").to("marco.santana@gmail.com")
      end
    end
    it 'downcases email before saving' do
      user = User.new(valid_attributes)
      user.email = "MARCO.SANTANA@GMAIL.COM"
      expect(user.save).to be true
      expect(user.email).to eq("marco.santana@gmail.com")

    end

    it 'requires a name' do
      expect(user).to validate_presence_of(:name)
    end

    it 'require a last_name' do
      expect(user).to validate_presence_of(:last_name)
    end
  end

  describe "#generate_password_reset_token!" do
    let!(:user) { create(:user ) }


    it 'changes the password_reset_attribute' do
      expect { user.generate_password_reset_token! }.to change{ user.password_reset_token }
    end

    it 'calss SecureRandom.urlsafe_base64 to generate the password_reset_token' do
      expect(SecureRandom).to receive(:urlsafe_base64)
      user.generate_password_reset_token!
    end
  end


end
