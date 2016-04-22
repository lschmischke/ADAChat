with Protocol; use Protocol;


package ServerToGUICommunication is
   type GUI is interface;



   procedure printErrorMessage(errorMessage : MessageObject);
   procedure printInfoMessage(infoMessage : MessageObject);
   procedure printChatMessage(chatMessage : MessageObject);
   procedure updateNumberOfContacts(numberOfContact : Natural);


end ServerToGUICommunication;
