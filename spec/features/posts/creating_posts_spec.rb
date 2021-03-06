require 'rails_helper.rb'

feature 'Creating posts' do
  background do
    create(:user)
    visit '/'
    find('.sign-in').click
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  scenario 'can create a post' do
    find('.new-post').click
    attach_file('Image', 'spec/files/images/attachment.jpeg')
    fill_in 'post_caption', with: "Live laugh love!!!"
    click_button 'Create Post'
    expect(page).to have_content "Live laugh love!!!"
    expect(page).to have_css("img[src*='attachment.jpeg']")
    expect(page).to have_content 'Your post has been uploaded'
  end
  scenario 'needs an image to create a post' do
    find('.new-post').click
    fill_in 'post_caption', with: "No picture here!!!"
    click_button 'Create Post'
    expect(page).to have_content "Please attach a picture"
  end
end
