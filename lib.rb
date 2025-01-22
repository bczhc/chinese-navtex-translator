TELEGRAM_START = 'ZCZC '
TELEGRAM_END = 'NNNN'
TELEGRAM_HEADER_LINES = 2

class Telegram
  attr_accessor :header, :body

  def initialize(header, body)
    @header = header
    @body = body
  end

  # @param text [String]
  # @return [Array<Telegram>]
  def self.parse(text)
    body_start = false
    header_lines = []
    body_buf = []
    lines = text.lines(chomp: true)
    telegrams = []

    i = 0
    while i < lines.length
      this_line = lines[i]
      if not body_start and this_line.start_with?(TELEGRAM_START)
        body_start = true
        TELEGRAM_HEADER_LINES.times do |x|
          header_lines.push lines[i + x]
        end
        i += TELEGRAM_HEADER_LINES
        next
      end

      if body_start
        if this_line == TELEGRAM_END
          t = Telegram.new(header_lines.clone, body_buf.clone)
          header_lines.clear
          body_buf.clear
          telegrams.push t
          body_start = false
        else
          body_buf.push this_line
        end
      end
      i += 1
    end
    telegrams
  end
end