module ComputedCustomField
  module CustomFieldPatch
    extend ActiveSupport::Concern

    included do
      before_validation -> { self.formula ||= '' }, if: :is_computed?
      validates_with FormulaValidator, if: :is_computed?
    end

    def is_computed=(arg)
      # cannot change is_computed of a saved custom field
      super if new_record?
    end
  end
end

unless CustomField.included_modules
                  .include?(ComputedCustomField::CustomFieldPatch)
  CustomField.send :include, ComputedCustomField::CustomFieldPatch
end
