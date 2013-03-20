require 'spec_helper'

describe UsersController do
 
  describe 'when the user is admin' do
    let(:user) { create(:admin) }
    
    before(:each) do 
      user
      sign_in user
    end


    describe "GET 'show'" do
      it "returns http success" do
        get 'show', id: user.id
        response.should be_success
        expect(response).to render_template("show")
      end
    end

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
        expect(response).to render_template("index")
      end
    end

    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        response.should be_success
        expect(response).to render_template("new")
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', id: user.id
        response.should be_success
        expect(response).to render_template("edit")
      end
    end

    describe "POST 'create'" do
      let(:new_email) { 'new@hengage.com' }
      
      it "returns http redirect with valid params" do
        post 'create', {user: {email: new_email}}
        response.should be_redirect
        User.count.should eql 2
        User.last.email.should eql new_email
      end

      it "returns http succes with invalid params" do
        post 'create', {user: {email: 'hello'}}
        expect(response).to render_template("new")
        User.last.email.should_not be_eql new_email
      end
    end

    describe "PUT 'update'" do
      let(:updated_email) { 'revised@hengage.com' }
      
      it "returns http redirect with valid params" do
        put 'update', {id: user.id, user: {email: updated_email} } 
        response.should be_redirect
        user.reload.email.should eql updated_email
      end

      it "returns http success with invalid params" do 
        put 'update', {id: user.id, user: {email: 'hello'} }
        response.should be_success
        User.last.email.should_not be_eql updated_email
      end
    end
  end  
end
