TELEGRAM_START = 'ZCZC '
TELEGRAM_END = 'NNNN'
TELEGRAM_HEADER_LINES = 2

class Params
  attr_accessor :start, :end, :header_lines

  def self.default
    p = Params.new
    p.start = TELEGRAM_START
    p.end = TELEGRAM_END
    p.header_lines = TELEGRAM_HEADER_LINES
    p
  end
end

class Telegram
  attr_accessor :header, :body

  def initialize(header, body)
    @header = header
    @body = body
  end

  # @param text [String]
  # @return [Array<Telegram>]
  def self.parse(text, params = Params.default)
    body_start = false
    header_lines = []
    body_buf = []
    lines = text.lines(chomp: true)
    telegrams = []

    i = 0
    while i < lines.length
      this_line = lines[i]
      if not body_start and this_line.start_with?(params.start)
        body_start = true
        params.header_lines.times do |x|
          header_lines.push lines[i + x]
        end
        i += params.header_lines
        next
      end

      if body_start
        if this_line == params.end
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

def parse_dict(path)
  map = {}
  File.readlines(path, chomp: true).each do |line|
    split = line.split("\t")
    map[split[0]] = split[1]
  end
  map
end
