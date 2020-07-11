
# Starwars App

## How to use
- Best on iPad in landscape but works on other devices
- Works well on Mac Catalyst. 
- Click on categories on search field
- Click on item of interest
- Type in search field to filter

## How to Build
- Should just work, after a delay getting the SPM packages. 
- Please let me know if you have any difficulty building, it is working for me,
- I am building with Xcode 12

## Design
- Decided to go with master detail layout.
- Using DiffableDataSources. 
- Pulls all requests at once so filtering can happen locally and to save quota limits on server.
- Careful about separating model, view and controller layers
- Dependencies so the imports reflect what is actually needed. 
- Major changes to use DiffableDataSources providing nice animations when querying and switching tabs.
- Can navigate into film links, not working

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
