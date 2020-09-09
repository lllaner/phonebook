class Api::V1::TestPassagesController < Api::ApplicationController
  skip_before_action :verify_authenticity_token
  def create

  end

  def show

  end

  def start
    if authenticate_token(params[:token])
      render json: { questions: find_data }
    else
      render json: {error: 'Invalid token'}
    end
  end

  private

  def find_data
    @questions = Test.find(params[:test_id]).questions
    @data = []

    @questions.each do |question|
      answers = []
      question.answers.each do |answer|
        answers << answer.attributes
      end
    @data << question.attributes.merge(answers: answers)
    end
    @data
  end
end
