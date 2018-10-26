class ApplicationService
  def success(message: nil, data: nil)
    Result::Success.new(message: message, data: data)
  end

  def failure(message: nil, data: nil)
    Result::Failure.new(message: message, data: data)
  end
end
