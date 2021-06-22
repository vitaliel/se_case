require 'rails_helper'

RSpec.describe CreateCustomerJob, type: :job do
  let(:user) { create(:user, external_id: nil) }

  it 'updates user with external id' do
    instance = double
    expect(Gateway).to receive(:new).and_return(instance)
    expect(instance).to receive(:customer_register).with(user.email).and_return('id' => '1111')
    CreateCustomerJob.perform_now(user)
    user.reload
    expect(user.external_id).to eq '1111'
  end
end
