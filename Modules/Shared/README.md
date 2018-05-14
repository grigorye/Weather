Here is some reusable stuff that potentially is worth being included into a shared module.

As long as it is here, every module that needs it, should add the relevant .swift files into itself.

Hence it is expected (there're some exceptions though) that all stuff here has *internal* rather than *public* visibility. (Later if it's moved to the shared module, public (shared) stuff should be made public).
