require 'ragi/call_handler'
require 'net/scp'
require 'applescript'
class RagiHandler < RAGI::CallHandler
  APP_NAME = 'ragi'

  # when someone calls the number, 
  # the call routes to this "dialup" method
  def index
    answer
    wait(1)  # give it 1 seconds to make sure the connection is established
  
    # Who is calling?  Read the caller id
    user_phone_number = @params[RAGI::CALLERID]
    
    
    # say the phone number
    # say_digits(user_phone_number)
    text
  
    hang_up
  end
  
  def text
    play_sound(Asteriskspeak.speak_text('Welcome to News Speak. You will now hear 5 articles from Google News.'))

    wait(1)

    index = 1
    Googlenews.short(5).each do |article|
    
      play_sound(Asteriskspeak.speak_text('Article '+index.to_s))
      wait(1)
      play_sound(Asteriskspeak.speak_text(article['title']))
      wait(1)
      index += 1
    
    end

    play_sound(Asteriskspeak.speak_text('Thank you. That is all.'))
    
  end
  
end