/// Sample projects for "Try the demo" sandbox events.
///
/// `quality` is the hidden ground truth that simulated judges use; it is never
/// sent to clients.
const demoProjects =
    <
      ({
        String name,
        String team,
        String description,
        double quality,
      })
    >[
      (
        name: 'Ripple',
        team: 'Team Tidewater',
        description:
            'Flood early-warning mesh: \$4 sensors on storm drains gossip water '
            'levels over LoRa and text neighbours before the street floods.',
        quality: 2.1,
      ),
      (
        name: 'MedMinder',
        team: 'Pill Pushers',
        description:
            'A pill bottle cap that knows if you took your meds and nudges your '
            'family on Signal when you did not.',
        quality: 1.3,
      ),
      (
        name: 'Sous',
        team: 'Mise en Place',
        description:
            'Point your phone at your fridge; get three recipes that use what is '
            'about to expire, with a timer-driven cooking mode.',
        quality: 0.9,
      ),
      (
        name: 'Braille Buddy',
        team: 'Six Dots',
        description:
            'A 3D-printed refreshable braille cell plus a Flutter tutor app that '
            'teaches braille in ten minutes a day.',
        quality: 1.9,
      ),
      (
        name: 'GreenLight',
        team: 'Signal Boost',
        description:
            'Reinforcement learning for traffic lights, trained on a SUMO model '
            'of our campus. 18% shorter waits in simulation.',
        quality: 1.1,
      ),
      (
        name: 'Lingo Loop',
        team: 'Polyglots',
        description:
            'Language exchange that pairs you with a nearby native speaker for '
            'a 15 minute coffee walk.',
        quality: -0.2,
      ),
      (
        name: 'StudySync',
        team: 'Night Owls',
        description:
            'Shared Pomodoro rooms with ambient lo-fi and a leaderboard for '
            'focused minutes.',
        quality: -0.6,
      ),
      (
        name: 'Canopy',
        team: 'Arborists',
        description:
            'Satellite imagery + crowdsourced photos to map urban tree cover and '
            'suggest where the city should plant next.',
        quality: 1.5,
      ),
      (
        name: 'Rover Rescue',
        team: 'Mars Bars',
        description:
            'A cardboard search-and-rescue rover with thermal camera and a '
            'web dashboard that streams its map in real time.',
        quality: 1.0,
      ),
      (
        name: 'Budgie',
        team: 'Penny Wise',
        description:
            'Budgeting for students that splits rent and groceries automatically '
            'from your bank feed.',
        quality: -0.4,
      ),
      (
        name: 'EchoNotes',
        team: 'Scribes',
        description:
            'Records lectures, transcribes them and turns them into spaced '
            'repetition flashcards.',
        quality: 0.4,
      ),
      (
        name: 'Plant Pal',
        team: 'Green Thumbs',
        description:
            'Soil moisture sensor that talks back: your fern texts you when it '
            'is thirsty, with personality.',
        quality: 0.1,
      ),
      (
        name: 'Transit Tetris',
        team: 'Bus Bunch',
        description:
            'Predicts how crowded the next bus is from historical tap data and '
            'suggests a less crowded departure.',
        quality: 0.6,
      ),
      (
        name: 'SafeWalk',
        team: 'Night Shift',
        description:
            'Walk-me-home app: friends watch your live route and get pinged if '
            'you stop moving unexpectedly.',
        quality: 0.3,
      ),
      (
        name: 'Pixel Pets',
        team: 'Tamagotchi Gang',
        description:
            'A multiplayer virtual pet that only grows when your friends go '
            'outside and walk.',
        quality: -1.1,
      ),
      (
        name: 'CodeBuddy',
        team: 'Rubber Ducks',
        description:
            'A rubber duck with a microphone that asks you Socratic questions '
            'about your bug.',
        quality: -0.1,
      ),
      (
        name: 'Dorm Dash',
        team: 'Hungry Hippos',
        description:
            'Peer-to-peer snack delivery between dorm floors, paid in cookies.',
        quality: -1.4,
      ),
      (
        name: 'AirAware',
        team: 'Breathe Easy',
        description:
            'Cheap PM2.5 sensors on bike couriers produce a street-level air '
            'quality map updated every five minutes.',
        quality: 1.2,
      ),
      (
        name: 'Mood Meter',
        team: 'Feelings Inc',
        description:
            'Daily one-tap mood check-ins that surface patterns in your sleep and '
            'screen time.',
        quality: -0.8,
      ),
      (
        name: 'QuizQuest',
        team: 'Trivia Titans',
        description:
            'Turns any PDF into a multiplayer quiz game you can play in class.',
        quality: 0.0,
      ),
      (
        name: 'Fridge Swap',
        team: 'Leftover Legends',
        description:
            'Neighbourhood map of community fridges with live stock levels '
            'reported by a camera on the door.',
        quality: 0.7,
      ),
      (
        name: 'Gesture Jam',
        team: 'Air Guitarists',
        description:
            'Play music with hand gestures in front of your webcam. Comes with a '
            'very convincing air drum kit.',
        quality: -0.3,
      ),
      (
        name: 'Parking Pal',
        team: 'Lot Lizards',
        description: 'Tells you which campus lot has free spaces right now.',
        quality: -1.0,
      ),
      (
        name: 'Sign Speak',
        team: 'Hands Up',
        description:
            'On-device sign language recognition that captions ASL fingerspelling '
            'in video calls.',
        quality: 1.7,
      ),
    ];
