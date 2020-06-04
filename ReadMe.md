
# Starwars App

## How to use
- Best on iPad in landscape but works on other devices
- Click on categories on search field
- Click on item of interest
- Type in search field to filter

## Design
- Decided to go with master detail layout.
- I tried to be careful about separating model, view and controller layers
- was careful about dependencies so the imports reflect what is actually needed. 
- Followed Single Responsiblity principle, this can be seen in Presenter objects separation from model objects.
- I did not try to handle links to other types although it would be pretty easy to add links on the attributed text. I added link in one place but it does not go anywhere.

## Testing
- Command-U should run the tests I created. 
- My testing for this project mainly focused on the backend requests, there is a lot more testing that could be done
- In my networking layer I have mock server which allows the tests to complete quickly and reliably because there is no network overhead.
- The tests are validated using json files that act like a real server, it supports different methods like GET, PUT, POST, and parameter checks. 

## Libraries used
### SwiftyBeaver 
- for logging, logging can be disabled in AppDelegate. It will improve load peformance, if disabled. 

### ResonanceKit
- A Package that I built to do networking. 
- Utilizes that Decodable and URLSession, UnitTesting is easy with a virtual mock server.

### Swift Coroutines
- Lets you write await style code and is part of ResonanceKit
- Can have code on main thread because it uses CoRoutines. 
