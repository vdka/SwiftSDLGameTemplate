
- [ ] Wrap SDL_Event
- [x] Real frame syncronization
- [ ] Smart logging.
  - [x] Nicer looking logs with timestamps
  - [ ] Rate limitted logs (note ran into issue of passing the heap allocated `Dictionary` being deallocated)
  - [ ] Log destinations (maybe just ditch our logger and use `SwiftyBeaver`?)
- [x] Abstract away the passing of memory chunks.
- [ ] Detect changes and reload textures from `/assets`
