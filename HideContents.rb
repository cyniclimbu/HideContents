require 'colored' # Just for fancy .bold.green/.bold.blue colors

print "FileHider, part of".bold.cyan; puts " rootShell.\n".bold.green

loop do

print "Command: "; command = gets.chomp

	if command =~ /help/
	 puts "Commands           It's USE.".bold.green
	 puts "help               Show this help.".bold.yellow
	 puts "cd                Change directory.".bold.yellow
	 puts "e.g cd c:\\users\\example".bold.blue
	 puts "hide               Hide specified content or all content of current directory.".bold.yellow
	 puts "e.g hide all - to hide all stuff of a directory".bold.blue
	 puts "e.g hide example - to hide example (File/Folder)".bold.blue
	 puts "show               Show specified content or all content of current directory.".bold.yellow
	 puts "e.g show all - to show all stuff of a directory".bold.blue
	 puts "e.g show example - to show example (File/Folder)".bold.blue
	 puts "cls 				  Clears the screen.".bold.yellow
	
	elsif command =~ /cls/i
	system('cls')
	
	elsif command =~ /cd/i
	 command.sub!("cd ","") # IF ANYONE HAS BETTER WAYS OF GETTING DIRECTORIES FROM INPUT...HELP ME OUT
	 
		if Dir.exists?(command)
			Dir.chdir(command)
			print "You are now on".bold.cyan; puts " #{command}".bold.magenta
		else
			puts "#{command} does not exist.".bold.red
		end
		
	elsif command =~ /hide all/i
	  puts "Hiding."
 	  all = Dir.glob'*'
	  all.each do |hide|
	  system("attrib +s +h \"#{hide}\"")
	  end 
	  
	elsif command =~ /show all/i 
	  puts "Showing."
	  all = Dir.glob'*'
 	  all.each do |show|
	  system("attrib -s -h \"#{show}\"")
	  end
	
	elsif command =~ /hide/i
	  command.sub!("hide ","")
	  system("attrib +s +h \"#{command}\"")
	  
	elsif command =~ /show/i
	  command.sub!("show ","")
	  system("attrib -s -h \"#{command}\"")
	end

end
