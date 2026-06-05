use std::fs;
use std::os::unix::net::UnixListener;
use std::io::{Read, Write};
use std::thread;
use rusted_sockets::SOCKET_PATH;

fn handle_client(
    id: usize, 
    mut stream: std::os::unix::net::UnixStream
) -> std::io::Result<()> {
    println!("client {id} connected");

    let welcome = format!("Connected as client {id}");
    stream.write_all(welcome.as_bytes())?;

    loop {
        let mut buf = [0u8; 1024];

        let size = match stream.read(&mut buf) {
            Ok(0) => break,
            Ok(n) => n,
            Err(_) => break,
        };

        let received = String::from_utf8_lossy(&buf[..size]);
        println!("Message from client {id}: {received}");

        let response = format!("received from client {id}: {received}");
        if stream.write_all(response.as_bytes()).is_err() {
            break;
        }
    }

    println!("client {id} disconnected");
    
    Ok(())
}

fn main() -> std::io::Result<()> {
    let _ = fs::remove_file(SOCKET_PATH);
    let listener = UnixListener::bind(SOCKET_PATH)?;
    println!("Listening on {SOCKET_PATH}");

    let mut id = 0;
    for stream in listener.incoming() {
        match stream {
            Err(err) => eprintln!("Connection failed: {err}"),
            Ok(stream) => {
                id += 1;
                let current_id = id;
                thread::spawn(move || {
                    if let Err(err) = handle_client(current_id, stream) {
                        println!("{err:?}");
                    };
                });
            },
        };
    };

    Ok(())
}
