require "rails_helper"
 include ActionDispatch::TestProcess

 RSpec.describe OrdersController, :type => :controller do
   describe "testing order controller actions" do
     it "should respond 200 and render template to index" do
       get :index

       expect(response).to be_success
       expect(response).to have_http_status(200)
       expect(response).to render_template("index")
     end

     it "should respond 200 and render template to show" do
       @order = FactoryGirl.create(:order)
       get :show, id: @order.id

       expect(response).to be_success
       expect(response).to have_http_status(200)
       expect(response).to render_template("show")
     end

     it "should respond 200 and render template to destroy" do
       @order = FactoryGirl.create(:order)
       delete :destroy, id: @order.id

       expect(response).to be_redirect
     end

     it "should import a file with success" do
       file = fixture_file_upload("files/test_input.tab", "text/plain")
       post :import, file: file

       expect(response).to be_redirect
       expect(flash[:success]).to be_present
     end

     it "should not import a nil file" do
       post :import, file: nil

       expect(response).to be_redirect
       expect(flash[:error]).to be_present
     end

     it "should not import a non-text file" do
       file = fixture_file_upload("files/test.gif", "text/plain")
       post :import, file: file

       expect(response).to be_redirect
       expect(flash[:error]).to be_present
     end
   end
 end
