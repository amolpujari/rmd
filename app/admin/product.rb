ActiveAdmin.register Product do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

permit_params :name, :description, :price,
            category_ids: []

  controller do
    def scoped_collection
      super.includes :categories
    end
  end      

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :categories_name
    end
  end        


  form do |f|
    f.semantic_errors *f.object.errors.keys # shows errors on :base
    
    f.inputs 'Product Details' do
      input :name
      input :description
      input :price
    end

    f.inputs 'Categories' do
      f.input :category_ids, label: 'Names', as: :select, collection: f.object.categories.pluck(:name, :id), input_html: { class: "chosen-categories", multiple: true, 'data-placeholder' => 'Start typing...' }
    end

    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

end
