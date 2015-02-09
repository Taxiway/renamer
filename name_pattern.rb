class NamePattern

  # patter: File$.ext, $ part will be replaced by indice
  # indice will be from @start to @total
  # padding equals to true then the indices will be padded by 0s
  #    f01.txt
  #    f02.txt
  #    ...            <----- the default one
  #    f09.txt
  #    f10.txt
  # otherwise, no 0s will be padded
  #    f1.txt
  #    f2.txt
  #    ...
  #    f9.txt
  #    f10.txt
  def initialize(pattern, start, total, padding)
    @start = start
    @total = total
    @padding = padding
    @len = total.to_s.length
    parse_pattern pattern
  end

  def parse_pattern pattern
    @prefix, @suffix = pattern.split "$"
  end

  def process_index(index)
    if @padding
      "0" * (@len - index.to_s.length) + index.to_s
    else
      index.to_s
    end
  end

  def each
    Enumerator.new do |yielder|
      @start.upto(@total) do |index|
        yielder.yield @prefix + process_index(index) + @suffix
      end
    end
  end

end
