# Displays the information of the current window
winTitle = window.get_active_title()
winClass = window.get_active_class()
dialog.info_dialog("Window information", 
          "Active window information:\nTitle: '%s'\nClass: '%s'" % (winTitle, winClass))