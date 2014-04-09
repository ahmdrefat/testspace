require "spec_helper"

describe Devise::RegistrationsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #new" do
    it "should get sign_up form" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
      end
  end

  describe "POST 'create'" do
    describe "success" do
      before(:each) do
        @attributes = attributes_for(:user)
      end
      it "should create a user" do
        lambda {post :create, :user => @attributes}.should change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
        expect(response.status).to eq(302)
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = create(:user)
      @user.confirm!
      sign_in @user
    end
    describe "Success" do
      it "should change the user's username" do
        patch :update, id: @user, user: attributes_for(:user_params, username: 'new_username')
        updated_user = assigns(:user)
        @user.reload
        expect(@user.username).to eq(updated_user.username)
      end
    end
  end


end
