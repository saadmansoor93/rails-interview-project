require "rails_helper"

RSpec.describe QuestionController,  :type => :controller do
  describe "get #questions" do
    api_key = ''

    before do
      user = User.create(name: 'Saad')
      question = Question.create(title: 'Question Title', private: false, user: user)
      question.answers.create(body: 'Question body', user: user)
      tenant = Tenant.create(name: user)

      api_key = tenant.api_key
    end

    context "when the tenant api_key is inavlid" do
      it 'throws an error' do
        get :show, params: { api_key: '1' }

        # Since our api_key is not valid, we get a 401
        expect(response.status).to eq 401  
      end
    end

    context "when the tenant api_key is valid" do
      it 'renders the show page with a json object' do
        get :show, params: { api_key: api_key }
        
        # Since our response is a render action to the show page, this 'expect' helps us determine whether our show page was rendered
        expect(response.content_type).to eq "text/html"
        expect(response.status).to eq 200
      end
    end
  end
end
