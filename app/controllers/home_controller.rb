class HomeController < ApplicationController
  def index
    @people = Person.all
    @companies = Company.all
  end
end
