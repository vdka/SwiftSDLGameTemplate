
- [ ] Wrap SDL_Event
- [ ] Real frame syncronization
- [ ] Smart logging. ie. In a loop dropping in a print("here") results in your terminal getting wrecked. This could be fixed by filtering logs by using a dictionary with the message as the key and the time it was last (successfully) logged. Basically rate limit it.
- [ ] Abstract away the passing of memory chunks. This would be best done with an _Adaptor_ layer for the dynamic code.

