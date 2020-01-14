require 'json'
require 'pry'
class QuestionController < ApplicationController
  def show
    tenant = Tenant.find_by(api_key: params[:api_key])
    
    if tenant
      tenant.request_count += 1
      tenant.save!

      questions = Question.where(private: false)
      
      qna = questions.map do |q|
        { 
          "title": q.title, "user_id": q.user_id, "user_name": User.find(q.user_id).name,
          "answers":
            q.answers.map do |a|
              { "body": a.body, "user_id": a.user_id, "user_name": User.find(a.user_id).name }
            end
        }
      end
      
      @qna = JSON.pretty_generate(qna)
    else
      render :file => "public/401.html", :status => :unauthorized
    end
  end
end
