class TimeParser
  FORMAT_DIRECTIVES = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(time_params_string)
    @time_params = time_params_string&.split(',')
  end

  def call
    @valid_format_values = get_valid_format_values
    @invalid_format_msg = get_invalid_format_msg
  end

  def success?
    !@invalid_format_msg
  end

  def time_result
    Time.now.strftime(@valid_format_values.join('-'))
  end

  def error_msg
    @invalid_format_msg
  end

  private

  def get_valid_format_values
    FORMAT_DIRECTIVES.values_at(*@time_params)
  end

  def get_invalid_format_msg
    return "No time format provided" if !@time_params

    unknown_format_values = @time_params - FORMAT_DIRECTIVES.keys

    "Unknown time format #{unknown_format_values}" if unknown_format_values.any?
  end
end
