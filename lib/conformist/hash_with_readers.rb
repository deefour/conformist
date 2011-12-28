module Conformist
  class HashWithReaders
    extend Forwardable
    
    attr_accessor :store
    
    delegate [:[], :[]=] => :store
    
    def initialize
      self.store = {}
    end
    
    def merge other
      self.class.new.tap do |instance|
        instance.store = store.merge other
      end
    end
    
  protected
  
    def respond_to_missing? method, include_private
      store.has_key?(method) || super
    end
    
    def method_missing method, *args, &block
      if store.has_key? method
        store[method]
      else
        super
      end
    end
  end
end