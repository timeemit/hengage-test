require 'spec_helper'

describe TimeBlocksController do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  
  def valid_attributes
    time_block = attributes_for(:time_block)
    time_block[:user_id] = user.id
    time_block[:project_id] = project.id
    time_block
  end

  before(:each) do
    sign_in user
  end

  describe "GET index" do
    it "assigns all time_blocks as @time_blocks" do
      time_block = TimeBlock.create! valid_attributes
      get :index
      assigns(:time_blocks).should eq([time_block])
    end
  end

  describe "GET show" do
    it "assigns the requested time_block as @time_block" do
      time_block = TimeBlock.create! valid_attributes
      get :show, {:id => time_block.to_param}
      assigns(:time_block).should eq(time_block)
    end
  end

  describe "GET new" do
    it "assigns a new time_block as @time_block" do
      get :new, {}
      assigns(:time_block).should be_a_new(TimeBlock)
    end
  end

  describe "GET edit" do
    it "assigns the requested time_block as @time_block" do
      time_block = TimeBlock.create! valid_attributes
      get :edit, {:id => time_block.to_param}
      assigns(:time_block).should eq(time_block)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TimeBlock" do
        expect {
          post :create, {:time_block => valid_attributes}
        }.to change(TimeBlock, :count).by(1)
      end

      it "assigns a newly created time_block as @time_block" do
        post :create, {:time_block => valid_attributes}
        assigns(:time_block).should be_a(TimeBlock)
        assigns(:time_block).should be_persisted
      end

      it "redirects to the created time_block" do
        post :create, {:time_block => valid_attributes}
        response.should redirect_to(TimeBlock.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved time_block as @time_block" do
        TimeBlock.any_instance.stub(:save).and_return(false)
        post :create, {:time_block => {  }}
        assigns(:time_block).should be_a_new(TimeBlock)
      end

      it "re-renders the 'new' template" do
        TimeBlock.any_instance.stub(:save).and_return(false)
        post :create, {:time_block => {  }}
        response.should render_template("new")
      end
    end
    
    describe 'with valid params but for a different user' do
      it "creates a new TimeBlock that is made for the user" do
        attrs = valid_attributes
        attrs[:user_id] = create(:admin).id
        expect {
          post :create, {:time_block => attrs}
        }.to change(TimeBlock, :count).by(1)
        TimeBlock.last.user_id.should eql user.id
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested time_block" do
        time_block = TimeBlock.create! valid_attributes
        TimeBlock.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => time_block.to_param, :time_block => { "these" => "params" }}
      end

      it "assigns the requested time_block as @time_block" do
        time_block = TimeBlock.create! valid_attributes
        put :update, {:id => time_block.to_param, :time_block => valid_attributes}
        assigns(:time_block).should eq(time_block)
      end

      it "redirects to the time_block" do
        time_block = TimeBlock.create! valid_attributes
        put :update, {:id => time_block.to_param, :time_block => valid_attributes}
        response.should redirect_to(time_block)
      end
    end

    describe "with invalid params" do
      it "assigns the time_block as @time_block" do
        time_block = TimeBlock.create! valid_attributes
        TimeBlock.any_instance.stub(:save).and_return(false)
        put :update, {:id => time_block.to_param, :time_block => {  }}
        assigns(:time_block).should eq(time_block)
      end

      it "re-renders the 'edit' template" do
        time_block = TimeBlock.create! valid_attributes
        TimeBlock.any_instance.stub(:save).and_return(false)
        put :update, {:id => time_block.to_param, :time_block => {  }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested time_block" do
      time_block = TimeBlock.create! valid_attributes
      expect {
        delete :destroy, {:id => time_block.to_param}
      }.to change(TimeBlock, :count).by(-1)
    end

    it "redirects to the time_blocks list" do
      time_block = TimeBlock.create! valid_attributes
      delete :destroy, {:id => time_block.to_param}
      response.should redirect_to(time_blocks_url)
    end
  end

end
