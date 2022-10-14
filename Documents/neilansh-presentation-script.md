# Script for Requirements Presentation
## Level-1 DFD
_Have image of the DFD on the slide_
- Here is the Level-1 DFD, showing the processes that run after an action is executed while using the app. 
- As you can see, there are 3 types of users: **Individual, Food Provider** and **Admin**.
- Registering as a **Food Provider/Restaurant** would require further approval from the **Admin**.
- After logging in different options are provided depending on the type of user.
- The database will be storing information such as user details, donation details and history to name a few. 
- We have defined our milestones based on the features here. So each milestone will cover one or more of the processes listed here.
- Moving on to the next slide, we’ll look at the Tech Stack. 

## Tech Stack
_Have image of the comparison table on the slide_
- Three options: **React Native (framework), Flutter (SDK) and Ionic (framework)**.
- All 3 tools are cross platform and therefore support **iOS** and **Android**.
- As the table suggests, some important considerations taken into account were: performance, how developer-friendly it is, reliance on 3rd party APIs and memory usage.
- **React Native** and **Ionic** are built on JS and can also be used with HTML/CSS. **Flutter** is built on Dart, which is another programming language.
- **React Native** and **Flutter** support hot reloading which will help us in testing features. Ionic supports live loading so it executes the whole app every time to test small changes, so development could slow down.
- After weighing the pros and cons, we decided to proceed with **Flutter** as the tool to be used for developing the app.
- Here are some Flutter features that appealed to us:
  - Easier to learn.
  - Developer-friendly, and is thoroughly documented.
  - Slightly better performance-wise.
  - Has several built-in plugins and UI Components from Google, thereby reducing dependence on 3rd party APIs and making app memory efficient. 
  - Provides testing options which we’ll look at in the next slide.
- The team agreed upon using **Firebase** as the database. We will also be making use of the **Google Maps API**.
