require 'ragi/call_handler'
class CallerIdHandler < RAGI::CallHandler
  APP_NAME = 'simon'

  # when someone calls the number, 
  # the call routes to this "dialup" method
  def identify
    answer
    wait(1)  # give it 1 seconds to make sure the connection is established
  
    # Who is calling?  Read the caller id
    user_phone_number = @params[RAGI::CALLERID]
    
    
    # say the phone number
    say_digits(user_phone_number)
  
    hang_up
  end
end