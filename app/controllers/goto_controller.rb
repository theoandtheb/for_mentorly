class GotoController < ApplicationController
  def send_to
    @stub = Stub.find_by_end_url(params[:in_url])
    @stub.increment!(:count)
    redirect_to @stub.start_url, :status => 301
  end
end
