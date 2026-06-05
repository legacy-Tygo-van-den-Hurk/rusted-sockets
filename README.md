# Rusted Sockets

This is just a project to work with unix sockets on Rust because I was curious how they work. I just made a client server application where clients sent strings to the server and then the server responds to the client in some way. This could be used to sent JSON back and forth for a daemon client setup or something like it.

## Example

I've made a quick example of what the program does:

### Client

This is an example of a client interaction:

```
$ cargo run --bin server
Reply: Connected as client 1
This is a test message
Reply: received from client 1: This is a test message
Another test message
Reply: received from client 1: Another test message
```

### Server

This is an example on what the server outputs:

```Text
$ cargo run --bin server
Listening on /tmp/rusted-sockets.sock
client 1 connected
Message from client 1: This is a test message
Message from client 1: Another test message
client 1 disconnected
```

## Build

To build use `Nix`:

```Shell
$ nix build 
```

or if you don't have "nix command" enabled:

```Shell
$ nix-build
```

Or grab `cargo` from the flake, and use it directly:

```Shell
$ nix develop
$ cargo build --release
```
