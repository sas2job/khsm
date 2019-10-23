require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  context 'viewed by non-current user' do
    before(:each) do
      assign(:user, FactoryBot.build_stubbed(:user, name: 'Kat'))

      render
    end

    it 'renders user name' do
      expect(rendered).to match 'Kat'
    end

    it 'doesnt render change password button' do
      expect(rendered).not_to match 'Сменить имя и пароль'
    end

    it 'renders game partial' do
      assign(:games, [FactoryBot.build_stubbed(:game)])
      stub_template 'users/_game.html.erb' => "User game goes here"

      render
      expect(rendered).to match "User game goes here"
    end
  end

  context 'viewed by current user' do
    before(:each) do
      current_user = assign(:user, FactoryBot.build_stubbed(:user, name: 'Kat'))
      allow(view).to receive(:current_user).and_return(current_user)

      render
    end

    it 'renders change password button' do
      expect(rendered).to match 'Сменить имя и пароль'
    end
  end
end
