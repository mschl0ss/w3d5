class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |name|
    # for name in names

      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |new_value|
        instance_variable_set("@#{name}", new_value)
      end
   

    end # end for loop
  
  end #end of self.my_attr_accessor


end #end of class
