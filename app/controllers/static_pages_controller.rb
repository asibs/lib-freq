class StaticPagesController < ApplicationController
  def about
    @page = :about
  end

  def faq
    @page = :faq
  end
end
