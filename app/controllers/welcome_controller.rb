class WelcomeController < ApplicationController
  def joining
  end

  def charter
  end

  def legend
  end

  def experience_calc

  end

  def google3644afdf7cfa2db2

  end

  def check_experience
    if params[:current_experience].to_i > 0
      @result = PlayerLevel.check_gived_experience(params[:current_experience], params[:desired_level])
    end
    render :json => @result
  end
end
