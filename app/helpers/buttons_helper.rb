module ButtonsHelper
  def create_button
     link_to "Add New Item", new_box_path, :class => "mega_button"
   end
end
