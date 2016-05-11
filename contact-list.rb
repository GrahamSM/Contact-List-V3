require_relative 'contact_connection'

puts "Here is a list of available commands: "
puts "\tnew\t- Create a new contact"
puts "\tlist\t- List all contacts"
puts "\tshow ID\t- Show a contact with particular ID"
puts "\tsearch\t- Search contacts"
puts "\tdestroy\t- Remove contact"

argv = ARGV
  case argv[0]
    #TODO: MULTIPLE PHONE NUMBERS
    when /list/
      Contact.all.each do |c|
        puts "ID: #{c.id} --- Name: #{c.name} --- email: #{c.email} --- Number: #{c.get_number if c.has_number?}"
      end
    when /number/
      puts "Please enter the contact ID"
      id = STDIN.gets.chomp
      puts "Please enter the phone number for the contact"
      number = STDIN.gets.chomp
      @temp_contact = Contact.find(id)
      @temp_contact.numbers.create(number: number.to_s)
    when /new/
      puts "Contact creator..."
      puts "Please enter a name"
      name = STDIN.gets.chomp
      puts "Please enter an email"
      email = STDIN.gets.chomp
      result = Contact.where(name: name) || Contact.where(email: email)
      if result.empty?
        contact = Contact.create(name: name, email: email)
      else
        puts "Contact already exists in the database"
      end
      #end
    when /show/
      @contact = Contact.find(argv[1].to_i)
      if @contact
        puts "Contact name: #{@contact.name}"
        puts "Contact e-mail: #{@contact.email}"
        puts "Contact ID: #{contact.id}"
        if Number.find(@contact.id)
          puts "Contact phone number: #{Number.find(@contact.id).number}"
        end
      else
        puts "Contact not found"
      end
      #:TODO SEARCH FUNCTIONALITY
    #when /search/
    #  contact = Contact.search(argv[1])
    when /update/
      @the_contact = Contact.find(argv[1])
      puts "Selected contact: #{@the_contact.name} ---- #{@the_contact.email}"
      puts "Please enter a new name for the contact: (or hit <enter> to skip)"
      new_name = STDIN.gets.chomp
      puts "Please enter a new email for the contact: (or hit <enter> to skip)"
      new_email = STDIN.gets.chomp
      if !(new_name.empty?)
        @the_contact.update_attributes(name: new_name)
        binding.pry
      end
      if !(new_email.empty?)
        @the_contact.update_attributes(email: new_email)
      end
    when /destroy/
      @the_contact = Contact.find(argv[1])
      @the_contact.destroy
    else
      puts "Command not recognized"
    end
