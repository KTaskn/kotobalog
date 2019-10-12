class Api::StatusController < ApplicationController
  def check
    render :json => {
      'result': true
    }
  end
end
