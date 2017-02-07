-- Main entry point of our kernel:
function _start()
   while true do
      coroutine.yield()
   end
end
