# Mail and Calendar
After a very long search, I settled on Thunderbird Mail with the Lightning calendar plugin. The key to getting Lightning to sync to Google Calendar is to use CalDAV, one for each calendar.

For example, my main calendar is at address `https://apidata.googleusercontent.com/caldav/v2/<my-gmail-address>@gmail.com/events`. For other calendars (even ones I created myself and didn't share with others), I went into the Google Calendar web interface and found the ID there. For example, `https://apidata.googleusercontent.com/caldav/v2/<bunch-of-encoded-characters>@group.calendar.google.com/events`.

It was slightly more tedious than Evolution, since I had to add each of my 5 separate calendars manually and go through the OAuth process for each one, but the Lightning calendar is really good - much better for my use cases than any other standalone calendar app in the Ubuntu repositories. Evolution was good too, but I couldn't adjust to the way the email side worked and didn't want to use both Evolution and Thunderbird, one for calendar and the other for email.
