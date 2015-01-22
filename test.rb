trace_var :i, proc { puts "$x is now #{$x}" }
i = 4
@i = 1

module X
  puts @i

  @i = 1
  puts @i
end

puts @i

trace_var :$x, proc { puts "$x is now #{$x}" }
$x = 1
$x = 2
