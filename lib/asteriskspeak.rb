require 'ragi/call_handler'
require 'net/scp'
require 'applescript'

class Asteriskspeak

  def self.speak_text(text)
    # filename = Time.new.to_i.to_s+'--'+text[0..20].gsub(' ','-')+'.aiff'
    filename = text[0..20].gsub(' ','-')+'.aiff'
    path = RAILS_ROOT+'/public/recordings/'
    AppleScript.execute(%{say "#{text.gsub('"', '\"')}" saving to "#{path}#{filename}"})
    ulaw_filename = filename.gsub('.aiff','')
    # i store recordings in /etc/asterisk/recordings/ ... make your own directory!
ls
    remote_path = '/etc/asterisk/recordings/'+ulaw_filename
    system("sox "+path+filename+" -r 8000 -t ul "+path+ulaw_filename)
    # have to get it on the remote machine

    Net::SCP.start('my_host','my_username',:password => 'my_password') do |scp|
      scp.upload!(path+ulaw_filename,'/etc/asterisk/recordings/'+ulaw_filename+'.ulaw')
    end

    puts remote_path
    remote_path
  end
  
end