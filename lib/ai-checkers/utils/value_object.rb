class ValueObject < Module
  def initialize(*attributes)
    @module = Module.new do
      attr_reader *attributes
      protected *attributes

      define_method :initialize do |*args|
        raise ArgumentError, 'bad number of arguments' unless args.length == attributes.length
        attributes.zip(args).each do |name, val|
          instance_variable_set("@#{name}", val)
        end
      end
    end
  end

  def included(base)
    base.send(:include, @module)
  end
end
