# Mail and Calendar
After a very long search, I settled on Thunderbird Mail with the Lightning calendar plugin. The key to getting Lightning to sync to Google Calendar is to use CalDAV, one for each calendar.

For example, my main calendar is at address `https://apidata.googleusercontent.com/caldav/v2/<my-gmail-address>@gmail.com/events`. For other calendars (even ones I created myself and didn't share with others), I went into the Google Calendar web interface and found the ID there. For example, `https://apidata.googleusercontent.com/caldav/v2/<bunch-of-encoded-characters>@group.calendar.google.com/events`.

It was slightly more tedious than Evolution, since I had to add each of my 5 separate calendars manually and go through the OAuth process for each one, but the Lightning calendar is really good - much better for my use cases than any other standalone calendar app in the Ubuntu repositories. Evolution was good too, but I couldn't adjust to the way the email side worked and didn't want to use both Evolution and Thunderbird, one for calendar and the other for email.

## Line Breaks
"There be dragons" when it comes to line breaks in plain text email. Apparently there's a header field "format = flowed" and there's a requirement for lines in text email not to be longer than a certain amouont. Ideally, the receiving email client will reflow the text and soft-wrap it as expected, but for some reason emails sent from Thunderbird don't do this (on K-9 Mail at least). Mails sent from Apple Mail do.

For now I am using a Thunderbird extension called Outgoing Message Format to send emails in HTML. More testing is warranted.

**Update**: Plain text sent from TB:
- Does reflow correctly in TB
- Does reflow correctly in Apple Mail
- Does not reflow correctly in Android K-9 Mail
- Does reflow correctly in the GMail web interface

I think I will not worry about it and just let Firefox handle the format as Auto, since the majority of people will probably see the message reflowed.

It's still strange how when sending plain text from Apple Mail, K-9 reflows it correctly (this even happened when I forwarded a message originally sent from FF through AM). Maybe K-9 is looking at a different field in the header to see if a message is sent by Apple Mail? I can see the format=flowed in messages sent by either client.
