class ApplicationController < ActionController::Base
  def hello
      render html: "hello, world! (sample_app)"
  end
end
