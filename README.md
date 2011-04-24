# What is this ?

It is a basic implementation of a fiber pool extracted for my projects,
I need a pool in many project and I am tired of having to reimplement it
in every project so here goes my gem !

My implementation is based on the neverblock one but I added some changes of
my own over time.

# Features

- Constant count of fibers with a queue (I am sure you would have never guessed ;) )
- should any uncaught error occur in one fiber of the poll then another one
  will be spawned to keep the pool state (you should not let errors uncaught but
  my experience clearly shows me that it can happen and it can trigger really weird bug
  if your poll runs out of fibers)

# Usage

I use it mainly with EventMachine but it is in no way required, that said it may not be
of much use without, I did not gave it much thoughts :)

    # create a pool contained 10 fibers
    pool = FiberPool.new(10)
    
    # and spawn a job
    # if a fiber is free it will be executed immediatly
    # otherwise the block is queued
    pool.spawn{ do_something() }


# Warning

If you use this You should already be aware of how fibers work, If not go read about them
and keep in mind that when a Fiber is running nothing else will, they are like threads but
you are responsible for the scheduling.


# Supported Runtimes

- MRI 1.8.6+  (in ruby 1.8 the thread based fiber implementation will be used)
- Rubinius 1.2.2+ (fiber support is still experimental so be careful what you do this it here)



