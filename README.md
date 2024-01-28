# IOS Social Media App

## A functional social media app for iOS devices, written in Swift and using Firebase for the database.

### This is a personal project that was created to help university students make new friends.

### Features:
* It is restricted to only university students, requiring a student email address.
* Three different types of connection requests: Friendship, Relationship and Hookup, removing any uncertainty about the connection.
* All three connection types are completely anonymous. The user will not be notified if they have received a connection until both users request the same type of connection.
* Users also have an option for a fourth connection, where they are paired with a random person for 24-48 hours. During this time they can only send texts to each other. After the allotted time has expired, they can then choose to connect with the person.
* Users can share photos, complete with descriptions and a liking system, as well as selecting who can see your post.
* The project offers real-time messaging, allowing users to instantly share texts and images.



### Technical Features:
* The project uses Model-View-Controller Architecure.
* All UI is written using SwiftUI.
* All backend code is written in Swift.
* Firebase Authentication is used for user authentication.
* Firebase Firestore is used for storing user information, such as username, liked posts, and messages.
* Firebase Storage is used for storing images uploaded by the users.
