module Conformist
  class Builder
    def self.call definition, enumerable
      columns = definition.columns
      columns.inject HashStruct.new do |hash, column|
        hash.merge column.name => column.values_in(enumerable)
      end
    end
  end
end
