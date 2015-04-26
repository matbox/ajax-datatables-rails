module AjaxDatatablesRails
  module Extensions
    module Mongoid

      private

      def build_conditions_for(query)
        search_for = query.split(' ')
        criteria = search_for.inject([]) do |criteria, atom|
          criteria << searchable_columns.map { |col| search_condition(col, atom) }
        end
        criteria
      end

      def simple_search(records)
        return records unless (params[:search].present? && params[:search][:value].present?)
        conditions = build_conditions_for(params[:search][:value])
        records = records.or(conditions) if conditions
        records
      end

      def new_search_condition(column, value)
        model, column = column.split('.')
        {column.to_sym => /.*#{value}.*/}
      end

    end
  end
end