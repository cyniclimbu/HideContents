puts "Loading."
require 'colored'
system("cls") 
puts "Loading.".bold.green
require 'digest'
require 'highline'
require 'highline/import'
include HighLine::SystemExtensions

MAIN_DIR = Dir.pwd                # REPLACE THIS WITH THE DIRECTORY YOU WANT TO HIDE CONTENTS OF
SYS_DIR  = MAIN_DIR + '/login'    # UNFORTUNATELY YOU NEED A LOGIN DIRECTORY IN SYS_DIR, DIY THE WAY YOU WANT ;)
FILE     = "password"
# MASTER   = "71694c438ef89b5e15fa1fdb3b368439" # REMOVE #'s on line(s) 36-39/117/130 TO USE THIS FEATURE

system("cls")
print "SeeWhyAnEyeSee".bold.green; puts " console\n"

def check_files 
	if Dir.exists?(SYS_DIR)
	 Dir.chdir(SYS_DIR)
	  if File.exists?(FILE)
	   if not File.zero?(FILE)
	    login
	   else
	    signup
	   end
	  else
	   signup
	  end
	else
	 puts "ERROR".bold.cyan
	 puts SYS_DIR + " does not exist.".bold.red
	 puts "MORE TO IT.".bold.cyan
	 puts "I don't belong here...".bold.yellow
	 puts "Put me back to where I belong and restart me."
	  #x = ask("") {|choice| choice.echo = false }; x.downcase!; x = Digest::MD5.hexdigest(x)
	  #if x == MASTER
	  #Dir.mkdir(SYS_DIR)
	  #end
	  sleep 4; exit
	end 
end

def signup
puts "SIGN UP".bold.cyan
puts "Password input will be hidden.".bold.yellow
 newPassword  = ask("New password: ") { |newP| newP.echo = false }
puts "Do you want to see your password?(Y - Yes/A-Z - No)".bold.yellow
print "> "
yORn = get_character.chr
puts "#{yORn}"
if yORn =~ /y/i
 puts "password: ".bold.white + newPassword.bold.green
 system("pause"); system("cls"); print "SeeWhyAnEyeSee".bold.green; puts " console\n"
end
 newPassword  = Digest::MD5.hexdigest(newPassword)
 savePassword = File.new(FILE,"w")
 savePassword.puts(newPassword)
 savePassword.close
login
end

def shell
Dir.chdir MAIN_DIR
puts "Shell".bold.cyan
	unless $logged_in == true
	 puts "You're not supposed to be seeing this...".bold.yellow
	 puts "I'm sorry but I have to send kick you out.".bold.yellow
	 sleep 6; exit
	end
	print "H".bold.white; print " to hide and ".bold.green; print "S".bold.white; puts " to show".bold.green 	
	loop = 0; while loop < 20
	print "> "
	command = get_character.chr
	
	if command =~ /h/i
     puts "Hiding."
 	  all = Dir.glob'*'
	  all.each do |hide|
	  next if hide == "login.rb"
	  system("attrib +s +h \"#{hide}\"")
	  end 
	elsif command =~ /s/i
	 puts "Showing."
	  all = Dir.glob'*'
 	  all.each do |show|
	  next if show == "login.rb"
	  system("attrib -s -h \"#{show}\"")
	  end
	  
	else
	print "#{command}".bold.cyan; puts " is not a valid character.".bold.red
	end
		
	loop += 1
	end
	puts "You've reached the limit as you're not a member to use this \"premium feature\"."
	print "Please buy the full version at the low price of"; print " $9000 ".bold.red; puts "only."
end

def login
	if not Dir.exists?(SYS_DIR) or not File.exists?(SYS_DIR + '/' + FILE)
 	 puts "ERROR".bold.cyan
	 puts "The shell cannot function because of one or two missing files.".bold.yellow
 	 print "Missing content".bold.white; print "(".bold.yellow; print "s"; print ").".bold.yellow
	 puts SYS_DIR; puts SYS_DIR + '/' + FILE; sleep 4; exit
	end
  if $logged_in == true
   shell
  end  
  actualPassword = File.read(FILE).delete("\n")
 puts "LOG IN".bold.cyan

  loop = 0; while loop < 5
    givenPassword = ask("login: ") { |input| input.echo = false }
	givenPassword = Digest::MD5.hexdigest(givenPassword)
		if givenPassword == actualPassword #or givenPassword == MASTER
		 $logged_in = true
		 shell
		else
		 $logged_in = false
		 puts "Incorrect password.".bold.red
		end
  loop += 1		
  end
  puts "This is the last attempt you have. You can see your password this time."
  print "login: "
   givenPassword = gets.chomp
   givenPassword = Digest::MD5.hexdigest(givenPassword)
		if givenPassword == actualPassword #or givenPassword == MASTER
		 $logged_in = true
		 shell
		else
		 $logged_in = false
		 print "Incorrect password.".bold.red; puts " Restart the shell to try again.".bold.green
		end
end

check_files
sleep