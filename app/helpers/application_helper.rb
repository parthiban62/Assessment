module ApplicationHelper

  def link_to_add_fields(name, f, association, element_class)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("shared/" + association.to_s.singularize + "_fields", f: builder)
    end
    
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}, html: {class: element_class})
  end

  def link_to_remove_fields(name, f, element_class)
    f.hidden_field(:_destroy) + link_to(name, '#', class: "remove_fields(this)", html: {class: element_class})
  end

end
