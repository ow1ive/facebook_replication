# Facebook Replication Mobile Application Long Exam 1 Part 2


## How Models, Services, and Screens Work Together

In this project, the models, services, and screens have different responsibilities, but they work together to make the application function properly.

### Models

The `models` folder is where I created the structure of the data that I receive from the API.

For example, `user.dart` contains the information of a user, while `post.dart` contains information about a post such as the post ID, user ID, body, likes, and dislikes. I also use `comment.dart` for the comments of each post.

The `fromJson()` method is important because the API returns data in JSON format. It converts that JSON data into objects that I can easily use inside Flutter.

### Services

The `services` folder is responsible for getting and handling the data.

For example, `user_service.dart` handles the login process. It sends the username and password to the DummyJSON API. Once the login is successful, the user data is saved using SharedPreferences.

`post_service.dart` is responsible for getting posts from DummyJSON. It can also get posts based on the user's ID, which is used in the Profile Screen.

`comment_service.dart` is used to get the comments related to a specific post.

I separated these API functions into services so that the screens do not have to directly handle the API requests. This also makes the code easier to understand and organize.

### Screens

The `screens` folder contains the actual pages that the user interacts with.

For the login process, the user enters their credentials in the Login Screen. The Login Screen calls `UserService`, which authenticates the user and saves the user data.

When the application starts, the Splash Screen checks if there is already a saved user. If there is, the application goes to the Home Screen. If there is no saved user, it goes back to the Login Screen.

On the Profile Screen, the saved user's ID is retrieved first. That ID is then passed to `PostService` to get only the posts belonging to that user. The posts are then displayed on the Profile Screen.

When a user opens a post, the Detail Screen uses the post ID to request the comments from `CommentService`. The comments are then displayed under the selected post.


### Enhancement 1 - Authentication and Splash Screen

I added user authentication using the DummyJSON API. After a successful login, the user's information is saved using SharedPreferences. I also used a Splash Screen to check if the user is already logged in when the application starts.

### Enhancement 2 - Profile and Settings

I added functionality to display the posts of the logged-in user on the Profile Screen using the user's ID. I also added a Settings Screen where the user can manage the sign out of the application.

### Enhancement 3 - Comments and Like

I added comments for each post by getting the comments based on the post ID. The Like button is also clickable so the user can interact with the post.

## Provider

I also used the Provider package in the project for managing application state and user preferences. This helps keep the code organized because the state can be shared between different parts of the application instead of handling everything inside one screen.

## What I Learned

Through this exam, I learned that separating the application into models, services, and screens makes the project easier to understand and maintain. I also learned how API data can be converted into models and then displayed in Flutter widgets.

