describe ConfirmationsController, type: :controller do
  it 'should be a child of Devise::ConfirmationsController' do
    expect(controller.class.superclass).to be(Devise::ConfirmationsController)
  end
end
