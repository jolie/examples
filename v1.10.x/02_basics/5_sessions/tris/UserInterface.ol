type SyncPlacesRequest {
    places[9,9]: int
    message: string
    status_game: string( enum([ "play", "stay", "end" ]  ))
}

interface UserInterface {
    OneWay:
      syncPlaces( SyncPlacesRequest )
}
