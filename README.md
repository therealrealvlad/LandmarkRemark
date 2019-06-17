# LandmarkRemark
Coding challenge for Tigerspike

This file describes my work on the Landmark Remark coding challenge. Specifically, I've attempted to address the 5 user stories:

1. As a user (of the application) I can see my current location on a map;
2. As a user I can save a short note at my current location;
3. As a user I can see notes that I have saved at the location they were saved on the map;
4. As a user I can see the location, text, and user-name of notes other users have saved;
5. As a user I have the ability to search for a note based on contained text or user-name.

I managed to complete 1-4 to varying degree of success but have not completed 5, due to time limitations. However, I do think 5 would be fairly easy to implement given the framework that is now in place.

I chose to use the CLEAN swift design pattern because it makes one's job of implementing single responsibility, dependency injection, testability etc very easy. I've included an example unit test that checks that the interactor method for requesting location tracking permisssions is called when the map view controller view loads. Of course I would hope to acheive much greater test coverage in a real app.

I chose to use the RealmCloud/RealmSwift approach for storage and remote service because it offers an interesting cloud-based solution to the persistence problem. I also used SwiftFormat to format files prior to commiting them, and I used an xCode template file to create the initial MapScene. I used a GitFlow-type branching model, with a final merge to Master. Please run pod install from the root workspace directory prior to compiling the source to pull in the required RealmSwift pod.

The entire work took me about 16-20 hours, depending on whether one counts learning and exploration time, as some of the design elements were fairly new to me (e.g. I had not used RealmSwift before, and I had not implemented the CLEAN swift design pattern from scratch before).

Aside from the absence of wireframes (typical for a coding challenge, of course), from my experience in the industry I believe the 5 user stories did not meet standard definitions of "ready for development". For example, I considered the following assumptions when making my choices for the UI and core design:

1. A user will only be interested in seeing notes on the map that are in the near vicinity;
2. A user will post only a short note, not an essay, so that text can be shown directly in the annotation view/callout of pins on the map;
3. A user will enter their username when entering their note/message, so that no requirement for a logged in user is needed;

The work could be improved and extended in several ways. For example, I think one could store the user's username in NSDefaults after they've created their first note, then autofill the username text field using that data.

Overall, though, I'm quite happy with the way the challenge panned out.
