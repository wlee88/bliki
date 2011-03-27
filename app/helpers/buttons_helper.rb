module ButtonsHelper
  def create_button
     link_to "Create", new_box_path, :class => "mega_button"
   end
end
