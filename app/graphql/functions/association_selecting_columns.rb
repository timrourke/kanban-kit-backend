class Functions::AssociationSelectingColumns < GraphQL::Function
  attr_reader :type

  def initialize(association:, type:)
    @association = association
    @type = type
  end

  # Resolve function:
  def call(obj, args, ctx)
    if !ctx
      return obj.send(@association)
    end

    obj.send(@association).respond_to?(:selecting_columns) ?
      obj.send(@association).selecting_columns(columns_from_query_context(obj, ctx)) :
      obj.send(@association)
  end

  private

  def columns_from_query_context(obj, ctx)
    association = obj.send(@association).is_a?(ActiveRecord::Associations::CollectionProxy) ?
      obj.send(@association).model :
      obj.send(@association).class

    foreign_keys = association.reflections.values
      .map{|assoc| assoc.foreign_key}

    selected_fields = ctx.irep_node
      .scoped_children.values.map{|v| v.keys}

    selected_fields_underscored = selected_fields[0]
      .map{|key| key.underscore}

    columns = selected_fields_underscored
      .select{|key| association.has_attribute?(key)}

    columns_with_fkeys = columns + foreign_keys

    columns_with_fkeys.uniq
  end
end
