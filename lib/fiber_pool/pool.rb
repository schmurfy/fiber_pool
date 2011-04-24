begin
  require 'fiber'
  if defined?(Rubinius::Fiber)
    Fiber = Rubinius::Fiber
  end
  
rescue LoadError
  require File.expand_path('../fiber18', __FILE__)
end

class FiberPool
  # Prepare a list of fibers that are able to run different blocks of code
  # every time. Once a fiber is done with its block, it attempts to fetch
  # another one from the queue
  def initialize(count = 100)
    @fibers,@busy_fibers,@queue = [],{},[]
    
    count.times do |i|
      add_fiber()
    end
  end
  
  def add_fiber
    fiber = Fiber.new do |block|
      loop do
        block.call
        unless @queue.empty?
          block = @queue.shift
        else
          @busy_fibers.delete(Fiber.current.object_id)
          @fibers.unshift Fiber.current
          block = Fiber.yield
        end
      end
    end
    
    @fibers << fiber
    fiber
  end

  # If there is an available fiber use it, otherwise, leave it to linger
  # in a queue
  def spawn(&block)
    # resurrect dead fibers
    @busy_fibers.values.reject(&:alive?).each do |f|
      @busy_fibers.delete(f.object_id)
      add_fiber()
    end
    
    if fiber = @fibers.shift
      @busy_fibers[fiber.object_id] = fiber
      fiber.resume(block)
    else
      @queue << block
    end
    
    fiber
  end
  
end


if $0 == __FILE__
  pool = FiberPool.new(2)
  f1 = pool.spawn do
    puts "1"
    puts Fiber.yield
  end
  
  begin
    pool.spawn do
      puts "2"
      f1.resume(42)
      raise 'arggggg'
    end
  rescue => err
    p err.inspect
  end
  
  begin
    pool.spawn do
      raise 'arggggg 222'
    end
    
  rescue => err
    p err.inspect
  end
  
  
  pool.spawn do
    puts "I am alive !!!"
  end
  
end

