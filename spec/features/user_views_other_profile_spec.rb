require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.feature 'USER views other user profile', type: :feature do
  let(:user) { FactoryBot.create(:user, name: 'alex') }
  let(:first_game) do
    FactoryBot.create(
        :game,
        user: user,
        current_level: 5,
        created_at: Time.parse('2019-10-08 15:00'),
        finished_at: Time.parse('2019-10-08 15:15'),
        fifty_fifty_used: true,
        prize: 1000
    )
  end
  let(:second_game) do
    FactoryBot.create(
        :game,
        user: user,
        prize: 32000,
        current_level: 10,
        created_at: Time.parse('2019-10-08 16:00')
    )
  end
  let!(:games) { [first_game, second_game] }
  let(:user) { FactoryBot.create(:user, name: 'serg') }
  scenario 'anonim views user profile' do
    visit '/'

    click_link 'serg'

    expect(page).to have_current_path "/users/#{user.id}"
    expect(page).to have_content 'serg'
    expect(page).to have_selector 'tr.text-center', count: games.count
    expect(page).not_to have_content 'Сменить имя и пароль'

    # 1я игра
    expect(page).to have_content '1' #id
    expect(page).to have_content 'деньги'
    expect(page).to have_content '08 окт., 15:00'
    expect(page).to have_content '5'
    expect(page).to have_content '1 000'

    # 2я игра
    expect(page).to have_content '2'
    expect(page).to have_content 'в процессе'
    expect(page).to have_content '08 окт., 16:00'
    expect(page).to have_content '10'
    expect(page).to have_content '32 000'
  end
end
