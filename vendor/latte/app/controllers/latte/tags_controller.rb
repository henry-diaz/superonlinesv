module Latte
  class TagsController < Latte::ApplicationController

    respond_to :json

    def index
      respond_with ActsAsTaggableOn::Tag.all.map(&:name)
    end
  end
end
