require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = albums(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
    assert_select 'title', 'Music Library'
    assert_select 'h2', 'Albums'
    assert_template layout: 'application'
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', 'Music Library'
    assert_select 'h1', 'New Album'
    assert_template layout: 'application'
  end

  test "should create album" do
    assert_difference('Album.count') do
      post :create, album: { album_artist: @album.album_artist, album_title: @album.album_title + " create", release_date: @album.release_date}
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show album" do
    get :show, id: @album
    assert_response :success
    assert_select 'title', 'Music Library'
    assert_select 'h2', @album.album_title
    assert_template layout: 'application'
  end

  test "should get edit" do
    get :edit, id: @album
    assert_response :success
    assert_select 'title', 'Music Library'
    assert_template layout: 'application'
  end

  test "should update album" do
    patch :update, id: @album, album: { album_artist: @album.album_artist, album_title: @album.album_title, release_date: @album.release_date }
    assert_redirected_to album_path(assigns(:album))
  end

  test "should destroy album" do
    assert_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to albums_path
  end
end
