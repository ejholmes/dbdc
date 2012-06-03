module Dbdc
  module Sobject
    class Sobject
      cattr_accessor :client

      def initialize(attrs={})
      end

      def self.materialize(sobject_name)
        self.cattr_accessor :sobject_name
        self.cattr_accessor :description
        self.cattr_accessor :field_types

        self.sobject_name = sobject_name
        self.description = self.client.describe_sobject(self.sobject_name)
        self.field_types = {}
        
        self.description['fields'].each do |field|
          self.register_field(field['name'], field)
        end
      end

      def self.register_field(name, field)
      public 
        attr_accessor name.to_sym
      private
        self.field_types[name] = {
          :type => field['type'],
          :label => field['label'],
          :picklist_values => field['picklistValues'],
          :updateable? => field['updateable'],
          :createable? => field['createable']
        }
      end

    end
  end
end
