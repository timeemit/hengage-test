require 'spec_helper'

describe ProjectsController do  
  def valid_attributes
    attributes_for(:project)
  end
  
  describe 'as an admin' do
    let(:user) { create(:admin) }

    before(:each) do
      sign_in user
    end
  
    describe "GET index" do
      it "assigns all projects as @projects" do
        project = Project.create! valid_attributes
        get :index, {}
        assigns(:projects).should eq([project])
      end
    end

    describe "GET show" do
      let(:report_time) {
        { 
          'start_time(1i)' => Time.now.year,
          'start_time(2i)' => Time.now.month,
          'start_time(3i)' => Time.now.day,
          'start_time(4i)' => Time.now.hour,
          'start_time(5i)' => Time.now.min,
          'end_time(1i)' => Time.now.year,
          'end_time(2i)' => Time.now.month,
          'end_time(3i)' => Time.now.day,
          'end_time(4i)' => Time.now.hour,
          'end_time(5i)' => Time.now.min,
        }
      }

      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        get :show, {:id => project.to_param}
        assigns(:project).should eq(project)
      end
   
      it "assigns a report to the requested project as @project_report" do
        project = Project.create! valid_attributes
        get :show, {:id => project.to_param}
        assigns(:project_report).should_not be_nil
      end
      
      it 'redirects if the start and end dates are equal' do
        project = Project.create! valid_attributes
        get :show, {:id => project.to_param, :report => report_time}
        response.should be_redirect
        assigns(:project_report).should be_nil
      end

      it 'redirects if the start and end dates are nonsensical' do
        project = Project.create! valid_attributes
        report_time['end_time(5i)'] = (Time.now - 1.minute).min
        get :show, {:id => project.to_param, :report => report_time}
        response.should be_redirect
        assigns(:project_report).should be_nil
      end

    end

    describe "GET new" do
      it "assigns a new project as @project" do
        get :new, {}
        assigns(:project).should be_a_new(Project)
      end
    end

    describe "GET edit" do
      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        get :edit, {:id => project.to_param}
        assigns(:project).should eq(project)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Project" do
          expect {
            post :create, {:project => valid_attributes}
          }.to change(Project, :count).by(1)
        end

        it "assigns a newly created project as @project" do
          post :create, {:project => valid_attributes}
          assigns(:project).should be_a(Project)
          assigns(:project).should be_persisted
        end

        it "redirects to the created project" do
          post :create, {:project => valid_attributes}
          response.should redirect_to(Project.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved project as @project" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          post :create, {:project => {  }}
          assigns(:project).should be_a_new(Project)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          post :create, {:project => {  }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested project" do
          project = Project.create! valid_attributes
          # Assuming there are no other projects in the database, this
          # specifies that the Project created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Project.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
          put :update, {:id => project.to_param, :project => { "these" => "params" }}
        end

        it "assigns the requested project as @project" do
          project = Project.create! valid_attributes
          put :update, {:id => project.to_param, :project => valid_attributes}
          assigns(:project).should eq(project)
        end

        it "redirects to the project" do
          project = Project.create! valid_attributes
          put :update, {:id => project.to_param, :project => valid_attributes}
          response.should redirect_to(project)
        end
      end

      describe "with invalid params" do
        it "assigns the project as @project" do
          project = Project.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, {:id => project.to_param, :project => {  }}
          assigns(:project).should eq(project)
        end

        it "re-renders the 'edit' template" do
          project = Project.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, {:id => project.to_param, :project => {  }}
          response.should render_template("edit")
        end
      end
    end
  end
  
  describe 'as a non-admin' do
    let(:user) { create(:user) }

    before(:each) do
      sign_in user
    end
  
    describe "GET index" do
      it "assigns all projects as @projects" do
        project = Project.create! valid_attributes
        get :index, {}
        assigns(:projects).should eq([project])
      end
    end

    describe "GET show" do
      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        get :show, {:id => project.to_param}
        assigns(:project).should eq(project)
      end
    end

    describe "GET new" do
      it "redirects away from the page" do
        get :new, {}
        response.should be_redirect
      end
    end

    describe "GET edit" do
      it "redirects away from the page" do
        project = Project.create! valid_attributes
        get :edit, {:id => project.to_param}
        response.should be_redirect
      end
    end

    describe "POST create" do
      it "does not create a new Project" do
        expect {
          post :create, {:project => valid_attributes}
        }.to change(Project, :count).by(0)
      end

      it "does not assign a newly created project as @project" do
        post :create, {:project => valid_attributes}
        assigns(:project).should_not be_a(Project)
        assigns(:project).should be_nil
      end

      it "just redirects" do
        post :create, {:project => valid_attributes}
        response.should be_redirect
      end
    end

    describe "PUT update" do
      it "does not update the requested project" do
        project = Project.create! valid_attributes
        Project.any_instance.should_not_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => project.to_param, :project => { "these" => "params" }}
      end

      it "does not assign the requested project as @project" do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}
        assigns(:project).should be_nil
      end

      it "just redirects" do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}
        response.should be_redirect
      end
    end
  end
end
