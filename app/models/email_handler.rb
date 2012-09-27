
class EmailHandler < ActionMailer::Base
  
  
  def receive(mail)
    message_id = get_message_id(mail)
    
    # only process if it hasnt' already been received
    if(new_email?(message_id))
      to_all = mail.to.join(",")
      if(mail.cc)
        cc_email = mail.cc.join(",")
      end  
      
      @mail_list = get_to(mail).split(",")
      #@mail_list = get_recipient_list(to_all, cc_email)
      
      from_email = mail.from.first
      subject = mail.subject
      body = mail.body
      header = build_header(mail)    
      date = mail.date
      
      for recipient in @mail_list
        if(is_rejectmail?(recipient))
          email = Email.new
          email.name = get_account(recipient).downcase
          email.domain = get_domain(recipient)
          email.to_all = to_all
          email.cc_email = cc_email
          email.from_email = from_email
          email.subject = subject
          email.body = body
          email.header = header
          email.message_id = message_id
          email.date = date        
          email.save          
        end
      end   
    end 
  end
  
  private
  
  def get_recipient_list(to_all, cc_email)
    @mail_list = Array.new        
    @mail_list = to_all.split(",")
    if(cc_email)
      @mail_list.concat(cc_email.split(","))
    end
    @mail_list
  end
  
  def is_rejectmail?(address)
    if(get_domain(address) == "rejectmail.com")
      true
    else
      false
    end
  rescue 
    false
  end
  
  def get_domain(address)
    address.strip.slice(/@.*?$/)[1..-1]    
  end
  
  def get_account(address)
    address.strip.slice(/^.*?@/)[0..-2]
  end
  
  def build_header(email)
    header_string = ""
    @header = email.header
    for element in @header
      header_string += element.to_s
      header_string += "<br>"
    end
    header_string
  end
  
  def get_message_id(email)
    email.header['message-id'].to_s
  end  
  
  def get_to(email) 
    email.header['to'].to_s
  end
  
  def new_email?(message_id)
    found = Email.find_by_message_id(message_id)
    if(found)
      false
    else
      true
    end
  rescue
    true
  end
  
end
