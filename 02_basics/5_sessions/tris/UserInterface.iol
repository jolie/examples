type SyncPlacesRequest: void {
    .places[9,9]: int
    .message: string
    .status_game: string // play | stay | end
}

interface UserInterface {
    OneWay:
      syncPlaces( SyncPlacesRequest )
}
