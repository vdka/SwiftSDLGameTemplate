
# Heap Stored objects

It appears that objects that are stored on the heap may not be _persisted easily_.
  This is likely due to ARC possibly deallocating their heap allocated memory as
  their reference count would drop to 0 between calls to `update`.

It may be possible to _cheat_ ARC by using swift's `Unmanaged` API. However, this 
  probably only work for class types as Unmanaged is limited to `AnyObject`
