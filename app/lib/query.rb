class Query
  attr_reader :count, :limit, :offset, :result

  def initialize scope, params, options={}
    @count = scope.count
    @limit = params[:limit].try(:to_i) || options[:limit] || 25
    @offset = params[:offset].to_i
    @limit = nil if @limit == -1
    @result = scope.limit(@limit).offset(@offset)
  end
end
