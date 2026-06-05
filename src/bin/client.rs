use rusted_sockets::SOCKET_PATH;
use std::os::unix::net::UnixStream;
use std::io::{self, Write, BufRead, Read};

fn main() -> std::io::Result<()> {
    let mut stream = UnixStream::connect(SOCKET_PATH)?;
    let stdin = io::stdin();

    for line in stdin.lock().lines() {
        let input = line?;
        stream.write_all(input.trim().as_bytes())?;

        let mut buf = [0u8; 1024];
        let n = stream.read(&mut buf)?;
        println!("Reply: {}", String::from_utf8_lossy(&buf[..n]));
    }

    Ok(())
}