//THIS FUNCTION IS RESPONSIBLE FOR LOADING PRIVATE CHATS//
function LoadPrivateChat() {
  // this code scrolls the chatbox to the bottom
  var messages, messages_to_bottom;
  messages = $('#messages');
  if ($('#messages').length > 0) {
    messages_to_bottom = function() {
      return messages.scrollTop(messages.prop("scrollHeight"));
    };
    messages_to_bottom();

//This code creates an AC subscription to the specific group channel, and establishes base functions
    App.private_chat = App.cable.subscriptions.create({
      channel: "ConvoChannel",
      conversation_id: messages.data('conversation-id')
    }, {
      connected: function() {
        console.log('PCHAT: connected to ' +  messages.data('conversation-id'))
      },
      disconnected: function() {
        console.log('PCHAT: disconnected from ' +  messages.data('conversation-id'))
      },
      received: function(data) {
        messages.append(data['chat']);
        return messages_to_bottom();
      },
      send_chat: function(textdata, convo_id) {
        return this.perform('send_chat', {
          body: textdata,
          conversation_id: convo_id
        });
      }
    });

    // this is responsible for actually sending a message
    return $('#new_personal_message').submit(function(e) {
      var $this, textarea;
      $this = $(this);
      textarea = $this.find('#personal_message_body');
      messages = $('#messages');
      if ($.trim(textarea.val()).length > 1) {
        App.private_chat.send_chat(textarea.val(), messages.data('conversation-id'));
        textarea.val('');
      }
      e.preventDefault();
      return false;
    });
  }
};
