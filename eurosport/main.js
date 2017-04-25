
// JavaScript resource loader

// We create a handler function and attach it to the onLaunch property. This function will execute the TVML app is launching.

App.onLaunch = function(options) {
    console.log("Hello Columbia iOS Development Meetup");
    
    //MARK: - Properties
    var resourceLoader = new LoaderJS(NativeResourceLoader.create());
    var initialDoc = resourceLoader.getDocument("eurosport.tvml");
    navigationDocument.pushDocument(initialDoc);
    
    initialDoc.addEventListener("select", handleEvent);
    initialDoc.addEventListener("play", handleEvent);
};


class LoaderJS {
    
    // The constructor takes an instance of the native resource loader, saves it in a property and creates a DOMParser object.
    constructor(nativeResourceLoader) {
        this.nativeResourceLoader = nativeResourceLoader;
        this.domParser = new DOMParser();
    }
    
    // Read the specified file from the app bundle.
    getDocument(name) {
        var docString = this.nativeResourceLoader.loadBundleResource(name);
        return this.domParser.parseFromString(docString, "application/xml");
    }
}

// More information about streaming. Visit Apple's developer.apple.com/streaming.

function streaming(title, url) {
    
    // 1: player handles networking, decoding, user interface and interaction.
    var player = new Player();
    
    // 2: Please update for music streaming with 'audio' key.
    var video = new MediaItem('video', url);
    video.title = title;
    
    // 3: player requires a list of media items
    player.playlist = new Playlist();
    player.playlist.push(video);
    
    // 4: run.
    player.play();
}

function handleEvent(event) {
    var buttonId = event.target.getAttribute("id");
    
    // Event handling
    if(buttonId === "play") {
        streaming("Eurosport 2", "https://r.dcs.redcdn.pl/hls/o2/redefine/nlive/eurosport2_hd_1/1713/0/tv-ss/live.isml/playlist.m3u8");
    }
}

