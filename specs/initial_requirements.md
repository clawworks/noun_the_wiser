
## Noun The Wiser

I want to build a real time multiplayer app/game called Noun The Wiser, which is a team, turn based game where teams compete to guess three nouns, one in each category of Person, Place, or Thing. Once a team has correctly guessed a noun in each of the categories they win.

Players may join the game with a join code, link or QR code.

The gameplay is as follows: 

All players are divided into two teams, each team has one cluegiver assigned. The remainder of the team members are presented with 3 questions, from a question bank in the app. Once the team decides which question to ask, they present it to the clue giver who then answers the question as their clue. Once the clue giver has answered the question, the team can then make a guess to what they think the noun is. If they are correct the team gets the badge for that noun category. If they are incorrect the other team then gets a chance to ask their cluegiver a question and make a guess for the same noun. Once a team has correctly guessed the noun, that round is over, a new cluegiver is assigned on each team and the winning team gets to pick the noun category for the next round. 


## Requirements
The app should be built with Flutter to be used on iOS, Android and Web, and have the following features:

## Authentication

- Authentication may be anonymous to start, but eventually player should be able to create an account to see game history and save preferences.

## Real Time updates

Each team and player should see real time updates as the game progresses. Additionally, It would be nice to see when players are online or not too.


## Theming

- The app should use light and dark mode, and default to the users device preference. 
- Theming should be done by setting the `theme` in the `MaterialApp`, rather than using hardcoded colors and sizes in the widgets.
- Style should be very clean, open feel. Not very boxy. In general I don't see the need for a typical app bar, just action buttons if needed.
- Some of the color scheme should include the following colors, you decide where they fit in the color scheme best:
    - #57CC02
    - #1CB0F6
    - #6A5FE8
    - #FFC702


## Code Style

- The app should use Riverpod as the state management package. 
- The app should follow immutability standards, so objects are not mutable. You can used the `freezed` package for this if you'd like, or just mark objects as `immutable`.
- I have knowledge of Firebase cloud firestore, which could work for real time updates, but this is not a requirement, I am open for suggestions. 
- There should be a clear and proper separation of concerns by creating a suitable folder structure.
- Prefer smaller, readable widgets that can be composed rather than large ones
- Prefer using flexible values and padding over hardcoded sizes when creating widgets inside rows/columns, ensuring UI adapts to various screen sizes properly
- Use `log` from `dart:developer` rather than `print` or `debugPrint` for logging