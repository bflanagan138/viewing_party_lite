# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user dashboard' do
  before(:each) do
    stub_request(:get, "https://api.themoviedb.org/3/movie/238?api_key=#{ENV['api_key']}")
      .to_return(status: 200, body: File.read('spec/fixtures/movie_details_godfather238.json'), headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/movie/603?api_key=#{ENV['api_key']}")
      .to_return(status: 200, body: File.read('spec/fixtures/movie_details_matrix603.json'), headers: {})

    @user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                          password_confirmation: 'plaintxtpassword')
    @vp1 = ViewingParty.create!(movie_id: 238, date: 'Mon, 30 Jan 2023', party_duration: 118,
                                start_time: Time.parse('19:00:00 UTC'))
    @vp2 = ViewingParty.create!(movie_id: 603, date: 'Tue, 31 Jan 2023', party_duration: 95,
                                start_time: Time.parse('20:00:00 UTC'))
    @user1.viewing_party_users.create!(viewing_party_id: @vp1.id, hosting: true)
    @user1.viewing_party_users.create!(viewing_party_id: @vp2.id, hosting: false)
  end

  it "shows the <user's name>'s dashboard at the top of the page" do
    visit login_path

    fill_in 'Email', with: 'johndoe@ymail.com'
    fill_in 'Password', with: 'plaintxtpassword'

    click_on 'Log in'

    expect(page).to have_content("John Doe's Dashboard")
  end

  it 'has a button to discover movies and when I click that button I am redirected to user discover page' do
    visit login_path

    fill_in 'Email', with: 'johndoe@ymail.com'
    fill_in 'Password', with: 'plaintxtpassword'

    click_on 'Log in'

    expect(page).to have_button('Discover Movies')
    click_button 'Discover Movies'

    expect(current_path).to eq discover_index_path
  end

  it 'has a section that lists viewing parties' do
    visit login_path

    fill_in 'Email', with: 'johndoe@ymail.com'
    fill_in 'Password', with: 'plaintxtpassword'

    click_on 'Log in'

    within "#viewing_party#{@vp1.id}" do
      expect(page).to have_content('January 30, 2023')
      expect(page).to have_content('7:00 pm')
      expect(page).to have_content('Hosting')
    end
    within "#viewing_party#{@vp2.id}" do
      expect(page).to have_content('January 31, 2023')
      expect(page).to have_content('8:00 pm')
      expect(page).to have_content('Invited')
    end
  end

  it 'requires you to be a registered user to access a dashboard' do
    visit '/dashboard'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You must be logged in to access this page')
  end
end
