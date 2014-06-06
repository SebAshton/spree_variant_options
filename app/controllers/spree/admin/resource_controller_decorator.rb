Spree::Admin::ResourceController.class_eval do
  def permitted_resource_params
    params.require(object_name).permit!
  end
end
