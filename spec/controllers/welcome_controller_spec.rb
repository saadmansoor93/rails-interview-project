require "rails_helper"

RSpec.describe WelcomeController,  :type => :controller do
  describe "get #index" do
    tenant = Tenant

    before do
      user = User.create(name: 'Saad')
      question = Question.create(title: 'Question Title', private: false, user: user)
      question.answers.create(body: 'Question body', user: user)
      tenant = Tenant.create(name: user)
    end

    context "when index route is invoked" do
      it 'renders the welcome dashboard' do
        get :index

        expect(User.count).to eq 1
        expect(Question.count).to eq 1
        expect(Answer.count).to eq 1
        expect(Tenant.all).to eq [tenant]
         # Since our response is a render action to the welcome page, this 'expect' helps us determine whether our index page was rendered
        expect(response.content_type).to eq "text/html"  
      end
    end
  end
end
