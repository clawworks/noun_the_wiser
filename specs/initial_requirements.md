
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

- Each team and player should see real time updates as the game progresses. 

## Teams
- Start with two teams, eventually we could potentially add more, but let's keep it to two for now. 
- Allow teams to pick their color, start with Green (#57CC02) and Blue (#1CB0F6) initially though. Then add more options to choose from later.
- Additionally, It would be nice to see when players are online or not too, like if their phone went to sleep.
    - Teams should be able to skip cluegivers if they are offline. This could be done by allowing any team member to manually choose to become the clue giver for their team if the assigned person could not do it. 
    - Players should also be able to switch teams at any point if they desire. 


## Provided Nouns for each category (Person, Place, Thing), and questions

- The nouns should come from a large noun bank in the app and should be grouped as packs which could be themed.
    - For now, just a general theme which will always be free, but eventually add paid upgrades for custom theme packs of more nouns related to the themes
- Questions should be in the form of "If you were a [BLANK], what would you be?" or similar. 
- These ideas come from an old game called Abstracts, which had very specific question styles and rules for nouns that are proper nouns. 

## Game Log

- I'd like to have a simple game log that keeps track of what has happened, it will show what questions were asked, and what clues were given in response to the questions, and what guesses have been made after the clues. Everyone should be able to see this game log as the game progresses.

## Team Chat

- There should be a simple team chat functionality so that team members could chat about possible guesses for nouns without the other team seeing or hearing their ideas. 

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
- Prefer smaller, readable widgets that can be composed rather than large ones.
- Prefer using flexible values and padding over hardcoded sizes when creating widgets inside rows/columns, ensuring UI adapts to various screen sizes properly.
- Use `log` from `dart:developer` rather than `print` or `debugPrint` for logging.
- Address all linter errors/warnings/hints, keep up with the latest recommendations.
- Keep up to date on packages.


## FlowChart

flowchart TD
    A["Lobby / Join Game"]
    B["Team Assignment"]
    C["Noun Selection (Clue Giver)"]
    D["Question Selection (Team)"]
    E["Clue Giver Answers"]
    F["Team Guesses"]
    G["Badges / Progress"]
    H["Game End / Winner"]

    A --> B
    B --> C
    C --> D
    D --> E
    E --> F
    F --> G
    G -- "All badges?" --> H
    G -- "Not yet" --> C
    H --> A

    %% Notes for parallel turns
    D -.-> D2["Other Team: Question Selection"]
    D2 -.-> E2["Other Clue Giver Answers"]
    E2 -.-> F2["Other Team Guesses"]
    F2 -.-> G

    %% Optionally, add a loop for next round
    G -- "Next Round" --> C


Based on these rules from the old game Abstracts, just for reference, but we'd like to change a few things to make it unique and not just copy it.

### RULES
THE OBJECT OF THE GAME: Is to win, of course. You do this by being the first team to collect all three category tokens. 

BEGINNING THE GAME: Choose one team to go first. Deal out three ABSTRACT cards to each team. (Each time an ABSTRACT card is played another one is drawn, so that each team always has three ABSTRACT cards.)

Each team selects a 'Clue-giver' from their team who will respond to the ABSTRACT cards for that round. The 'Clue-giver' from the team that goes first draws a PERSON, PLACE OR THING card and chooses the category (person, place or thing) that will be played by all of the teams for that round. He or she announces the category to the rest of the players and passes the PERSON, PLACE OR THING card to the 'Clue-givers' on the other teams. 

PLAYING THE GAME: The team that goes first gives their 'Clue-giver' an ABSTRACT card. The timer is immediately turned over and play begins.
The 'Clue-giver' responds with a clue and the team guesses an answer. (Both must be accomplished before time runs out.) Play then passes to the next team, assuming the person, place or thing was guessed incorrectly. All teams are trying to guess the same person, place or thing. Once the famous person, place or thing is correctly guessed for that round, the team receives the corresponding token. New 'Clue- givers' are chosen for each team. The new 'Clue-giver' from the team that won the previous round draws a new PERSON, PLACE, OR THING card and chooses a new category. Play resumes with the team that won the previous round going first. 

There are only three rules to keep in mind when playing ABSTRACTS.

### 1: 'Clue-givers' may not use any part of the actual name of the famous person, place or thing in their clues.
### 2: Teams only guess when it is their turn and only one guess is allowed each turn. 
### 3: Only one 'real' clue can be given by the 'Clue-giver' per turn. This one's going to take a little explaining so be patient for a minute. 'Clue-givers' must answer only the questions asked on the cards with 'real', logical responses. They may use voice inflections, adjectives, etc., but they may not expand their answers to include clues other than the one they have been given, or answers to questions not asked. 
For example: If you were giving a clue for the person, Abraham Lincoln, proper responses to the question, "If you were a HOUSEHOLD ITEM," might be, "An oil burning reading lamp," or "An old wood burning stove with a tall black stovepipe." Improper responses would be “An oil burning reading lamp like a President of the United States might use when he was a boy," or "A stovepipe hat." (The latter is improper because it is an illogical response to the question, as stovepipe hats are 'articles of clothing' and not considered to be 'household items.') 

Another example, again using Abraham Lincoln. Proper responses to, "If you were a GAME," might be, “The Presidents' Game," because such a game does exist, or "That game about the Presidents" because you are referring to a real game that exists. Improper responses would be "A game about the sixteenth President of the U.S." or "A game about people born in log cabins," because no such games exist.

The violation of any of these rules results in the rest of the players calling the guilty player a 'Weenie' and the loss of the turn by the team in question. That's basically it. Once a team gets a token from each category, they win. You could start playing now or you could read the "Other Stuff" section. 

OTHER STUFF: Here's some other stuff you may consider when playing ABSTRACTS. 
Keep in mind that the PEOPLE, PLACES AND THINGS used in this game are always proper names. 

*PEOPLE can be real or fictional, single or small groups. 
PLACES are physical, tangible places you can go to (i.e., cities, countries, buildings, monuments and landmarks). Therefore, the Eiffel Tower would actually be a PLACE and not a THING. 
THINGS are intangibles, like books, movies or song titles, brand names, franchises, T.V. shows, etc.*

There is no penalty for incorrect guesses. After ten incorrect guesses a new PERSON, PLACE OR THING card is drawn.